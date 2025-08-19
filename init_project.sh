#!/bin/bash

echo "🚀 Flutter Project Setup Initialized"
echo "-------------------------------------"

# Run flutter pub get
echo "🔄 Running flutter pub get..."
flutter pub get

# Collect user input
read -p "📢 Enter your app name: " APP_NAME
read -p "📢 Enter your base package name (e.g., com.example.app): " PACKAGE_NAME
#read -p "📢 Enter this flutter folder name (e.g., flutter_automation): " DART_PACKAGE
read -p "📢 Enter path to app icon (optional, PNG 512x512): " ICON_PATH
read -p "📢 Enter comma-separated flavor names (e.g., dev,sit,uat,prod): " FLAVOR_INPUT

echo "✅ App Name: $APP_NAME"
echo "✅ Package Name: $PACKAGE_NAME"
DART_PACKAGE='flutter_automation'
echo "✅ Dart Import Name: $DART_PACKAGE"
[ -n "$ICON_PATH" ] && echo "✅ Icon Path: $ICON_PATH" || echo "Setting default icon..."
echo "✅ Flavors: $FLAVOR_INPUT"


# Parse flavors into array
IFS=',' read -ra FLAVORS <<< "$FLAVOR_INPUT"

# Rename app
if [ -n "$APP_NAME" ]; then
  echo "Renaming app to $APP_NAME..."
  flutter pub run rename setAppName --targets ios,android --value "$APP_NAME"
else
  APP_NAME='exampleapp'
  echo "Renaming app to $APP_NAME..."
  flutter pub run rename setAppName --targets ios,android --value "$APP_NAME"
  echo "Setting default app name."
fi

# Rename package
if [ -n "$PACKAGE_NAME" ]; then
  echo "Renaming bundle ID to $PACKAGE_NAME..."
  flutter pub run rename setBundleId --targets android --value "$PACKAGE_NAME"
else
  PACKAGE_NAME='com.example.app'
  echo "Renaming bundle ID to $PACKAGE_NAME..."
  flutter pub run rename setBundleId --targets android --value "$PACKAGE_NAME"
  echo "Setting default package name."
fi

# Launcher icon
if [ -n "$ICON_PATH" ]; then
  echo "Setting launcher icon..."
  cat > pubspec_launcher_icons.yaml <<EOL
flutter_icons:
  android: true
  ios: true
  image_path: "$ICON_PATH"
EOL
  flutter pub run flutter_launcher_icons:main -f pubspec_launcher_icons.yaml
  rm pubspec_launcher_icons.yaml
else
  echo "Setting default App icon...."
fi

# --------- Generate lib/flavor folder and config ---------
mkdir -p lib/config/flavor

# flavor_config.dart
FLAVOR_ENUMS=""
TITLE_SWITCH=""
IS_DEV_SWITCH=""
IS_APP_SWITCH=""
  # Remove existing blocks
# Remove flavorDimensions line
sed -i '' '/flavorDimensions/d' "$GRADLE_FILE"

# Remove entire productFlavors block
sed -i '' '/productFlavors {/,/}/d' "$GRADLE_FILE"

for FLAVOR in "${FLAVORS[@]}"; do
  FLAVOR_ENUMS+="$FLAVOR, "
  TITLE_SWITCH+="      case Flavor.$FLAVOR:
  return '$APP_NAME ${FLAVOR^^}';"

  if [[ "$FLAVOR" == "prod" ]]; then
    IS_DEV_SWITCH+="      case Flavor.$FLAVOR:
    return false;"
  else
    IS_DEV_SWITCH+="      case Flavor.$FLAVOR:
     return true;"
  fi

  IS_APP_SWITCH+="      case Flavor.$FLAVOR:
  return true;"
done

# shellcheck disable=SC2001
FLAVOR_ENUMS=$(echo "$FLAVOR_ENUMS" | sed 's/, $//')

cat > lib/config/flavor/flavor_config.dart <<EOL
enum Flavor {
  $FLAVOR_ENUMS
}

class FlavorConfig {
  static Flavor? appFlavor;

  static String get title {
    switch (appFlavor) {
$TITLE_SWITCH      default:
        return '$APP_NAME';
    }
  }

  static bool get isDevelopment {
    switch (appFlavor) {
$IS_DEV_SWITCH      default:
        return false;
    }
  }

  static bool get is$APP_NAME {
    switch (appFlavor) {
$IS_APP_SWITCH      default:
        return true;
    }
  }
}
EOL

echo " Generated lib/config/flavor/flavor_config.dart"

# --------- Create main entry for each flavor ----------
for FLAVOR in "${FLAVORS[@]}"; do
  FILE_PATH="lib/config/flavor/${FLAVOR}.dart"
  echo " Creating $FILE_PATH"
  cat > "$FILE_PATH" <<EOL
import 'flavor_config.dart';
import 'package:$DART_PACKAGE/main.dart' as app;

Future<void> main() async {
  FlavorConfig.appFlavor = Flavor.$FLAVOR;
  await app.main();
}
EOL
done

echo " Created entry point Dart files in lib/config/flavor/"

# --------- Update AndroidManifest.xml ----------
MANIFEST="android/app/src/main/AndroidManifest.xml"
if grep -q 'android:label=' "$MANIFEST"; then
  sed -i.bak 's/android:label="[^"]*"/android:label="@string\/app_name"/' "$MANIFEST"
    # Remove backup
  rm -f "${MANIFEST}.bak"
  echo " Updated AndroidManifest.xml label to @string/app_name"

else
  echo " android:label not found in AndroidManifest.xml"
fi

# --------- Update build.gradle.kts ----------
# Detect Gradle build file type
GRADLE_FILE=""
if [ -f android/app/build.gradle.kts ]; then
  GRADLE_FILE="android/app/build.gradle.kts"

  # Remove any existing flavor configs
  sed -i.bak '/flavorDimensions/d' "$GRADLE_FILE"
  sed -i.bak '/productFlavors {/,/^\s*}/d' "$GRADLE_FILE"

  # Remove backup
  rm -f "${GRADLE_FILE}.bak"

  # Build flavor block
  FLAVOR_BLOCK='        flavorDimensions += "flavor-type"\n'
  FLAVOR_BLOCK+='        productFlavors {\n'

  for FLAVOR in "${FLAVORS[@]}"; do
    FLAVOR_UPPER=$(echo "$FLAVOR" | tr '[:lower:]' '[:upper:]')
    if [[ "$FLAVOR" == "prod" ]]; then
      FLAVOR_BLOCK+="            create(\"$FLAVOR\") {\n"
      FLAVOR_BLOCK+='                dimension = "flavor-type"\n'
      FLAVOR_BLOCK+="                applicationId = \"$PACKAGE_NAME\"\n"
      FLAVOR_BLOCK+="                resValue(\"string\", \"app_name\", \"$APP_NAME\")\n"
      FLAVOR_BLOCK+="            }\n"
    else
      FLAVOR_BLOCK+="            create(\"$FLAVOR\") {\n"
      FLAVOR_BLOCK+='                dimension = "flavor-type"\n'
      FLAVOR_BLOCK+="                applicationId = \"$PACKAGE_NAME.$FLAVOR\"\n"
      FLAVOR_BLOCK+="                resValue(\"string\", \"app_name\", \"$APP_NAME $FLAVOR_UPPER\")\n"
      FLAVOR_BLOCK+="            }\n"
    fi
  done

  FLAVOR_BLOCK+='        }\n'

  # Insert flavor block before buildTypes
  awk -v block="$FLAVOR_BLOCK" '
    /buildTypes\s*{/ {
      print block
    }
    { print }
  ' "$GRADLE_FILE" > temp.gradle.kts && mv temp.gradle.kts "$GRADLE_FILE"

elif [ -f android/app/build.gradle ]; then
  GRADLE_FILE="android/app/build.gradle"
    # Remove any existing flavor configs
    sed -i.bak '/flavorDimensions/d' "$GRADLE_FILE"
    sed -i.bak '/productFlavors {/,/^\s*}/d' "$GRADLE_FILE"
      # Remove backup
      rm -f "${GRADLE_FILE}.bak"
   # Build flavor config
    FLAVOR_BLOCK='        flavorDimensions "flavor-type"\n'
    FLAVOR_BLOCK+='        productFlavors {\n'
    for FLAVOR in "${FLAVORS[@]}"; do
      FLAVOR_TRIMMED=$(echo "$FLAVOR" | xargs)
      if [[ "$FLAVOR_TRIMMED" == "prod" ]]; then
        FLAVOR_BLOCK+="            $FLAVOR_TRIMMED {\n"
        FLAVOR_BLOCK+='                dimension "flavor-type"\n'
        FLAVOR_BLOCK+="                applicationId \"$PACKAGE_NAME\"\n"
        FLAVOR_BLOCK+="                resValue \"string\", \"app_name\", \"$APP_NAME\"\n"
        FLAVOR_BLOCK+='            }\n'
      else
        FLAVOR_BLOCK+="            $FLAVOR_TRIMMED {\n"
        FLAVOR_BLOCK+='                dimension "flavor-type"\n'
        FLAVOR_BLOCK+="                applicationId \"$PACKAGE_NAME.$FLAVOR_TRIMMED\"\n"
        FLAVOR_BLOCK+="                resValue \"string\", \"app_name\", \"$APP_NAME ${FLAVOR_TRIMMED^^}\"\n"
        FLAVOR_BLOCK+='            }\n'
      fi
    done
    FLAVOR_BLOCK+='        }'

    # Inject into defaultConfig block
    awk -v config="$FLAVOR_BLOCK" '
      /defaultConfig\s*{/ { print; in_block = 1; next }
      in_block && /^\s*}/ {
        print config
        print
        in_block = 0
        next
      }
      { print }
    ' "$GRADLE_FILE" > tmp_gradle && mv tmp_gradle "$GRADLE_FILE"
else
  echo " No build.gradle or build.gradle.kts found in android/app/"
  exit 1
fi
echo " Updating namespace to $PACKAGE_NAME..."
sed -i "s/namespace\s*=.*/namespace = \"$PACKAGE_NAME\"/" "$GRADLE_FILE"
echo " Namespace updated to $PACKAGE_NAME"


echo " Configuring flavors in $GRADLE_FILE..."
echo " Flavors added to $GRADLE_FILE"
# User-provided or derived value
KOTLIN_DIR="android/app/src/main/kotlin"
PACKAGE_PATH="$(echo "$PACKAGE_NAME" | tr '.' '/')"
NEW_PACKAGE_DIR="$KOTLIN_DIR/$PACKAGE_PATH"

# 1. Remove the entire Kotlin folder (be careful!)
rm -rf "$KOTLIN_DIR"
echo " Cleared $KOTLIN_DIR"

# 2. Recreate Kotlin folder and correct package structure
mkdir -p "$NEW_PACKAGE_DIR"
echo " Created new package path: $NEW_PACKAGE_DIR"

# 3. Create MainActivity.kt with correct package name
cat > "$NEW_PACKAGE_DIR/MainActivity.kt" <<EOL
package $PACKAGE_NAME

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
}
EOL

echo " Created MainActivity.kt with correct package declaration"

git add .

MAIN_DART_FILE="lib/app.dart"

# Check if file exists
if [ -f "$MAIN_DART_FILE" ]; then
  # Replace any existing title value with FlavorConfig.title
  sed -i'' -E 's/(title\s*:\s*)["'\''][^"'\''"]*["'\'']/\1FlavorConfig.title/' "$MAIN_DART_FILE"

  echo "✅ Updated MaterialApp title to use FlavorConfig.title in $MAIN_DART_FILE"
else
  echo "❌ $MAIN_DART_FILE not found!"
fi
echo " Setup complete!"



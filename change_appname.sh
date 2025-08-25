#!/bin/bash

read -p "📢 Enter your app name: " APP_NAME

echo "✅ App Name: $APP_NAME"

echo "🔄 Running flutter pub get..."
flutter pub get

# Rename app in pubspec.yaml
if [ -n "$APP_NAME" ]; then
#  echo "📝 Updating pubspec.yaml name..."
#  sed -i "s/^name: .*/name: ${APP_NAME}/" pubspec.yaml

  echo "Renaming app to $APP_NAME..."
  flutter pub run rename setAppName --targets ios,android --value "$APP_NAME"
  # --------- Update AndroidManifest.xml ----------
  MANIFEST="android/app/src/main/AndroidManifest.xml"
  if grep -q 'android:label=' "$MANIFEST"; then
    sed -i.bak 's/android:label="[^"]*"/android:label="@string\/app_name"/' "$MANIFEST"
    rm -f "${MANIFEST}.bak"
    echo " Updated AndroidManifest.xml label to @string/app_name"
  else
    echo " android:label not found in AndroidManifest.xml"
  fi
else
  echo "⏭️ Skipping app name rename."
fi

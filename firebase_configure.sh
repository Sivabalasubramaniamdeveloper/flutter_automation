#!/bin/bash
read -p "Are you need to Initialize Firebase (Answer yes/no): " FIREBASE_OPTION


# shellcheck disable=SC1046
if [[ "$FIREBASE_OPTION" == "yes" || "$FIREBASE_OPTION" == "y" ]]; then
  echo "🔍 Checking Node.js installation..."

  # shellcheck disable=SC1073
  if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed!"
    echo "➡️ Please install Node.js from https://nodejs.org/"
    echo "💡 Or use this command on Windows with Chocolatey:"
    echo "   choco install nodejs -y"
    exit 1
  else
    echo "✅ Node.js version: $(node --version)"
  fi

  echo "🔍 Checking npm installation..."

  if ! command -v npm &> /dev/null; then
    echo "❌ npm is not installed!"
    echo "➡️ npm usually comes with Node.js. Reinstall Node.js from https://nodejs.org/"
    exit 1
  else
    echo "✅ npm version: $(npm --version)"
  fi

  echo "⚙️ Installing Firebase CLI globally..."
  npm install -g firebase-tools

  # shellcheck disable=SC2181
  if [ $? -eq 0 ]; then
    echo "✅ Firebase CLI installed successfully."
  else
    echo "❌ Firebase CLI installation failed!"
    exit 1
  fi

  echo "🔐 Logging into Firebase..."
  firebase login

  echo "⚙️ Configure flutterfire_cli"
  dart pub global activate flutterfire_cli
  echo "Take the project id give in firebase"

# Prompt for Firebase CLI command
read -p "📥 Paste the command to run (e.g., flutterfire configure --project=sivashop-95206): " FLUTTER_FIRE_CMD

# Check if command is provided
if [ -z "$FLUTTER_FIRE_CMD" ]; then
  echo "❌ No command provided. Exiting."
  exit 1
fi

# Run the command
echo "🚀 Running command: $FLUTTER_FIRE_CMD"
eval "$FLUTTER_FIRE_CMD"

# If command succeeded, update main.dart
if [ $? -eq 0 ]; then
  echo "✅ Firebase command executed successfully."

    flutter pub add firebase_core
    # Define the main Dart file path
    MAIN_DART_FILE="lib/main.dart"

    if ! grep -q "import 'firebase_options.dart';" "$MAIN_DART_FILE"; then
      sed -i "1i import 'firebase_options.dart';" "$MAIN_DART_FILE"
    fi
    rm -f "lib/main.dart.bak"

    echo "✅ Injected Firebase.initializeApp into \$MAIN_DART_FILE"


    echo "✅ Injected Firebase.initializeApp into $MAIN_DART_FILE"
    echo ""
    echo " Put this in your main function in main.dart file"
    echo '
             WidgetsFlutterBinding.ensureInitialized();
              await Firebase.initializeApp(
                options: DefaultFirebaseOptions.currentPlatform);
             '
  echo ''
  fi
else
  echo "⏩ Skipping Firebase initialization."
fi

read -p "📢 Enter path to app icon (optional, PNG 512x512): " ICON_PATH

[ -n "$ICON_PATH" ] && echo "✅ Icon Path: $ICON_PATH" || echo "❌ No icon provided"

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
  echo "️ Skipping icon setup."
fi
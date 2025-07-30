
read -p "📢 Enter your app name: " APP_NAME

echo "✅ App Name: $APP_NAME"

echo "🔄 Running flutter pub get..."
flutter pub get

# Rename app
if [ -n "$APP_NAME" ]; then
  echo "Renaming app to $APP_NAME..."
  flutter pub run rename setAppName --targets ios,android --value "$APP_NAME"
else
  echo " Skipping app name rename."
fi
#!/bin/bash
read -p "📢 Enter your base package name (e.g., com.example.app): " PACKAGE_NAME
echo "✅ Package Name: $PACKAGE_NAME"
# Rename package
if [ -n "$PACKAGE_NAME" ]; then
  echo "Renaming bundle ID to $PACKAGE_NAME..."
  flutter pub run rename setBundleId --targets android --value "$PACKAGE_NAME"
  flutter pub run rename setBundleId --targets ios --value "$PACKAGE_NAME"
else
  PACKAGE_NAME='com.example.app'
  echo "Renaming bundle ID to $PACKAGE_NAME..."
  flutter pub run rename setBundleId --targets android --value "$PACKAGE_NAME"
  flutter pub run rename setBundleId --targets ios --value "$PACKAGE_NAME"
  echo "Setting default package name."
fi
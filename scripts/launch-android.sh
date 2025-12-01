#!/bin/bash

# Script to launch Android emulator and run Flutter app

echo "🤖 Checking for Android emulators..."

cd apps/client

# Get list of emulators
EMULATORS=$(flutter emulators 2>/dev/null | grep -E '^\w+' | awk '{print $1}')

if [ -z "$EMULATORS" ]; then
    echo "❌ No Android emulators found."
    echo "Please create an emulator in Android Studio first."
    exit 1
fi

# Get the first emulator
FIRST_EMULATOR=$(echo "$EMULATORS" | head -n1)

echo "📱 Launching emulator: $FIRST_EMULATOR"
flutter emulators --launch "$FIRST_EMULATOR" > /dev/null 2>&1 &

echo "⏳ Waiting for emulator to start (15 seconds)..."
sleep 15

echo "🚀 Launching Flutter app..."
flutter run


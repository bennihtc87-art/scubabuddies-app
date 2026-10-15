#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
if ! command -v flutter >/dev/null 2>&1; then
  echo 'Flutter SDK fehlt. Installiere Flutter: https://docs.flutter.dev/get-started/install' >&2
  exit 1
fi
flutter create --platforms=android,ios --project-name scubabuddies --org de.scubabuddies .
flutter pub get
flutter analyze
printf '\nProjekt bereit. Geräte: flutter devices\nAndroid testen: flutter run\nAndroid APK: flutter build apk --debug\n'

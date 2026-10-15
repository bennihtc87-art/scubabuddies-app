# ScubaBuddies – Flutter WebView Test-App

Website: https://sfs-ys9jwtlw74mc.live-website.com/

## Voraussetzungen
- Flutter SDK (aktuelle stabile Version), Android Studio + Android SDK für Android
- macOS + Xcode + CocoaPods für iOS

## Einrichten
1. Dieses ZIP entpacken.
2. Terminal im entpackten Ordner öffnen.
3. macOS/Linux: `bash setup.sh`; Windows PowerShell: `flutter create --platforms=android,ios --project-name scubabuddies --org de.scubabuddies .` und dann `flutter pub get`.
4. `flutter doctor` ausführen und fehlende Komponenten installieren.
5. Android-Gerät oder Emulator anschließen: `flutter run`.
6. Test-APK: `flutter build apk --debug`. Datei: `build/app/outputs/flutter-apk/app-debug.apk`.
7. iOS nur auf macOS: `flutter run -d ios` (Simulator/Gerät mit Xcode-Konfiguration); alternativ `open ios/Runner.xcworkspace`.

## Wichtige Hinweise
- Dieses Archiv enthält den Flutter-Quellcode. Die nativen Ordner `android/` und `ios/` werden durch `flutter create` auf deinem Rechner generiert. Es ist noch keine APK/IPA enthalten.
- Bei Bedarf Android-Berechtigung prüfen: `android/app/src/main/AndroidManifest.xml` benötigt `<uses-permission android:name="android.permission.INTERNET" />` als Kind von `<manifest>` außerhalb von `<application>`. Flutter-Vorlagen unterscheiden sich nach SDK-Version; insbesondere bei Release-Builds prüfen.
- Die App verwendet eine WebView mit JavaScript. Login, Cookies, externe Authentifizierung, Uploads, Downloads, Kamera und Berechtigungen müssen auf echten Geräten geprüft und ggf. ergänzt werden.
- Links zu fremden Domains öffnen außerhalb der App. Wenn dein Login auf eine andere Domain weiterleitet, muss die Navigation angepasst werden.
- `SystemNavigator.pop()` schließt die Android-Ansicht, wenn kein WebView-Verlauf vorhanden ist; iOS-Navigation ist separat zu testen.
- Für die Veröffentlichung: eigener App-Mehrwert, Datenschutzerklärung, Store-Grafiken, Signierung und Plattformkonten erforderlich.
- Das Flutter-SDK ist in diesem Erstellungsumfeld nicht installiert. Der Code wurde deshalb nicht kompiliert oder auf Geräten getestet.

# ScubaBuddies APK nur mit Android-Handy bauen

1. ZIP herunterladen und in der Dateien-App entpacken.
2. Auf github.com einloggen, neues **öffentliches** Repository `scubabuddies-app` erstellen (bei privaten Repositories gelten ggf. Actions-Limits).
3. Repository öffnen → **Add file → Upload files**. Lade die Inhalte des entpackten Ordners hoch, **inklusive `.github/workflows/android-apk.yml`**. Achtung: Der mobile Browser blendet versteckte `.github`-Ordner ggf. aus. Falls das Hochladen ganzer Ordner nicht möglich ist, verwende die GitHub-Weboberfläche mit Desktopansicht und lege Dateien über **Add file → Create new file** an; Pfad exakt übernehmen.
4. Auf GitHub unter **Actions → Android Test APK → Run workflow** (Branch main) starten. Bei einem Push auf main startet der Build ebenfalls automatisch.
5. Nach grünem Haken den Lauf öffnen → **Artifacts → ScubaBuddies-Android-Test-APK** herunterladen (ZIP).
6. ZIP entpacken, `app-debug.apk` antippen, Installation aus dieser Quelle für den Dateimanager/Browser erlauben und installieren.
7. App öffnen und Startseite, Login, Navigation, Links testen. Bei Problemen GitHub Actions-Log prüfen.

Hinweise: Kein fertiges APK enthalten. Internet ist zum Laden der Website erforderlich. Diese Debug-APK ist nur für Tests; nicht für Play Store. OAuth-Login, Uploads und Downloads können weitere Anpassungen erfordern. Für spätere iOS-Builds ist ein macOS-Cloud-Runner plus Apple-Signierung erforderlich.

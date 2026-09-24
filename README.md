# Camillian Connect

A Flutter Android prototype for a private Camillian community network.

## Included in this prototype
- Private invitation/access-code login screen
- Member profile fields: photo, name, place, province/delegation/community, contact/biography/ministry placeholders
- Instagram-style home feed with reactions, comments/share UI
- Camillian News categories
- Provinces, delegations, communities, formation houses and ministries
- Events: retreats, conferences, chapters, feast days, formation and community events
- 13-language selector
- Private messaging entry point and announcements UI
- Admin dashboard UI
- Smooth page transitions, animated likes, rounded cards and visual styling based on the supplied Camillian artwork
- Supplied artwork included as `assets/camillian_hero.png`

## Demo access
`CAMILLUS2026`

## Important production security note
The demo access code is intentionally visible in the source so the prototype can be tested. It is NOT secure authentication.

For the real Camillian Connect release:
1. Use Firebase Authentication or another secure identity provider.
2. Store invitation/registration codes server-side and validate them with a Cloud Function/API.
3. Require administrator approval before activating a member.
4. Store posts/media/profile data in Firestore/Storage (or a secure backend).
5. Add role-based admin permissions.
6. Add account recovery through verified email/phone.
7. Add moderation/reporting and audit logs.
8. Use Firebase Cloud Messaging for announcements and notifications.
9. Add App Check and secure Firestore/Storage rules.
10. Complete translations using Flutter localization/ARB files.

## Build
Install Flutter and Android Studio/Android SDK, then:

```bash
flutter pub get
flutter run
flutter build apk --release
```

The release APK will normally be generated at:
`build/app/outputs/flutter-apk/app-release.apk`

## Phone-only APK build

If you only have an Android phone, you can build the APK using GitHub Actions from your phone:
1. Create a GitHub account and a new repository.
2. Upload the contents of this project to the repository.
3. Open the repository in Chrome.
4. Go to **Actions → Build Camillian Connect APK → Run workflow**.
5. Wait for the workflow to finish.
6. Open the completed workflow run and download the artifact named **camillian-connect-release-apk**.
7. Extract the ZIP and install `app-release.apk` on your phone.

The repository already contains `.github/workflows/build-apk.yml` for this process.

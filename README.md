# flutter_code_practical

A monorepo that builds two different applications. One app is the Simpsons Character Viewer, the other is The Wire Character Viewer.

## Running the app locally

To run the different variations of the app, be sure to go to the Run and Debug tab on the left in VS Code. There you can select the dropdown at the top and choose between "Launch simpsons" and "Launch the_wire".

### Run the apps via command line

flutter run --target lib/main_simpsons.dart --flavor simpsons
flutter run --target lib/main_the_wire.dart --flavor the_wire

## Building APK, IOS, and App Bundle

### APK

flutter build apk --target lib/main_simpsons.dart --flavor simpsons
flutter build apk --target lib/main_the_wire.dart --flavor the_wire

### iOS

flutter build ios --target lib/main_simpsons.dart --flavor simpsons
flutter build ios --target lib/main_the_wire.dart --flavor the_wire

### App Bundle

flutter build appbundle --target lib/main_simpsons.dart --flavor simpsons
flutter build appbundle --target lib/main_the_wire.dart --flavor the_wire

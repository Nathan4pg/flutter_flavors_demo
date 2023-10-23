# flutter_code_practical

A monorepo that builds two different applications. One app is the Simpsons Character Viewer, the other is The Wire Character Viewer.

## Running Different Flavors in VS Code

To run the different variations of the app, be sure to open VS Code > Run and Debug tab on the left in VS Code (Shift + CMD + D) > dropdown at the top. In said dropdwon you can choose between "Launch simpsons" and "Launch the_wire".

### Running Different Flavors in Terminal

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

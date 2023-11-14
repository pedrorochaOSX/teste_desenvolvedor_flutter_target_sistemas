# Teste desenvolvedor Flutter Target Sistemas

## Running the project

#### Install Flutter: [Install | Flutter](https://docs.flutter.dev/get-started/install)

#### Get project dependencies:
```bash
flutter pub get
```

#### Create the platforms directories you need:
```bash
flutter create --platforms=windows,macos,linux,android,ios,web .
```
The example above creates the windows, macos, linux, android, ios and web directories, if you want to create only a android directory, you should use:
```bash
flutter create --platforms=android .
```

#### Check the AndroidManifest.xml:
```bash
android\app\src\main\AndroidManifest.xml
```
To change your app name you need to set it in the "android:label" value here:
```bash
<application
        android:label="<your-app-name>"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher">
        <activity
        ...
```

#### Build the apk:
```bash
flutter build apk
```
You can get the apk file in:
```bash
\build\app\outputs\apk\release\
```
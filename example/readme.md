```
#!/bin/bash
set -e

echo delete android folder
#export START="/Users/adrianhill/Documents/Mega/dev/main/flutter/life_logging"
cd /Users/adrianhill/Documents/Mega/dev/main/flutter/life_logging
rm -rf android

echo set gradle version
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk use gradle 7.5

#flutter

echo flutter clean
flutter clean

echo flutter create
flutter create --org com.atreeon --platforms=android .
rm -rf test/widget_test.dart

echo launcher icons
flutter pub run flutter_launcher_icons

#app build.gradle

echo set compileSdkVersion in build.gradle
recreateAndroid/atreeon_find_replace -f android/app/build.gradle \
  -t "    compileSdkVersion 33" -i replace -r ".*compileSdkVersion.*"

echo set minSdkVersion in build.gradle
recreateAndroid/atreeon_find_replace -f android/app/build.gradle \
  -t "        minSdkVersion 33" -i replace -r ".*minSdkVersion.*"

echo set targetSdkVersion in build.gradle
recreateAndroid/atreeon_find_replace -f android/app/build.gradle \
  -t "        targetSdkVersion 33" -i replace -r ".*targetSdkVersion.*"

echo add google-services to build.gradle
recreateAndroid/atreeon_find_replace -f android/app/build.gradle \
  -t "apply plugin: 'com.google.gms.google-services'" -i after \
  -r ".*apply plugin.*"

echo add firebase dependencies to build.gradle
recreateAndroid/atreeon_find_replace -f android/app/build.gradle \
  -t "    implementation platform('com.google.firebase:firebase-bom:30.2.0')
    implementation 'com.google.firebase:firebase-analytics'" -i after \
  -r ".*implementation.*"

echo add signing code to build.gradle
recreateAndroid/atreeon_find_replace -f android/app/build.gradle \
  -r ".*apply plugin.*" \
  -t "def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}" \
  -i before

echo add signingConfigs to build.gradle
recreateAndroid/atreeon_find_replace -f android/app/build.gradle \
  -r ".*buildTypes.*" \
  -t "    signingConfigs {
             release {
                 keyAlias keystoreProperties['keyAlias']
                 keyPassword keystoreProperties['keyPassword']
                 storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
                 storePassword keystoreProperties['storePassword']
             }
         }" \
  -i before

echo add flavours to build.gradle
recreateAndroid/atreeon_find_replace -f android/app/build.gradle \
  -r ".*buildTypes.*" \
  -t "  flavorDimensions 'life_logging'
    productFlavors {
              dev {
                  dimension 'life_logging'
                  resValue 'string', 'app_name', 'Life Logging - dev'
                  versionNameSuffix '.dev'
              }
              prod {
                  dimension 'life_logging'
                  resValue 'string', 'app_name', 'Life Logging'
                  versionNameSuffix ''
              }
          }" \
  -i before

#project build.gradle

echo add google-services classpath to project build.gradle
recreateAndroid/atreeon_find_replace -f android/build.gradle \
  -i after \
  -r ".*dependencies.*" \
  -t "        classpath 'com.google.gms:google-services:4.3.13'"

#AndroidManifest.xml

echo change android:label in AndroidManifest.xml
recreateAndroid/atreeon_find_replace -f android/app/src/main/AndroidManifest.xml \
  -t "            android:label='Life Logging'" -i replace -r ".*android\:label.*"

echo set permissions in AndroidManifest.xml
recreateAndroid/atreeon_find_replace -f android/app/src/main/AndroidManifest.xml \
  -r ".*<application.*" \
  -t '      <uses-permission android:name="android.permission.FOREGROUND_SERVICE"/>
      <uses-permission android:name="android.permission.FOREGROUND_SERVICE_CAMERA"/>
      <uses-permission android:name="android.permission.CAMERA" />
      <uses-permission android:name="android.permission.WAKE_LOCK"/>
      <uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW"/>
      <uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>
      <uses-permission android:name="android.permission.REQUEST_IGNORE_BATTERY_OPTIMIZATIONS" />' \
  -i before

echo set foreground service in AndroidManifest.xml
recreateAndroid/atreeon_find_replace -f android/app/src/main/AndroidManifest.xml \
  -r ".*<activity.*" \
  -t "          <service
                       android:name='com.pravera.flutter_foreground_task.service.ForegroundService'
                       android:foregroundServiceType='camera'
                       android:stopWithTask='false' />" \
  -i before
```
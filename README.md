# atreeon_find_replace

I use this cli tool to replace or insert lines in my build.gradle and AndroidManifest.xml files.

## Simple Demo

see examples folder for more examples

`dart run atreeon_find_replace -f build/example/build.gradle -t "        targetSdkVersion 33" -i replace -r ".*targetSdkVersion.*"`


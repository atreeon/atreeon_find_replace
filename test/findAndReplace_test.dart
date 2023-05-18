import 'package:atreeon_find_replace/Config.dart';
import 'package:atreeon_find_replace/eInsertType.dart';
import 'package:atreeon_find_replace/findAndReplace.dart';
import 'package:test/test.dart';

void main() {
  test('findInLineAndInsertLine before', () {
    var input = """blah hello
something yo and
another thing here
...finally this""";

    var config = Config(eInsertType.insertBefore, 0, "", "INSERTED LINE", r'.*yo.*');
    var result = findAndReplace(config, input);

    var expected = """blah hello
INSERTED LINE
something yo and
another thing here
...finally this""";

    expect(result, expected);
  });

  test('findAndReplace after', () {
    var input = """blah hello
something yo and
another thing here
...finally this""";

    var config = Config(eInsertType.insertAfter, 0, "", "INSERTED LINE", r'.*yo.*');
    var result = findAndReplace(config, input);

    var expected = """blah hello
something yo and
INSERTED LINE
another thing here
...finally this""";

    expect(result, expected);
  });

  test('findInLineAndInsertLine replace', () {
    var input = """blah hello
something yo and
another thing here
...finally this""";

    var config = Config(eInsertType.replace, 0, "", "REPLACED LINE", r'.*yo.*');
    var result = findAndReplace(config, input);

    var expected = """blah hello
REPLACED LINE
another thing here
...finally this""";

    expect(result, expected);
  });

  test('findInLineAndReplaceLine2', () {
    var input = """apply from: "\$flutterRoot/packages/flutter_tools/gradle/flutter.gradle"

android {
    compileSdkVersion flutter.compileSdkVersion
    ndkVersion flutter.ndkVersion

    compileOptions {
        sourceCompatibility JavaVersion.VERSION_1_8
        targetCompatibility JavaVersion.VERSION_1_8
    }""";

    var config = Config(eInsertType.replace, 0, "", "    compileSdkVersion 33", r'.*compileSdkVersion.*');
    var result = findAndReplace(config, input);

    var expected = """apply from: "\$flutterRoot/packages/flutter_tools/gradle/flutter.gradle"

android {
    compileSdkVersion 33
    ndkVersion flutter.ndkVersion

    compileOptions {
        sourceCompatibility JavaVersion.VERSION_1_8
        targetCompatibility JavaVersion.VERSION_1_8
    }""";

    expect(result, expected);
  });

  test('findAndReplace 3nd Match', () {
    var input = """blah hello yo
something yo and
another yo thing here
...finally yo this""";

    var config = Config(eInsertType.insertAfter, 2, "", "INSERTED LINE", r'.*yo.*');
    var result = findAndReplace(config, input);

    var expected = """blah hello yo
something yo and
another yo thing here
INSERTED LINE
...finally yo this""";

    expect(result, expected);
  });
}

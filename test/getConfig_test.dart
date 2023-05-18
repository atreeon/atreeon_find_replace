import 'package:atreeon_find_replace/getConfig.dart';
import 'package:test/test.dart';
import 'package:atreeon_find_replace/eInsertType.dart';

void main() {
  test('config test', () {
    var config = getConfig(["-i", "before", "-n", "0", "-f", "file.txt", "-t", "text", "-r", "regex"])!;

    expect(config.regex, 'regex');
    expect(config.text, 'text');
    expect(config.filePath, 'file.txt');
    expect(config.nthMatch, 0);
    expect(config.insertType, eInsertType.insertBefore);
  });

}

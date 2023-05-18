import 'package:atreeon_find_replace/Config.dart';
import 'package:atreeon_find_replace/eInsertType.dart';

/// Find the nth match of the regex in the input string and
/// if [eInsertType] is replace then replaces it with the text
/// if before or after then we insert the text
String findAndReplace(Config config, String input) {
  var regex = RegExp(config.regex);
  var all = regex.allMatches(input).toList();
  var match = all[config.nthMatch];

  switch (config.insertType) {
    case eInsertType.insertBefore:
      return input.replaceRange(match.start, match.start, config.text + "\n");
    case eInsertType.insertAfter:
      return input.replaceRange(match.end, match.end, "\n" + config.text);
    case eInsertType.replace:
      return input.replaceRange(match.start, match.end, config.text);

    // return input.replaceFirst(regex, insertText);
    default:
      throw Exception("Unknown insert type");
  }
}

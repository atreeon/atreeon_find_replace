import 'package:args/args.dart';
import 'package:atreeon_find_replace/Config.dart';
import 'package:atreeon_find_replace/eInsertType.dart';

/// Processes the command line arguments and returns a [Config] object
Config? getConfig(List<String> arguments) {
  var parser = ArgParser();
  parser.addOption('insert_type', abbr: 'i', allowed: ['before', 'after', 'replace'], defaultsTo: 'after');
  parser.addOption('nth_match', abbr: 'n', allowed: ['0', '1', '2', '3', '4', '5', '6'], defaultsTo: '0');
  parser.addOption('file_path', abbr: 'f', mandatory: true);
  parser.addOption('text_new', abbr: 't', mandatory: true);
  parser.addOption('regex', abbr: 'r', mandatory: true);
  parser.addOption('help', abbr: 'h');

  var results = parser.parse(arguments);

  if(results['help'] != null) {
    print(parser.usage);
    return null;
  }

  var insertTypeStr = results['insert_type']! as String;

  late eInsertType insertType;
  switch (insertTypeStr) {
    case 'before':
      insertType = eInsertType.insertBefore;
      break;
    case 'after':
      insertType = eInsertType.insertAfter;
      break;
    case 'replace':
      insertType = eInsertType.replace;
      break;
    default:
      throw Exception("Unknown insert type");
  }
  var nthMatch = int.parse(results['nth_match']!);
  var filePath = results['file_path']! as String;
  var text = results['text_new']! as String;
  var regex = results['regex']! as String;

  return Config(insertType, nthMatch, filePath, text, regex);
}

import 'package:atreeon_find_replace/eInsertType.dart';

class Config {
  final eInsertType insertType;
  final int nthMatch;
  final String filePath;
  final String text;
  final String regex;

  Config(this.insertType, this.nthMatch, this.filePath, this.text, this.regex);
}

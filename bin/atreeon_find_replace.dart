import 'dart:io';

import 'package:atreeon_find_replace/findAndReplace.dart';
import 'package:atreeon_find_replace/getConfig.dart';

void main(List<String> arguments) async {
  var config = getConfig(arguments);

  if (config == null) {
    return;
  }

  var file = File(config.filePath);
  var fileContents = await file.readAsStringSync();
  var newFile = findAndReplace(config, fileContents);
  file.writeAsStringSync(newFile, mode: FileMode.write);
}

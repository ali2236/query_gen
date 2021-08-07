import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:http/http.dart';
import 'package:query_gen/query_gen.dart';

void main(List<String> arguments) async {
  final parser = ArgParser()
    ..addOption('partOf')
    ..addOption(
      'fromUrl',
      help: 'where can the OpenApi specifications can be downloaded from',
    )
    ..addOption(
      'fromFile',
      help: 'where can the OpenApi specifications can be read from',
    );

  final results = parser.parse(arguments);
  final fromUrl = results['fromUrl'];
  final fromFile = results['fromFile'];
  final partOf = results['partOf'];

  late String source;
  if (fromUrl != null) {
    var response = await get(Uri.parse(fromUrl));
    source = response.body;
  } else if (fromFile != null) {
    var file = File(fromFile);
    source = file.readAsStringSync();
  } else {
    throw 'no input';
  }
  output(partOf, source);
}

void output(String partOf, String source) {
  var json = jsonDecode(source);
  var query = QueryGenerator(json);
  var lib = query.generate(partOf);
  stdout.add(lib.codeUnits);
}

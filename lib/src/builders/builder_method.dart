import 'package:code_builder/code_builder.dart';

import '../Property.dart';

Method toJsonBuilder(Iterable<Property> properties) {
  return Method((b) => b
    ..name = 'toJson'
    ..lambda = true
    ..annotations.add(CodeExpression(Code('override')))
    ..returns = Reference('Map<String, dynamic>')
    ..body = Code(
        '{${properties.map(fieldToJsonPart).join()}}'));
}

String fieldToJsonPart(Property prop,{String ref = '', bool stringEntry = false}) {
  final name = prop.name;
  var value = name;
  var prefix = '';
  var postfix = '';
  if(prop.isRef){
    if(stringEntry){
       postfix = '.map((e) => e.toString()).toList()';
    } else {
      postfix = '.toJson()';
    }
  } else if (prop.type.symbol == 'DateTime') {
    postfix = '.toIso8601String()';
  } else if(stringEntry){
    postfix = '.toString()';
  }
  if(prop.nullable) prefix = 'if($ref$name != null)';
  return '$prefix\'$name\': $ref$value$postfix,';
}

Method apiEndpointBuilder() {
  return Method(
    (b) => b
      ..name = 'endpoint<Req extends JsonSerializable, Res>'
      ..returns = Reference('Endpoint<Req, Res>')
      ..optionalParameters.addAll([
        Parameter(
          (b) => b
            ..name = 'method'
            ..type = Reference('String')
            ..required = true
            ..named = true,
        ),
        Parameter(
          (b) => b
            ..name = 'uriBuilder'
            ..type = Reference('Uri Function(Req args)')
            ..required = true
            ..named = true,
        ),
        Parameter(
          (b) => b
            ..name = 'adapter'
            ..type = Reference('JsonParser<Res>')
            ..required = true
            ..named = true,
        ),
      ])
      ..body = Code('''
      return (Req args) async {
      final req = Request(method, uriBuilder(args));
      if (method == 'POST') req.body = jsonEncode(args.toJson());
      var streamedResponse = await send(req);
      var response = await Response.fromStream(streamedResponse);
      return QueryResponse(response, adapter);
    };
      '''),
  );
}

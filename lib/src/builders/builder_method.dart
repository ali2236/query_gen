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

String fieldToJsonPart(Property prop,{String ref = ''}) {
  final name = prop.name;
  var value = name;
  var prefix = '';
  if(prop.isRef){
    value = '$value.toJson()';
  } else if (prop.type.symbol == 'DateTime') {
    value = '$value.toIso8601String()';
  }
  if(prop.nullable) prefix = 'if($ref$name != null)';
  return '$prefix\'$name\': $ref$value,';
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

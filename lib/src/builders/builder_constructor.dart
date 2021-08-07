import 'package:code_builder/code_builder.dart';

import '../Property.dart';

Constructor namedConstructorBuilder(
  Iterable<Property> properties,
) {
  return Constructor(
    (b) => b
      ..constant = true
      ..optionalParameters.addAll(properties.map((e) => e.asConstructorParameter)),
  );
}

Constructor fromJsonFactoryBuilder(String name, Iterable<Property> properties) {
  return Constructor(
    (b) => b
      ..name = 'fromJson'
      ..factory = true
      ..lambda = true
      ..requiredParameters.add(Parameter((b) => b
        ..name = 'json'
        ..type = Reference('Map<String, dynamic>')))
      ..body = Code('$name(${properties.map(_readPropertyFromJsonCodePart).join()})'),
  );
}

String _readPropertyFromJsonCodePart(Property prop){
  final name = prop.name;
  final type = prop.type.symbol;
  var value = 'json[\'$name\']';
  if(prop.isRef){
    value = '$type.fromJson($value)';
  } else if(type == 'DateTime'){
    value = 'DateTime.tryParse($value)';
    if(!prop.nullable) value += '!';
  }
  return '$name:$value,';
}

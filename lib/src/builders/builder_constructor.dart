import 'package:code_builder/code_builder.dart';

import '../Property.dart';

Constructor namedConstructorBuilder(
  Iterable<Property> properties,
) {
  return Constructor(
    (b) => b
      ..constant = true
      ..optionalParameters
          .addAll(properties.map((e) => e.asConstructorParameter)),
  );
}

Constructor fromJsonFactoryBuilder(String name, Iterable<Property> properties) {
  return Constructor(
    (b) => b
      ..name = 'fromJson'
      ..factory = true
      ..requiredParameters.add(Parameter((b) => b
        ..name = 'json'
        ..type = Reference('Map')))
      ..body = Code(
          'return $name(${properties.map(_readPropertyFromJsonCodePart).join()});'),
  );
}

String _readPropertyFromJsonCodePart(Property prop) {
  final name = prop.name;
  final type = prop.type.symbol;
  var value = 'json[\'$name\']';
  if (prop.isRef) {
    if(!prop.nullable){
      value = '$type.fromJson($value)';
    } else {
      value = '$value != null ? $type.fromJson($value) : null';
      //value = 'json.containsKey(\'$name\') ? $type.fromJson($value) : null';
    }
  } else if (type == 'DateTime') {
    value = 'DateTime.tryParse($value)';
    if (!prop.nullable) value += '!';
  } else if (type!.contains('List')) {
    final listType = type.substring(type.indexOf('<') + 1, type.indexOf('>'));
    var convert = '';
    if (!typeMap.values.contains(listType.replaceAll('?', ''))) {
      convert = 'map((json) => $listType.fromJson(json)).';
    }
    value = '$value?.${convert}toList().cast<$listType>()';
  }
  return '$name:$value,';
}

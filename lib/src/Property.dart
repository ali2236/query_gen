import 'package:code_builder/code_builder.dart';

import 'json_object.dart';

const typeMap = {
  'integer': 'int',
  'number': 'double',
  'string': 'String',
  'array': 'List',
  'boolean': 'bool',
};

class Property {
  final String name;
  final bool nullableParameter;
  final JsonObject source;

  Property(this.name, this.source, {this.nullableParameter = false});

  String? get _ref => source[r'$ref'];

  bool get isRef => _ref != null;

  String? get _type => source['type'];

  String? get _format => source['format'];

  Map<String, dynamic>? get _items => source['items'];

  bool get nullable => source['nullable'] ?? nullableParameter;

  Reference get type {
    if (_type != null) return _fromType(_type!);
    if (isRef) return _fromRef(_ref!);
    return Reference('dynamic');
  }

  Reference _fromType(String type) {
    var dartType = typeMap[type];
    if (dartType == 'String' && _format != null && _format == 'date-time') {
      dartType = 'DateTime';
    }
    if (dartType == 'List' && _items != null) {
      var ref = _items![r'$ref'];
      var type = _items![r'type'];
      if (ref != null) {
        dartType = dartType! + '<${_fromRef(ref).symbol}>';
      } else {
        dartType = dartType! + '<${_fromType(type).symbol}>';
      }
    }
    if (nullable && dartType != null) dartType = dartType + '?';
    return Reference(dartType ?? 'dynamic');
  }

  Reference _fromRef(String ref) {
    final i = ref.lastIndexOf('/');
    var name = ref.substring(i + 1);
    return Reference(name);
  }

  Parameter get asParameter => Parameter((b) => b
    ..name = name
    ..type = type
    ..required = !nullable
    ..named = true);

  Parameter get asConstructorParameter => Parameter((b) => b
    ..name = 'this.$name'
    ..required = !nullable
    ..named = true);

  Field get asField => Field((b) => b
    ..name = name
    ..type = nullCheckedType
    ..modifier = FieldModifier.final$);

  Reference get nullCheckedType {
    var symbol = type.symbol!;
    if(!symbol.endsWith('?') && nullable){
      return Reference('$symbol?');
    }
    return Reference(symbol);
  }
}

import 'package:code_builder/code_builder.dart';
import 'package:query_gen/src/Property.dart';
import 'package:query_gen/src/builders/builder_class.dart';

import 'json_object.dart';

class Schema {
  final String name;
  final JsonObject source;

  Schema(this.name, this.source);

  JsonObject get _properties => source['properties'];

  Iterable<String>? get required => source['required']?.cast<String>();

  Iterable<Property>? get properties {
    var req = required?.toSet() ?? <String>{};
    return _properties.entries.map((e) => Property(e.key, e.value, nullableParameter: !req.contains(e.key)));
  }

  Class get asClass => serializableClassBuilder(name: name, properties: properties!);
}

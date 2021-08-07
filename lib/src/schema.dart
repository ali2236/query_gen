import 'package:code_builder/code_builder.dart';
import 'package:query_gen/src/Property.dart';
import 'package:query_gen/src/builders/builder_class.dart';

import 'json_object.dart';

class Schema {
  final String name;
  final JsonObject source;

  Schema(this.name, this.source);

  JsonObject get _properties => source['properties'];

  Iterable<Property>? get properties {
    return _properties.entries.map((e) => Property(e.key, e.value));
  }

  Class get asClass => serializableClassBuilder(name: name, properties: properties!);
}

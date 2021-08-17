import 'package:code_builder/code_builder.dart';
import 'package:query_gen/src/builders/builder_constructor.dart';
import 'package:query_gen/src/builders/builder_method.dart';

import '../Property.dart';

Class serializableClassBuilder({
  required String name,
  required Iterable<Property> properties,
}) {
  return Class(
    (b) => b
      ..name = name
      ..implements.add(Reference('JsonSerializable'))
      ..fields.addAll(properties.map((p) => p.asField))
      ..constructors.add(namedConstructorBuilder(properties))
      ..constructors.add(fromJsonFactoryBuilder(name, properties))
      ..methods.add(toJsonBuilder(properties)),
  );
}

Class emptySerializableClassBuilder({
  required String name,
}) {
  return Class((b) => b
    ..name = name
    ..mixins.add(Reference('EmptySerializable')));
}

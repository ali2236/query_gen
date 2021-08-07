import 'package:code_builder/code_builder.dart';
import 'package:query_gen/src/schema.dart';
import 'json_object.dart';

class Components {
  final JsonObject components;

  Components(this.components);

  Map<String, dynamic> get _schemas => components['schemas'] ?? {};

  Iterable<Schema>? get schemas {
    return _schemas.entries.map((e) {
      return Schema(e.key, e.value);
    });
  }

  Iterable<Spec> get spec => schemas?.map((e) => e.asClass) ?? [];
}

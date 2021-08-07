import 'package:code_builder/code_builder.dart';
import 'package:query_gen/src/builders/builder_mixin.dart';

import 'Path.dart';
import 'json_object.dart';

class Paths {
  final JsonObject source;

  Paths(this.source);

  Iterable<Path>? get paths sync* {
    for (var entry in source.entries) {
      for (var methodEntry in (entry.value as Map<String, dynamic>).entries) {
        yield Path(entry.key, methodEntry.key, methodEntry.value);
      }
    }
  }

  Iterable<Spec> get spec sync*{
    var _paths = paths!;
    yield clientMixinBuilder(_paths);
    yield* _paths.map((e) => e.requestClass);
    yield* _paths.map((e) => e.responseClass);
  }
}

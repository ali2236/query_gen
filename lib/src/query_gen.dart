import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:query_gen/src/components.dart';
import 'package:query_gen/src/paths.dart';

import 'builders/builder_code.dart';

class QueryGenerator {
  final Map<String, dynamic> source;

  QueryGenerator(this.source);

  Components get components => Components(source['components'] ?? {});

  Paths get paths => Paths(source['paths'] ?? {});

  String generate(String partOf) {
    final emitter = DartEmitter(
        useNullSafetySyntax: true,
        allocator: Allocator.simplePrefixing(),
        orderDirectives: true);
    final formatter = DartFormatter();
    final lib = Library((b) => b
      ..directives.add(Directive.partOf(partOf))
      ..body.add(endpointTypedefBuilder())
      ..body.add(jsonParserTypedefBuilder())
      ..body.add(queryResponseBuilder())
      ..body.add(jsonSerializableBuilder())
      ..body.add(emptySerializableBuilder())
      ..body.addAll(paths.spec)
      ..body.addAll(components.spec));
    return formatter.format('${lib.accept(emitter)}');
  }
}

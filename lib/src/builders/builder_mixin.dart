import 'package:code_builder/code_builder.dart';
import '../Path.dart';
import 'builder_method.dart';

Mixin clientMixinBuilder(Iterable<Path> paths) {
  return Mixin(
    (b) => b
      ..name = 'QueryClient'
      ..on = Reference('BaseClient')
      ..methods.add(Method((b) => b
        ..name = 'baseUrl'
        ..type = MethodType.getter
        ..returns = Reference('String')))
      ..methods.addAll(paths.map((e) => e.clientEndpoint))
      ..methods.add(apiEndpointBuilder()),
  );
}

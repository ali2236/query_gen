import 'package:code_builder/code_builder.dart';
import 'package:query_gen/src/PathParameter.dart';
import 'package:query_gen/src/Property.dart';
import 'package:query_gen/src/builders/builder_class.dart';

import 'builders/builder_method.dart';
import 'json_object.dart';

class Path {
  final String route;
  final String method;
  final JsonObject source;

  Path(this.route, this.method, this.source);

  String normalizedRoute(bool capitalizedMethod) {
    final builder =
        StringBuffer(capitalizedMethod ? method.capitalize() : method);
    var cap = false;
    for (var i = 0; i < route.length; i++) {
      var char = route[i];
      if (char == '/' || char == '-') {
        cap = true;
      } else if (char == '{') {
        builder.write('By');
        cap = true;
      } else if (char == '}') {
      } else {
        if (cap) {
          char = char.toUpperCase();
          cap = false;
        }
        builder.write(char);
      }
    }
    return builder.toString();
  }

  Iterable<String>? get tags => source['tags'];

  String get responseClassName => '${normalizedRoute(true)}Response';

  String get requestClassName => '${normalizedRoute(true)}Request';

  Reference get responseType => Reference(responseClassName);

  Reference get requestType => Reference(requestClassName);

  Iterable<PathParameter>? get requestParams {
    List? schema = source['parameters'];
    if (schema == null) return null;
    return schema.map((e) => PathParameter(e));
  }

  PathParameter? get responseParams {
    var schema = source['responses']?['200']?['content']?.entries.first.value;
    if (schema == null) return null;
    if (schema is! Map<String, dynamic>) return null;
    return PathParameter(schema);
  }

  Property? get requestBody {
    var schema = source['requestBody']?['content']?.entries.first.value;
    if (schema == null) return null;
    if (schema is! Map<String, dynamic>) return null;
    return PathParameter(schema);
  }

  Class get requestClass {
    var param = requestParams;
    var body = requestBody;
    return serializableClassBuilder(
      name: requestClassName,
      properties: [
        if (param != null) ...param,
        if (body != null) body,
      ],
    );
  }

  Method get clientEndpoint {
    final queryPrams = requestParams
        ?.where((e) => e.inQuery)
        .map((p) => fieldToJsonPart(p, ref: 'args.', stringEntry: true));
    return Method((b) => b
      ..name = normalizedRoute(false)
      ..lambda = true
      ..type = MethodType.getter
      ..returns = Reference('Endpoint<$requestClassName,$responseClassName>')
      ..body = Code('''
    endpoint<
    $requestClassName,
    $responseClassName>(
      method: \'${method.toUpperCase()}\',
      uriBuilder: (args) => Uri.parse(\'\$baseUrl${route.replaceAll('{', '\${args.')}\')
        ${queryPrams != null && queryPrams.isNotEmpty ? '.replace(queryParameters: {${queryPrams.join()}})' : ''},
      adapter: (json) => $responseClassName.fromJson(json),
    )'''));
  }

  Class get responseClass {
    var param = responseParams;
    return serializableClassBuilder(
      name: responseClassName,
      properties: param == null ? [] : [param],
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}

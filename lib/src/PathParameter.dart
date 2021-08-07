import 'package:query_gen/src/Property.dart';

import 'json_object.dart';

class PathParameter extends Property {

  PathParameter(JsonObject source)
      : super(
          source['name'] ?? 'body',
          source['schema'],
          nullableParameter: source['in'] == 'query',
        );

  bool get inQuery => source['in'] == 'query';
}

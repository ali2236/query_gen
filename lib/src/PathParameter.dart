import 'package:query_gen/src/Property.dart';

import 'json_object.dart';

class PathParameter extends Property {

  final JsonObject _source;

  PathParameter(this._source)
      : super(
          _source['name'] ?? 'body',
          _source['schema'],
          nullableParameter: _source['in'] == 'query',
        );

  bool get inQuery {
    return _source['in'] == 'query';
  }
}

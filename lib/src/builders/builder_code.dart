import 'package:code_builder/code_builder.dart';

Code endpointTypedefBuilder(){
  return Code('typedef Endpoint<Req, Res> = Future<QueryResponse<Res>> Function(Req args);');
}

Code jsonParserTypedefBuilder(){
  return Code('typedef JsonParser<T> = T Function(Map<String, dynamic> json);');
}

Code queryResponseBuilder(){
  return Code('''
  class QueryResponse<T> {
  final Response response;
  final JsonParser<T> parser;

  QueryResponse(this.response, this.parser);

  int get statusCode => response.statusCode;

  bool get isSuccess => statusCode >= 200 && statusCode < 300;

  bool get isError => response.statusCode >= 400;

  String get body => response.body;

  Map<String, dynamic> get json => jsonDecode(body);

  T get data => parser(json);
}
  ''');
}

Code jsonSerializableBuilder() {
  return Code('''
  abstract class JsonSerializable {
    Map<String, dynamic> toJson();
  }
  ''');
}

Code emptySerializableBuilder() {
  return Code('''
  mixin EmptySerializable implements JsonSerializable {
    @override
    Map<String, dynamic> toJson() => {};
  }
''');
}
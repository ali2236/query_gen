
import 'dart:convert';

import 'package:http/http.dart';
import 'package:query_gen/query_gen.dart';

void main() async{
  var source = jsonDecode((await get(Uri.parse('https://localhost:5001/swagger/v1/swagger.json'))).body);
  var query = QueryGenerator(source);
  print(query.generate('example.dart'));
}
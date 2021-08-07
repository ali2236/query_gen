# query_gen

Inspired by [rtk-query-codegen](https://github.com/rtk-incubator/rtk-query-codegen)

A CLI tool for generating models and HTTP client for Dart based on OpenApi Specs(json)

Generates Dart 2.12.0 code

This tool currently doesn't support All OpenApi Features (mainly no enum support)

### How To Use

First Activate it globally:
```
dart pub global activate code_gen
```

Then run it like this:

```
query_gen --partOf api.dart --fromUrl http://localhost:5000/swagger/v1/swagger.json > ./api.g.dart
```

You will need to Have to create a file to expose the generated code. for example like this:
```dart
// api.dart
library my_api;

import 'dart:convert';

import 'package:http/http.dart';

part 'api.g.dart';

class ApiClient extends BaseClient with QueryClient {
  final client = Client();

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    return client.send(request);
  }
}

```

You can customize `send` to add `caching`/`retrying`/`authentication`.
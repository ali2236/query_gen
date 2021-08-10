import 'dart:convert';

import 'package:query_gen/query_gen.dart';
import 'package:test/scaffolding.dart';

void main(){
  test('field', (){
      final source = r'''
      {
        "components" : {
          "schemas" : {
             "ApplicationDetails": {
        "required": [
          "createdAt",
          "downloadCount",
          "id",
          "packageId",
          "updatedAt",
          "valid",
          "viewCount",
          "visible"
        ],
        "type": "object",
        "properties": {
          "id": {
            "type": "integer",
            "format": "int32"
          },
          "packageId": {
            "type": "string"
          },
          "icon": {
            "type": "string",
            "nullable": true
          },
          "name": {
            "type": "string",
            "nullable": true
          },
          "developer": {
            "type": "string",
            "nullable": true
          },
          "developerEmail": {
            "type": "string",
            "nullable": true
          },
          "description": {
            "type": "string",
            "nullable": true
          },
          "visible": {
            "type": "boolean"
          },
          "valid": {
            "type": "boolean"
          },
          "downloadCount": {
            "type": "integer",
            "format": "int32"
          },
          "viewCount": {
            "type": "integer",
            "format": "int32"
          },
          "apk": {
            "$ref": "#/components/schemas/ApkDetails"
          },
          "pwa": {
            "$ref": "#/components/schemas/PwaDetails"
          },
          "categoryId": {
            "type": "integer",
            "format": "int32",
            "nullable": true
          },
          "categoryName": {
            "type": "string",
            "nullable": true
          },
          "screenShots": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/ScreenshotInfo"
            },
            "nullable": true
          },
          "createdAt": {
            "type": "string",
            "format": "date-time"
          },
          "updatedAt": {
            "type": "string",
            "format": "date-time"
          }
        },
        "additionalProperties": false
      }
          }
        }
      }
      ''';
      final json = jsonDecode(source);
      final result = QueryGenerator(json).generate('');
      print(result);
  });
}
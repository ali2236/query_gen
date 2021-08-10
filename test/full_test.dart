import 'dart:convert';

import 'package:query_gen/query_gen.dart';
import 'package:test/test.dart';

void main(){
  test('full', (){
    final source = r'''
    {
  "openapi": "3.0.1",
  "info": {
    "title": "AppStore",
    "version": "1.0"
  },
  "paths": {
    "/api/Android/{id}/download": {
      "get": {
        "tags": [
          "Android"
        ],
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          },
          {
            "name": "track",
            "in": "query",
            "schema": {
              "type": "boolean",
              "default": true
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Success"
          }
        }
      }
    },
    "/api/Android/check-update": {
      "post": {
        "tags": [
          "Android"
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/ApplicationCatelog"
              }
            },
            "text/json": {
              "schema": {
                "$ref": "#/components/schemas/ApplicationCatelog"
              }
            },
            "application/*+json": {
              "schema": {
                "$ref": "#/components/schemas/ApplicationCatelog"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Success",
            "content": {
              "text/plain": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/UpdateableApp"
                  }
                }
              },
              "application/json": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/UpdateableApp"
                  }
                }
              },
              "text/json": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/UpdateableApp"
                  }
                }
              }
            }
          }
        }
      }
    },
    "/api/Android/upload-apk": {
      "post": {
        "tags": [
          "Android"
        ],
        "requestBody": {
          "content": {
            "multipart/form-data": {
              "schema": {
                "type": "object",
                "properties": {
                  "file": {
                    "type": "string",
                    "format": "binary"
                  }
                }
              },
              "encoding": {
                "file": {
                  "style": "form"
                }
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Success",
            "content": {
              "text/plain": {
                "schema": {
                  "$ref": "#/components/schemas/ApplicationInfo"
                }
              },
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ApplicationInfo"
                }
              },
              "text/json": {
                "schema": {
                  "$ref": "#/components/schemas/ApplicationInfo"
                }
              }
            }
          }
        }
      }
    },
    "/api/Android/{id}/remove-apk": {
      "post": {
        "tags": [
          "Android"
        ],
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Success"
          }
        }
      }
    },
    "/api/Application": {
      "get": {
        "tags": [
          "Application"
        ],
        "parameters": [
          {
            "name": "Page",
            "in": "query",
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          },
          {
            "name": "PageSize",
            "in": "query",
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          },
          {
            "name": "q",
            "in": "query",
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "cat",
            "in": "query",
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          },
          {
            "name": "order",
            "in": "query",
            "schema": {
              "type": "string",
              "default": "name"
            }
          },
          {
            "name": "desc",
            "in": "query",
            "schema": {
              "type": "boolean",
              "default": true
            }
          },
          {
            "name": "valid",
            "in": "query",
            "schema": {
              "type": "boolean",
              "default": true
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Success",
            "content": {
              "text/plain": {
                "schema": {
                  "$ref": "#/components/schemas/ApplicationInfoPagination"
                }
              },
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ApplicationInfoPagination"
                }
              },
              "text/json": {
                "schema": {
                  "$ref": "#/components/schemas/ApplicationInfoPagination"
                }
              }
            }
          }
        }
      }
    },
    "/api/Application/{id}": {
      "get": {
        "tags": [
          "Application"
        ],
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          },
          {
            "name": "view",
            "in": "query",
            "schema": {
              "type": "boolean",
              "default": true
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Success",
            "content": {
              "text/plain": {
                "schema": {
                  "$ref": "#/components/schemas/ApplicationDetails"
                }
              },
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ApplicationDetails"
                }
              },
              "text/json": {
                "schema": {
                  "$ref": "#/components/schemas/ApplicationDetails"
                }
              }
            }
          }
        }
      }
    },
    "/api/Application/delete": {
      "post": {
        "tags": [
          "Application"
        ],
        "parameters": [
          {
            "name": "id",
            "in": "query",
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Success"
          }
        }
      }
    },
    "/api/Application/{id}/icon": {
      "post": {
        "tags": [
          "Application"
        ],
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "requestBody": {
          "content": {
            "multipart/form-data": {
              "schema": {
                "type": "object",
                "properties": {
                  "file": {
                    "type": "string",
                    "format": "binary"
                  }
                }
              },
              "encoding": {
                "file": {
                  "style": "form"
                }
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Success",
            "content": {
              "text/plain": {
                "schema": {
                  "type": "string"
                }
              },
              "application/json": {
                "schema": {
                  "type": "string"
                }
              },
              "text/json": {
                "schema": {
                  "type": "string"
                }
              }
            }
          }
        }
      }
    },
    "/api/Application/{id}/edit": {
      "post": {
        "tags": [
          "Application"
        ],
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/ApplicationBaseInfo"
              }
            },
            "text/json": {
              "schema": {
                "$ref": "#/components/schemas/ApplicationBaseInfo"
              }
            },
            "application/*+json": {
              "schema": {
                "$ref": "#/components/schemas/ApplicationBaseInfo"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Success"
          }
        }
      }
    },
    "/api/Category": {
      "get": {
        "tags": [
          "Category"
        ],
        "responses": {
          "200": {
            "description": "Success",
            "content": {
              "text/plain": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/Category"
                  }
                }
              },
              "application/json": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/Category"
                  }
                }
              },
              "text/json": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/Category"
                  }
                }
              }
            }
          }
        }
      }
    },
    "/api/Category/{id}": {
      "get": {
        "tags": [
          "Category"
        ],
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Success",
            "content": {
              "text/plain": {
                "schema": {
                  "$ref": "#/components/schemas/Category"
                }
              },
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Category"
                }
              },
              "text/json": {
                "schema": {
                  "$ref": "#/components/schemas/Category"
                }
              }
            }
          }
        }
      }
    },
    "/api/Category/add": {
      "post": {
        "tags": [
          "Category"
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/CategoryAdd"
              }
            },
            "text/json": {
              "schema": {
                "$ref": "#/components/schemas/CategoryAdd"
              }
            },
            "application/*+json": {
              "schema": {
                "$ref": "#/components/schemas/CategoryAdd"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Success",
            "content": {
              "text/plain": {
                "schema": {
                  "$ref": "#/components/schemas/Category"
                }
              },
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Category"
                }
              },
              "text/json": {
                "schema": {
                  "$ref": "#/components/schemas/Category"
                }
              }
            }
          }
        }
      }
    },
    "/api/Category/edit": {
      "post": {
        "tags": [
          "Category"
        ],
        "parameters": [
          {
            "name": "id",
            "in": "query",
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/CategoryEdit"
              }
            },
            "text/json": {
              "schema": {
                "$ref": "#/components/schemas/CategoryEdit"
              }
            },
            "application/*+json": {
              "schema": {
                "$ref": "#/components/schemas/CategoryEdit"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Success",
            "content": {
              "text/plain": {
                "schema": {
                  "$ref": "#/components/schemas/Category"
                }
              },
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Category"
                }
              },
              "text/json": {
                "schema": {
                  "$ref": "#/components/schemas/Category"
                }
              }
            }
          }
        }
      }
    },
    "/api/Category/delete": {
      "post": {
        "tags": [
          "Category"
        ],
        "parameters": [
          {
            "name": "id",
            "in": "query",
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Success"
          }
        }
      }
    },
    "/api/Files/{packageId}/{fileName}": {
      "get": {
        "tags": [
          "Files"
        ],
        "parameters": [
          {
            "name": "packageId",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "fileName",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Success"
          }
        }
      }
    },
    "/api/Screenshot/{id}": {
      "post": {
        "tags": [
          "Screenshot"
        ],
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "requestBody": {
          "content": {
            "multipart/form-data": {
              "schema": {
                "type": "object",
                "properties": {
                  "file": {
                    "type": "string",
                    "format": "binary"
                  }
                }
              },
              "encoding": {
                "file": {
                  "style": "form"
                }
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Success",
            "content": {
              "text/plain": {
                "schema": {
                  "$ref": "#/components/schemas/Screenshot"
                }
              },
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Screenshot"
                }
              },
              "text/json": {
                "schema": {
                  "$ref": "#/components/schemas/Screenshot"
                }
              }
            }
          }
        }
      }
    },
    "/api/Screenshot/{appId}/delete": {
      "post": {
        "tags": [
          "Screenshot"
        ],
        "parameters": [
          {
            "name": "appId",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          },
          {
            "name": "id",
            "in": "query",
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Success"
          }
        }
      }
    },
    "/api/Statistics/sizes/sum": {
      "get": {
        "tags": [
          "Statistics"
        ],
        "responses": {
          "200": {
            "description": "Success",
            "content": {
              "text/plain": {
                "schema": {
                  "$ref": "#/components/schemas/Int64SumReport"
                }
              },
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Int64SumReport"
                }
              },
              "text/json": {
                "schema": {
                  "$ref": "#/components/schemas/Int64SumReport"
                }
              }
            }
          }
        }
      }
    },
    "/api/Statistics/downloads/sum": {
      "get": {
        "tags": [
          "Statistics"
        ],
        "parameters": [
          {
            "name": "id",
            "in": "query",
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Success",
            "content": {
              "text/plain": {
                "schema": {
                  "$ref": "#/components/schemas/Int32SumReport"
                }
              },
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Int32SumReport"
                }
              },
              "text/json": {
                "schema": {
                  "$ref": "#/components/schemas/Int32SumReport"
                }
              }
            }
          }
        }
      }
    },
    "/api/Statistics/downloads": {
      "get": {
        "tags": [
          "Statistics"
        ],
        "parameters": [
          {
            "name": "from",
            "in": "query",
            "schema": {
              "type": "string",
              "format": "date-time"
            }
          },
          {
            "name": "to",
            "in": "query",
            "schema": {
              "type": "string",
              "format": "date-time"
            }
          },
          {
            "name": "applicationId",
            "in": "query",
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Success",
            "content": {
              "text/plain": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/DateTimeInt32KeyValuePair"
                  }
                }
              },
              "application/json": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/DateTimeInt32KeyValuePair"
                  }
                }
              },
              "text/json": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/DateTimeInt32KeyValuePair"
                  }
                }
              }
            }
          }
        }
      }
    },
    "/api/Statistics/views/sum": {
      "get": {
        "tags": [
          "Statistics"
        ],
        "parameters": [
          {
            "name": "id",
            "in": "query",
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Success",
            "content": {
              "text/plain": {
                "schema": {
                  "$ref": "#/components/schemas/Int32SumReport"
                }
              },
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Int32SumReport"
                }
              },
              "text/json": {
                "schema": {
                  "$ref": "#/components/schemas/Int32SumReport"
                }
              }
            }
          }
        }
      }
    },
    "/api/Statistics/views": {
      "get": {
        "tags": [
          "Statistics"
        ],
        "parameters": [
          {
            "name": "from",
            "in": "query",
            "schema": {
              "type": "string",
              "format": "date-time"
            }
          },
          {
            "name": "to",
            "in": "query",
            "schema": {
              "type": "string",
              "format": "date-time"
            }
          },
          {
            "name": "applicationId",
            "in": "query",
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Success",
            "content": {
              "text/plain": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/DateTimeInt32KeyValuePair"
                  }
                }
              },
              "application/json": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/DateTimeInt32KeyValuePair"
                  }
                }
              },
              "text/json": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/DateTimeInt32KeyValuePair"
                  }
                }
              }
            }
          }
        }
      }
    },
    "/api/User": {
      "get": {
        "tags": [
          "User"
        ],
        "responses": {
          "200": {
            "description": "Success",
            "content": {
              "text/plain": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/IdentityUser"
                  }
                }
              },
              "application/json": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/IdentityUser"
                  }
                }
              },
              "text/json": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/IdentityUser"
                  }
                }
              }
            }
          }
        }
      }
    },
    "/api/User/login": {
      "post": {
        "tags": [
          "User"
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/UserLogin"
              }
            },
            "text/json": {
              "schema": {
                "$ref": "#/components/schemas/UserLogin"
              }
            },
            "application/*+json": {
              "schema": {
                "$ref": "#/components/schemas/UserLogin"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Success",
            "content": {
              "text/plain": {
                "schema": {
                  "$ref": "#/components/schemas/JWTToken"
                }
              },
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/JWTToken"
                }
              },
              "text/json": {
                "schema": {
                  "$ref": "#/components/schemas/JWTToken"
                }
              }
            }
          }
        }
      }
    },
    "/api/User/register": {
      "post": {
        "tags": [
          "User"
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/UserRegister"
              }
            },
            "text/json": {
              "schema": {
                "$ref": "#/components/schemas/UserRegister"
              }
            },
            "application/*+json": {
              "schema": {
                "$ref": "#/components/schemas/UserRegister"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Success"
          }
        }
      }
    },
    "/api/User/remove": {
      "post": {
        "tags": [
          "User"
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/UserIdentity"
              }
            },
            "text/json": {
              "schema": {
                "$ref": "#/components/schemas/UserIdentity"
              }
            },
            "application/*+json": {
              "schema": {
                "$ref": "#/components/schemas/UserIdentity"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Success"
          }
        }
      }
    },
    "/api/User/change-password": {
      "post": {
        "tags": [
          "User"
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/UserPasswordChange"
              }
            },
            "text/json": {
              "schema": {
                "$ref": "#/components/schemas/UserPasswordChange"
              }
            },
            "application/*+json": {
              "schema": {
                "$ref": "#/components/schemas/UserPasswordChange"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Success"
          }
        }
      }
    },
    "/api/User/forgot": {
      "post": {
        "tags": [
          "User"
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/UserPasswordForgot"
              }
            },
            "text/json": {
              "schema": {
                "$ref": "#/components/schemas/UserPasswordForgot"
              }
            },
            "application/*+json": {
              "schema": {
                "$ref": "#/components/schemas/UserPasswordForgot"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Success"
          }
        }
      }
    },
    "/api/User/reset": {
      "post": {
        "tags": [
          "User"
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/UserPasswordReset"
              }
            },
            "text/json": {
              "schema": {
                "$ref": "#/components/schemas/UserPasswordReset"
              }
            },
            "application/*+json": {
              "schema": {
                "$ref": "#/components/schemas/UserPasswordReset"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Success"
          }
        }
      }
    },
    "/api/Web": {
      "post": {
        "tags": [
          "Web"
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/WebApplication"
              }
            },
            "text/json": {
              "schema": {
                "$ref": "#/components/schemas/WebApplication"
              }
            },
            "application/*+json": {
              "schema": {
                "$ref": "#/components/schemas/WebApplication"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Success",
            "content": {
              "text/plain": {
                "schema": {
                  "$ref": "#/components/schemas/ApplicationInfo"
                }
              },
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ApplicationInfo"
                }
              },
              "text/json": {
                "schema": {
                  "$ref": "#/components/schemas/ApplicationInfo"
                }
              }
            }
          }
        }
      }
    },
    "/api/Web/{id}/launch": {
      "get": {
        "tags": [
          "Web"
        ],
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Success"
          }
        }
      }
    },
    "/api/Web/{id}/add": {
      "post": {
        "tags": [
          "Web"
        ],
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/PwaDetails"
              }
            },
            "text/json": {
              "schema": {
                "$ref": "#/components/schemas/PwaDetails"
              }
            },
            "application/*+json": {
              "schema": {
                "$ref": "#/components/schemas/PwaDetails"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Success",
            "content": {
              "text/plain": {
                "schema": {
                  "$ref": "#/components/schemas/PWA"
                }
              },
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PWA"
                }
              },
              "text/json": {
                "schema": {
                  "$ref": "#/components/schemas/PWA"
                }
              }
            }
          }
        }
      }
    },
    "/api/Web/{id}/remove": {
      "post": {
        "tags": [
          "Web"
        ],
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Success"
          }
        }
      }
    }
  },
  "components": {
    "schemas": {
      "ApkDetails": {
        "required": [
          "buildNumber",
          "download",
          "lastUpdate",
          "size",
          "version"
        ],
        "type": "object",
        "properties": {
          "version": {
            "type": "string"
          },
          "buildNumber": {
            "type": "integer",
            "format": "int64"
          },
          "download": {
            "type": "string"
          },
          "size": {
            "type": "integer",
            "format": "int64"
          },
          "lastUpdate": {
            "type": "string",
            "format": "date-time"
          },
          "permissions": {
            "type": "array",
            "items": {
              "type": "string"
            },
            "nullable": true
          }
        },
        "additionalProperties": false
      },
      "ApkInfo": {
        "required": [
          "download",
          "size",
          "version"
        ],
        "type": "object",
        "properties": {
          "version": {
            "type": "string"
          },
          "download": {
            "type": "string"
          },
          "size": {
            "type": "integer",
            "format": "int64"
          }
        },
        "additionalProperties": false
      },
      "ApplicationBaseInfo": {
        "type": "object",
        "properties": {
          "name": {
            "maxLength": 120,
            "minLength": 1,
            "type": "string",
            "nullable": true
          },
          "visible": {
            "type": "boolean",
            "nullable": true
          },
          "categoryId": {
            "type": "integer",
            "format": "int32",
            "nullable": true
          },
          "developer": {
            "maxLength": 60,
            "type": "string",
            "nullable": true
          },
          "developerEmail": {
            "maxLength": 80,
            "type": "string",
            "format": "email",
            "nullable": true
          },
          "description": {
            "type": "string",
            "nullable": true
          }
        },
        "additionalProperties": false
      },
      "ApplicationCatelog": {
        "required": [
          "packages"
        ],
        "type": "object",
        "properties": {
          "packages": {
            "type": "object",
            "additionalProperties": {
              "type": "integer",
              "format": "int64"
            }
          }
        },
        "additionalProperties": false
      },
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
      },
      "ApplicationInfo": {
        "required": [
          "downloads",
          "id",
          "packageId",
          "views"
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
          "name": {
            "type": "string",
            "nullable": true
          },
          "developer": {
            "type": "string",
            "nullable": true
          },
          "icon": {
            "type": "string",
            "nullable": true
          },
          "category": {
            "type": "string",
            "nullable": true
          },
          "apk": {
            "$ref": "#/components/schemas/ApkInfo"
          },
          "pwaLink": {
            "type": "string",
            "nullable": true
          },
          "downloads": {
            "type": "integer",
            "format": "int32"
          },
          "views": {
            "type": "integer",
            "format": "int32"
          }
        },
        "additionalProperties": false
      },
      "ApplicationInfoPagination": {
        "type": "object",
        "properties": {
          "info": {
            "$ref": "#/components/schemas/IPagedList"
          },
          "page": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/ApplicationInfo"
            },
            "nullable": true
          }
        },
        "additionalProperties": false
      },
      "Category": {
        "required": [
          "id",
          "name"
        ],
        "type": "object",
        "properties": {
          "id": {
            "type": "integer",
            "format": "int32"
          },
          "name": {
            "maxLength": 60,
            "minLength": 2,
            "type": "string"
          }
        },
        "additionalProperties": false
      },
      "CategoryAdd": {
        "required": [
          "name"
        ],
        "type": "object",
        "properties": {
          "name": {
            "maxLength": 60,
            "minLength": 2,
            "type": "string"
          }
        },
        "additionalProperties": false
      },
      "CategoryEdit": {
        "required": [
          "name"
        ],
        "type": "object",
        "properties": {
          "name": {
            "maxLength": 60,
            "minLength": 2,
            "type": "string"
          }
        },
        "additionalProperties": false
      },
      "DateTimeInt32KeyValuePair": {
        "type": "object",
        "properties": {
          "key": {
            "type": "string",
            "format": "date-time",
            "readOnly": true
          },
          "value": {
            "type": "integer",
            "format": "int32",
            "readOnly": true
          }
        },
        "additionalProperties": false
      },
      "IdentityUser": {
        "type": "object",
        "properties": {
          "id": {
            "type": "string",
            "nullable": true
          },
          "userName": {
            "type": "string",
            "nullable": true
          },
          "normalizedUserName": {
            "type": "string",
            "nullable": true
          },
          "email": {
            "type": "string",
            "nullable": true
          },
          "normalizedEmail": {
            "type": "string",
            "nullable": true
          },
          "emailConfirmed": {
            "type": "boolean"
          },
          "passwordHash": {
            "type": "string",
            "nullable": true
          },
          "securityStamp": {
            "type": "string",
            "nullable": true
          },
          "concurrencyStamp": {
            "type": "string",
            "nullable": true
          },
          "phoneNumber": {
            "type": "string",
            "nullable": true
          },
          "phoneNumberConfirmed": {
            "type": "boolean"
          },
          "twoFactorEnabled": {
            "type": "boolean"
          },
          "lockoutEnd": {
            "type": "string",
            "format": "date-time",
            "nullable": true
          },
          "lockoutEnabled": {
            "type": "boolean"
          },
          "accessFailedCount": {
            "type": "integer",
            "format": "int32"
          }
        },
        "additionalProperties": false
      },
      "Int32SumReport": {
        "required": [
          "sum"
        ],
        "type": "object",
        "properties": {
          "sum": {
            "type": "integer",
            "format": "int32"
          }
        },
        "additionalProperties": false
      },
      "Int64SumReport": {
        "required": [
          "sum"
        ],
        "type": "object",
        "properties": {
          "sum": {
            "type": "integer",
            "format": "int64"
          }
        },
        "additionalProperties": false
      },
      "IPagedList": {
        "type": "object",
        "properties": {
          "pageCount": {
            "type": "integer",
            "format": "int32",
            "readOnly": true
          },
          "totalItemCount": {
            "type": "integer",
            "format": "int32",
            "readOnly": true
          },
          "pageNumber": {
            "type": "integer",
            "format": "int32",
            "readOnly": true
          },
          "pageSize": {
            "type": "integer",
            "format": "int32",
            "readOnly": true
          },
          "hasPreviousPage": {
            "type": "boolean",
            "readOnly": true
          },
          "hasNextPage": {
            "type": "boolean",
            "readOnly": true
          },
          "isFirstPage": {
            "type": "boolean",
            "readOnly": true
          },
          "isLastPage": {
            "type": "boolean",
            "readOnly": true
          },
          "firstItemOnPage": {
            "type": "integer",
            "format": "int32",
            "readOnly": true
          },
          "lastItemOnPage": {
            "type": "integer",
            "format": "int32",
            "readOnly": true
          }
        },
        "additionalProperties": false
      },
      "JWTToken": {
        "required": [
          "token"
        ],
        "type": "object",
        "properties": {
          "token": {
            "type": "string"
          }
        },
        "additionalProperties": false
      },
      "PWA": {
        "required": [
          "url"
        ],
        "type": "object",
        "properties": {
          "url": {
            "maxLength": 120,
            "type": "string"
          }
        },
        "additionalProperties": false
      },
      "PwaDetails": {
        "required": [
          "link"
        ],
        "type": "object",
        "properties": {
          "link": {
            "type": "string"
          }
        },
        "additionalProperties": false
      },
      "SavedFile": {
        "required": [
          "fileName",
          "size"
        ],
        "type": "object",
        "properties": {
          "fileName": {
            "type": "string"
          },
          "size": {
            "type": "integer",
            "format": "int64"
          },
          "link": {
            "type": "string",
            "nullable": true,
            "readOnly": true
          }
        },
        "additionalProperties": false
      },
      "Screenshot": {
        "required": [
          "id"
        ],
        "type": "object",
        "properties": {
          "id": {
            "type": "integer",
            "format": "int32"
          },
          "file": {
            "$ref": "#/components/schemas/SavedFile"
          }
        },
        "additionalProperties": false
      },
      "ScreenshotInfo": {
        "required": [
          "id",
          "link"
        ],
        "type": "object",
        "properties": {
          "id": {
            "type": "integer",
            "format": "int32"
          },
          "link": {
            "type": "string"
          }
        },
        "additionalProperties": false
      },
      "UpdateableApp": {
        "required": [
          "buildNumber",
          "id",
          "name",
          "packageId"
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
          "name": {
            "type": "string"
          },
          "buildNumber": {
            "type": "integer",
            "format": "int64"
          }
        },
        "additionalProperties": false
      },
      "UserIdentity": {
        "required": [
          "email"
        ],
        "type": "object",
        "properties": {
          "email": {
            "type": "string",
            "format": "email"
          }
        },
        "additionalProperties": false
      },
      "UserLogin": {
        "required": [
          "email",
          "password"
        ],
        "type": "object",
        "properties": {
          "email": {
            "type": "string",
            "format": "email"
          },
          "password": {
            "minLength": 4,
            "type": "string"
          }
        },
        "additionalProperties": false
      },
      "UserPasswordChange": {
        "required": [
          "newPassword",
          "oldPassword"
        ],
        "type": "object",
        "properties": {
          "oldPassword": {
            "minLength": 4,
            "type": "string"
          },
          "newPassword": {
            "minLength": 4,
            "type": "string"
          }
        },
        "additionalProperties": false
      },
      "UserPasswordForgot": {
        "required": [
          "email",
          "resetHandler"
        ],
        "type": "object",
        "properties": {
          "email": {
            "type": "string",
            "format": "email"
          },
          "resetHandler": {
            "type": "string"
          }
        },
        "additionalProperties": false
      },
      "UserPasswordReset": {
        "required": [
          "email",
          "newPassword",
          "token"
        ],
        "type": "object",
        "properties": {
          "email": {
            "type": "string",
            "format": "email"
          },
          "token": {
            "type": "string"
          },
          "newPassword": {
            "minLength": 4,
            "type": "string"
          }
        },
        "additionalProperties": false
      },
      "UserRegister": {
        "required": [
          "email",
          "password"
        ],
        "type": "object",
        "properties": {
          "email": {
            "type": "string",
            "format": "email"
          },
          "password": {
            "minLength": 4,
            "type": "string"
          }
        },
        "additionalProperties": false
      },
      "WebApplication": {
        "required": [
          "link",
          "name",
          "packageId"
        ],
        "type": "object",
        "properties": {
          "packageId": {
            "maxLength": 120,
            "minLength": 3,
            "type": "string"
          },
          "link": {
            "maxLength": 120,
            "minLength": 3,
            "type": "string"
          },
          "name": {
            "maxLength": 120,
            "minLength": 1,
            "type": "string"
          }
        },
        "additionalProperties": false
      }
    },
    "securitySchemes": {
      "Bearer": {
        "type": "apiKey",
        "description": "JWT Authorization header using the Bearer scheme. Example: \"Authorization: Bearer {token}\"",
        "name": "Authorization",
        "in": "header"
      }
    }
  },
  "security": [
    {
      "Bearer": [ ]
    }
  ]
}
    ''';
    final json = jsonDecode(source);
    final result = QueryGenerator(json).generate('');
    print(result);
  });
}
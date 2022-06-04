enum JsonPatchOperation { add, replace, remove, move, copy, test }

class JsonPatchObject {
  JsonPatchObject({required this.op, required this.path, this.value, this.from});

  final JsonPatchOperation op;
  final String path;
  final String? value;
  final String? from;

  static JsonPatchObject addPatch(String path, String value) {
    return JsonPatchObject(op: JsonPatchOperation.add, path: path, value: value);
  }

  static JsonPatchObject replacePatch(String path, String value) {
    return JsonPatchObject(op: JsonPatchOperation.replace, path: path, value: value);
  }

  static JsonPatchObject testPatch(String path, String value) {
    return JsonPatchObject(op: JsonPatchOperation.test, path: path, value: value);
  }

  static JsonPatchObject movePatch(String path, String from) {
    return JsonPatchObject(op: JsonPatchOperation.move, path: path, from: from);
  }

  static JsonPatchObject copyPatch(String path, String from) {
    return JsonPatchObject(op: JsonPatchOperation.copy, path: path, from: from);
  }

  static JsonPatchObject removePatch(String path, String value) {
    return JsonPatchObject(op: JsonPatchOperation.remove, path: path);
  }

  Map<String, dynamic> toJson() {
    switch (op) {
      case JsonPatchOperation.add:
      case JsonPatchOperation.replace:
      case JsonPatchOperation.test:
        return <String, dynamic>{
          'op': op.name,
          'path': path,
          'value': value,
        };
      case JsonPatchOperation.copy:
      case JsonPatchOperation.move:
        return <String, dynamic>{
          'op': op.name,
          'path': path,
          'from': from,
        };
      case JsonPatchOperation.remove:
        return <String, dynamic>{
          'op': op.name,
          'path': path,
        };
    }
  }
}

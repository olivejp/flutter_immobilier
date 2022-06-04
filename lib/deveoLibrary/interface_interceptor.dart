import 'package:http/http.dart' as http;

abstract class InterfaceInterceptor {
  Future<Object?> catchResponse(http.Response? response);
}

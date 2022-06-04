import 'dart:io';

abstract class InterfaceDefaultHeaders {
  Map<String, String>? getDefaultHeaders();
}

class AuthorizationHeaders implements InterfaceDefaultHeaders {
  String? _authorizationHeader;

  void setAuthorizationHeader(String? authorization) {
    _authorizationHeader = authorization;
  }

  @override
  Map<String, String>? getDefaultHeaders() {
    if (_authorizationHeader != null) {
      return {HttpHeaders.authorizationHeader: _authorizationHeader!};
    }
    return null;
  }
}

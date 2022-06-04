import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../deveoLibrary/interface_interceptor.dart';
import '../service/service_toast.dart';

class HttpInterceptor implements InterfaceInterceptor {
  final ServiceToast serviceToast = GetIt.I.get();

  @override
  Future<Object?> catchResponse(http.Response? response) {
    if (response != null) {
      switch (response.statusCode) {
        case 500:
          serviceToast.addToast(
            message: "Une erreur serveur est survenue.",
            level: ToastLevel.error,
            iconData: Icons.error_rounded,
          );
          break;
        case 400:
          serviceToast.addToast(
            message: response.body,
            level: ToastLevel.error,
          );
          final dynamic body = jsonDecode(utf8.decode(response.bodyBytes));
          final String? type = body['type'];
          if (type != null && type == 'ContraintsValidationError') {
            final String? errors = body['error'];
            return Future.error(errors!);
          }
          break;
      }
    }
    return Future.value("");
  }
}

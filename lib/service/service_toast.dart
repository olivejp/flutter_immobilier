import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum ToastLevel { info, warn, error, success }

class Toast {
  Toast({this.title, required this.message, this.icon, required this.level, required this.duration});

  final String? title;
  final String message;
  final IconData? icon;
  final ToastLevel level;
  final DateTime creationDate = DateTime.now();
  final Duration duration;
}

class ServiceToast {
  final List<Toast> _toasts = [];
  final Duration _defaultDuration = const Duration(seconds: 5);
  final StreamController<List<Toast>> streamController = StreamController.broadcast();

  ServiceToast() {
    Timer.periodic(const Duration(seconds: 1), handleTimeout);
  }

  void handleTimeout(Timer timer) {
    _toasts.removeWhere((element) => DateTime.now().isAfter(element.creationDate.add(element.duration)));
    streamController.sink.add(_toasts);
  }

  void addToast(
      {String? title, required String message, required ToastLevel level, IconData? iconData, Duration? duration}) {
    _toasts.add(Toast(
      title: title,
      message: message,
      level: level,
      icon: iconData,
      duration: duration ?? _defaultDuration,
    ));
    streamController.sink.add(_toasts);
  }

  Stream<List<Toast>> getToast() {
    return streamController.stream;
  }
}

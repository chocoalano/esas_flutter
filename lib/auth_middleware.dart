import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final GetStorage getstorage = GetStorage();
    var token = getstorage.read<String>('token');
    if (token == null || token.isEmpty) {
      return const RouteSettings(name: '/login');
    }
    return null;
  }
}

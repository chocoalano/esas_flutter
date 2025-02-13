import 'dart:convert';

import '../../models/notification/notification_model.dart';
import '../base_http_services.dart';

class ApiInbox extends BaseHttpService {
  final prefix = "/notification";

  Future<List<NotificationModel>> fetchPaginate(int page, int limit) async {
    final response = await getRequest('$prefix?page=$page&limit=$limit');
    final data = jsonDecode(response.body);
    if (data['data']['data'] != null && data['data']['data'].length > 0) {
      return List<NotificationModel>.from(
          data['data']['data'].map((e) => NotificationModel.fromJson(e)));
    } else {
      return [];
    }
  }

  Future<dynamic> isread(String id) async {
    final response = await getRequest('$prefix/$id');
    return response.statusCode;
  }

  Future<dynamic> clear() async {
    final response = await postRequest(prefix, {});
    return response.statusCode;
  }
}

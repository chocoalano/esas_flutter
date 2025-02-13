import 'dart:convert';

import '../../../models/announcement/detail.dart';
import '../../base_http_services.dart';

class ApiBeranda extends BaseHttpService {
  final prefix = "/announcement";
  Future<dynamic> testNotifRequest() async {
    return await getRequest('/mobile/test-notif');
  }

  Future<List<Detail>> announcementRequest(int page, int limit) async {
    final response =
        await getRequest('$prefix?page=$page&limit=$limit&search=');
    final data = jsonDecode(response.body)['data']['data'];
    if (data != null && data.length > 0) {
      return List<Detail>.from(data.map((e) => Detail.fromJson(e)));
    } else {
      return [];
    }
  }

  Future<Detail> announcementRequestDetail(int id) async {
    final response = await getRequest('$prefix/$id');
    final data = jsonDecode(response.body)['data'];
    return Detail.fromJson(data);
  }
}

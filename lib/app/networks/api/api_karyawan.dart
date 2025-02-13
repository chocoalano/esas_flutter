import 'dart:convert';

import '../../models/users/user_view.dart';
import '../base_http_services.dart';

class ApiKaryawan extends BaseHttpService {
  final prefix = "/user";
  Future<List<UserView>> fetchList(int page, int limit, String search) async {
    final response =
        await getRequest('$prefix?page=$page&limit=$limit&search=$search');
    final data = jsonDecode(response.body)['data']['data'];
    if (data != null && data.length > 0) {
      return List<UserView>.from(data.map((e) => UserView.fromJson(e)));
    } else {
      return [];
    }
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';

import '../../../models/Permit/permit_list.dart';
import '../../../models/Permit/permit_type.dart';
import '../../base_http_services.dart';
import 'package:http/http.dart' as http;

class ApiPermit extends BaseHttpService {
  final prefix = "/permit";
  Future<List<PermitType>> listType() async {
    final response = await getRequest('$prefix-type');
    final data = jsonDecode(response.body)['data'];
    if (data != null && data.length > 0) {
      return List<PermitType>.from(data.map((e) => PermitType.fromJson(e)));
    } else {
      return [];
    }
  }

  Future<List<PermitList>> listPermit(
      int page, int limit, String search, int permitId) async {
    final response = await getRequest(
        '$prefix?page=$page&limit=$limit&search=$search&type=$permitId');
    final data = jsonDecode(response.body)['data']['data'];
    if (data != null && data.length > 0) {
      if (kDebugMode) {
        print("===================>>>>> list data permit paginate : $data");
      }
      return List<PermitList>.from(data.map((e) => PermitList.fromJson(e)));
    } else {
      return [];
    }
  }

  Future<dynamic> saveSubmit(Map<String, dynamic> datapost, File file) async {
    http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
      'file',
      file.path,
    );
    final response =
        await postFormDataRequest('/permit', datapost, [multipartFile]);
    return response;
  }

  Future<dynamic> saveSubmitNotFile(Map<String, dynamic> datapost) async {
    final response = await postRequest('/permit', datapost);
    return response;
  }

  Future<dynamic> approval(int id, String status, String notes) async {
    final datapost = {"approve": status, "notes": notes};
    return await putRequest('$prefix/$id', datapost);
  }

  Future<dynamic> detailPermit(int id) async {
    return await getRequest('$prefix/$id');
  }
}

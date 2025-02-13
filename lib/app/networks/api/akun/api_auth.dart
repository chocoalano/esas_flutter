import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../../models/Tools/bug_reports.dart';
import '../../../models/auth/work_schedule.dart';
import '../../base_http_services.dart';

class ApiAuth extends BaseHttpService {
  Future<List<BugReports>> bugReportsList(
      int page, int limit, String search) async {
    final response =
        await getRequest('/bug-report?page=$page&limit=$limit&search=$search');
    final data = jsonDecode(response.body)['data']['data'];
    if (data != null && data.length > 0) {
      return List<BugReports>.from(data.map((e) => BugReports.fromJson(e)));
    } else {
      return [];
    }
  }

  Future<dynamic> saveSubmitBugReports(
      Map<String, dynamic> datapost, File file) async {
    http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
      'image',
      file.path,
    );
    final response =
        await postFormDataRequest('/bug-report', datapost, [multipartFile]);
    return response.statusCode;
  }

  Future<dynamic> saveChangeAvatar(
      Map<String, dynamic> datapost, File file) async {
    http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
      'avatar',
      file.path,
    );
    final response = await postFormDataRequest(
        '/auth/profile-avatar', datapost, [multipartFile]);
    return response.statusCode;
  }

  Future<dynamic> getProfileDisplay() async {
    return await getRequest('/auth/profile-display');
  }

  Future<dynamic> getProfile() async {
    return await getRequest('/auth/profile');
  }

  Future<dynamic> getSetting() async {
    return await getRequest('/auth/setting');
  }

  Future<dynamic> submitLogin(Map<String, dynamic> datapost) async {
    return await postRequest('/auth/login', datapost);
  }

  Future<dynamic> setImei(Map<String, dynamic> datapost) async {
    return await postRequest('/auth/set-imei', datapost);
  }

  Future<dynamic> submitLogout(Map<String, dynamic> datapost) async {
    return await postRequest("/auth/logout", datapost);
  }

  Future<dynamic> saveSubmitBank(Map<String, dynamic> datapost) async {
    return await postRequest('/auth/profile-update-bank', datapost);
  }

  Future<dynamic> saveSubmitPassword(Map<String, dynamic> datapost) async {
    return await postRequest('/auth/profile-update-password', datapost);
  }

  Future<dynamic> setDeviceToken(Map<String, dynamic> datapost) async {
    return await postRequest('/auth/store-device-token', datapost);
  }

  Future<dynamic> saveFamily(List<Map<String, dynamic>> datapost) async {
    return await postListRequest('/auth/profile-update-family', datapost);
  }

  Future<dynamic> saveFormalEducation(
      List<Map<String, dynamic>> datapost) async {
    return await postListRequest(
        '/auth/profile-update-formal-education', datapost);
  }

  Future<dynamic> saveInformalEducation(
      List<Map<String, dynamic>> datapost) async {
    return await postListRequest(
        '/auth/profile-update-informal-education', datapost);
  }

  Future<dynamic> saveWorkExperience(
      List<Map<String, dynamic>> datapost) async {
    return await postListRequest(
        '/auth/profile-update-work-experience', datapost);
  }

  Future<List<WorkSchedule>> listJadwalKerja() async {
    final response = await getRequest('/auth/profile-schedule-list');
    final data = jsonDecode(response.body)['data'];
    if (data != null && data.length > 0) {
      return List<WorkSchedule>.from(data.map((e) => WorkSchedule.fromJson(e)));
    } else {
      return [];
    }
  }
}

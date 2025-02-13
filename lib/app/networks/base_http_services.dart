import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../constant.dart';

class BaseHttpService {
  final GetStorage getLocalStorage = GetStorage();
  final String baseUrl = baseUrlApi;
  final Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
  };

  // Interceptor untuk menambahkan token ke dalam header setiap request
  Future<Map<String, String>> _buildHeaders() async {
    final token = getLocalStorage.read<String>('token');
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
  }

  // Interceptor untuk menghandle request GET
  Future<http.Response> getRequest(String endpoint) async {
    final Uri url = Uri.parse('$baseUrl$endpoint');
    final headers = await _buildHeaders();
    try {
      final response = await http.get(url, headers: headers);
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  // Interceptor untuk menghandle request POST
  Future<http.Response> postListRequest(
      String endpoint, List<Map<String, dynamic>> body) async {
    final Uri url = Uri.parse('$baseUrl$endpoint');
    final headers = await _buildHeaders();
    try {
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  // Interceptor untuk menghandle request POST
  Future<http.Response> postRequest(
      String endpoint, Map<String, dynamic> body) async {
    final Uri url = Uri.parse('$baseUrl$endpoint');
    final headers = await _buildHeaders();
    try {
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  // Interceptor untuk menghandle request PUT
  Future<http.Response> putRequest(
      String endpoint, Map<String, dynamic> body) async {
    final Uri url = Uri.parse('$baseUrl$endpoint');
    final headers = await _buildHeaders();
    try {
      final response = await http.put(
        url,
        headers: headers,
        body: jsonEncode(body),
      );
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  // Interceptor untuk menghandle request dengan form-data (POST dan PUT)
  Future<http.Response> postFormDataRequest(
    String endpoint,
    Map<String, dynamic> fields,
    List<http.MultipartFile> files,
  ) async {
    final Uri url = Uri.parse('$baseUrl$endpoint');
    final headers = await _buildHeaders();
    try {
      var request = http.MultipartRequest('POST', url);
      request.headers.addAll(headers);
      fields.forEach((key, value) {
        request.fields[key] = value;
      });
      request.files.addAll(files);
      final response = await request.send();
      return await http.Response.fromStream(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  // Interceptor untuk request DELETE
  Future<http.Response> deleteRequest(String endpoint) async {
    final Uri url = Uri.parse('$baseUrl$endpoint');
    final headers = await _buildHeaders();
    try {
      final response = await http.delete(url, headers: headers);
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  // Penanganan respons secara global
  http.Response _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response;
    } else if (response.statusCode == 401) {
      // Tangani Unauthorized Access (401)
      getLocalStorage.remove('token');
      Get.offAllNamed('/login');
      throw Exception('Unauthorized access. Please login again.');
    } else {
      throw Exception(
          'Failed with status code: ${response.statusCode}, and message: ${response.body}');
    }
  }

  // Penanganan error secara global
  Exception _handleError(dynamic error) {
    if (error is SocketException) {
      return Exception('No Internet connection. Please try again.');
    } else if (error is HttpException) {
      return Exception('Unexpected server error.');
    } else if (error is FormatException) {
      return Exception('Bad response format.');
    } else {
      return error;
    }
  }
}

import '../../base_http_services.dart';

class ApiEmergencyContact extends BaseHttpService {
  Future<dynamic> saveSubmit(List<Map<String, dynamic>> datapost) async {
    final setForm = {'kontak_darurat': datapost};
    return await postRequest('/user-update/kontak_darurat', setForm);
  }
}

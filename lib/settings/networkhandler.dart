import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medilink_app/api/global.dart';
import 'package:medilink_app/settings/shared_prefs.dart';

class NetworkHandler {
  final pref = Pref();

  Future<http.Response> get(String url) async {
    final baseurl = Uri.parse(url);
    final String? token = getToken();

    try {
      final response = await http.get(
        baseurl,
        headers: {'Authorization': 'Bearer $token'},
      );
      return response;
    } catch (error) {
      rethrow; // Rethrow the error to the caller for handling
    }
  }

  Future<http.Response> postwithoutToken(
      String url, Map<String, dynamic> body) async {
    final baseurl = Uri.parse(url);
    print(baseurl);
    print(body);
    try {
      var response = await http.post(
        baseurl,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(body),
      );
      print(response);
      return response;
    } catch (e) {
      print('Error in postwithoutToken: $e');
      throw e;
    }
  }

  Future<http.Response> post(String url, Map<String, dynamic> body) async {
    final baseurl = Uri.parse(url);
    String? token = getToken();

    var response = await http.post(
      baseurl,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: json.encode(body),
    );
    return response;
  }

  Future<http.Response> put(String url, Map<String, dynamic> body) async {
    final baseurl = Uri.parse(url);
    String? token = getToken();

    var response = await http.put(
      baseurl,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: json.encode(body),
    );
    return response;
  }

  Future<http.Response> delete(String url) async {
    final baseurl = Uri.parse(url);
    String? token = getToken();

    var response = await http.delete(
      baseurl,
      headers: {'Authorization': 'Bearer $token'},
    );
    return response;
  }

  Future<http.StreamedResponse> patchImage(String url, String filePath) async {
    final String? token = getToken();

    try {
      var request = http.MultipartRequest('PATCH', Uri.parse(url));
      request.files.add(await http.MultipartFile.fromPath('file', filePath));
      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer $token'
      });
      final response = await request.send();
      return response;
    } catch (error) {
      rethrow; // Rethrow the error to the caller for handling
    }
  }
}

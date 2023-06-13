import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:http_parser/http_parser.dart';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:vaea_mobile/data/middleware/rest/auth.dart';
import 'package:vaea_mobile/helpers/excpetions/unknown_except.dart';

import '../../../helpers/Env.dart';
import '../../../helpers/excpetions/expired_token_except.dart';

/// It encapsulates the logic of using http calls
class RequestsContainer {


  /// It preforms non-authenticated GET request in a json format.
  /// @pre-condition the caller checks internet connection.
  /// @throws UnknownException
  static Future<Map<String, dynamic>> getData(
      String pathStr, Map<String, dynamic>? queryMap) async {
    try {
      // prepare the request uri
      Uri url;
      if (queryMap != null && queryMap.isNotEmpty) {
        String base =
            "${Env.apiUrl.substring(Env.apiUrl.indexOf("/") + 2)}:${Env.apiPort}"; // to remove https://
        url = Uri.http(base, pathStr,
            queryMap.map((key, value) => MapEntry(key, value.toString())));
      } else {
        url = Uri.parse("${Env.apiUrl}:${Env.apiPort}$pathStr");
      }

      // set the header and call the request
      debugPrint("before api get $url");
      Map<String, String> header = {
        "Content-Type": "application/json",
      };
      if (AuthContainer.token != null) {
        header.putIfAbsent(
            "Authorization", () => "Bearer ${AuthContainer.token}");
      }
      http.Response response = await http.get(url, headers: header);
      debugPrint("after api get $url ${response.statusCode}");
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw UnknownException(
            msg: "unknown error in RequestContainer.getData.statusCode");
      }
    } on Exception catch (e) {
      debugPrint("in catch get request $e ;;;;; $pathStr");
      throw UnknownException(
          msg: "unknown error in RequestContainer.getData$e");
    }
  }


  /// It preforms authenticated GET request in a json format.
  /// @pre-condition the caller checks internet connection.
  /// @throws UnknownException
  static Future<Map<String, dynamic>> getAuthData( String pathStr, Map<String, dynamic>? queryMap) async {
    try {
      // prepare the request uri
      Uri url;
      if (queryMap != null && queryMap.isNotEmpty) {
        String base =
            "${Env.apiUrl.substring(Env.apiUrl.indexOf("/") + 2)}:${Env.apiPort}"; // to remove https://
        url = Uri.http(base, pathStr,
            queryMap.map((key, value) => MapEntry(key, value.toString())));
      } else {
        url = Uri.parse("${Env.apiUrl}:${Env.apiPort}$pathStr");
      }

      // set the header and call the request
      debugPrint("before api get $url");
      Map<String, String> header = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${AuthContainer.token}"
      };

      http.Response response = await http.get(url, headers: header);
      debugPrint("after api get $url ${response.statusCode}");
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw UnknownException(
            msg: "unknown error in RequestContainer.getData.statusCode");
      }
    } on Exception catch (e) {
      debugPrint("in catch get request $e ;;;;; $pathStr");
      throw UnknownException(
          msg: "unknown error in RequestContainer.getData$e");
    }
  }

  /// It preforms non-authenticated POST request in a json format.
  /// @pre-condition the caller checks internet connection.
  /// @throws UnknownException
  static Future<Map<String, dynamic>> postData(
      String pathStr, Map<String, dynamic> payload) async {
    try {
      // setup the header and uri
      Map<String, String> header = {"Content-Type": "application/json"};
      Uri uri = Uri.parse("${Env.apiUrl}:${Env.apiPort}$pathStr");

      // call the request
      debugPrint("before api post $pathStr");
      http.Response response =
          await http.post(uri, body: jsonEncode(payload), headers: header);
      debugPrint("after api post $pathStr ${response.statusCode}");
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw UnknownException(
            msg: "unknown error in else RequestContainer.postData");
      }
    } on Exception catch (e) {
      debugPrint("in catch $e");
      throw UnknownException(
          msg: "unknown error in RequestContainer.postData $e");
    }
  }

  /// It preforms an authenticated POST request in a json format.
  /// @pre-condition the caller checks internet connection.
  /// @throws ExpiredTokenException
  static Future<Map<String, dynamic>> postAuthData(
      String pathStr, Map<String, dynamic> payload) async {
    try {
      // setup the header and uri
      Map<String, String> header = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${AuthContainer.token}"
      };
      Uri uri = Uri.parse("${Env.apiUrl}:${Env.apiPort}$pathStr");

      // call the request
      debugPrint("before api post $pathStr");
      http.Response response =
          await http.post(uri, body: jsonEncode(payload), headers: header);
      debugPrint("after api post $pathStr ${response.statusCode}");
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw UnknownException(
            msg: "unknown error in else RequestContainer.postData");
      }
    } on Exception catch (e) {
      debugPrint("in catch $e");
      throw ExpiredTokenException(
          msg: "expired token error in RequestContainer.postAuthData $e");
    }
  }

  /// It preforms non-authenticated POST request in a FormData format.
  /// @pre-condition the caller checks internet connection.
  /// @throws UnknownException
  static Future<Map<String, dynamic>> postFormData(
      String pathStr, Map<String, dynamic> payload) async {
    try {
      // setup the header and uri
      Map<String, String> header = {"Content-Type": "application/json"};
      String uri = "${Env.apiUrl}:${Env.apiPort}$pathStr";

      // call the request
      debugPrint("before api post $pathStr");
      Map<String, dynamic> formDataPayload = payload.map((key, value) {
        if (value is File?) {
          return MapEntry(
              key, (value == null) ? null : mapFileToMultipartFile(value));
        } else {
          return MapEntry(key, value);
        }
      });

      FormData formData = FormData.fromMap(formDataPayload);
      Dio dio = Dio();
      Response response = await dio.post(uri, data: formData);
      debugPrint(
          "after api post $pathStr ${response.data.toString()} $formDataPayload");
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw UnknownException(
            msg: "unknown error in else RequestContainer.postData");
      }
    } on Exception catch (e) {
      debugPrint("in catch $e");
      throw UnknownException(
          msg: "unknown error in RequestContainer.postFormData $e");
    }
  }

  /// It is a helper method. It convert File to MultipartFile, so that files
  /// can be included in FormData.
  static MultipartFile? mapFileToMultipartFile(File file) {
    String? mime = lookupMimeType(file.path);
    if (mime == null) {
      return null;
    }

    String fileType = mime.substring(0, mime.indexOf("/"));
    String fileSubType = mime.substring(mime.indexOf("/") + 1);
    return MultipartFile.fromFileSync(file.path,
        contentType: MediaType(fileType, fileSubType));
  }
}

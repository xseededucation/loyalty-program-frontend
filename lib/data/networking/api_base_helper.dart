import 'package:http/http.dart' as http;
import 'package:loyalty_program_frontend/data/networking/api_exception.dart';
import 'dart:convert';
import 'dart:io';

import 'package:loyalty_program_frontend/presentation/utils/constants/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiBaseHelper {
  getToken() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final String? token = sharedPreferences.getString('token');
    return token;
  }

  setToken(token) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString('token', token);
    return token;
  }

  Future get(String url) async {
    dynamic responseJson;
    try {
      var token = await getToken();
      print("Authorization token : $token");
      final response =
          await http.get(Uri.parse(Constants.baseUrl + url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': "Bearer $token"
      });
      responseJson = await returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future post(String url, body) async {
    dynamic responseJson;
    var token = await getToken();

    try {
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': "Bearer $token"
      };

      final response = await http.post(Uri.parse(Constants.baseUrl + url),
          body: jsonEncode(body), headers: headers);
      responseJson = returnResponse(response);
    } catch (error) {
      printLog(error);
    }

    printLog('api post: ${jsonEncode(body)}');
    return responseJson;
  }

  Future put(String url, dynamic body) async {
    dynamic responseJson;
    try {
      final response =
          await http.put(Uri.parse(Constants.baseUrl + url), body: body);
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future delete(String url) async {
    dynamic apiResponse;
    try {
      final response = await http.delete(Uri.parse(Constants.baseUrl + url));
      apiResponse = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return apiResponse;
  }
}

dynamic returnResponse(http.Response response) {
  printLog(response);
  switch (response.statusCode) {
    case 200:
      var responseJson = json.decode(response.body.toString());
      printLog(responseJson);
      return responseJson;
    case 400:
      throw BadRequestException(response.body.toString());
    case 401:
      throw UnauthorizedException(response.body.toString());
    case 403:
      throw UnauthorizedException(response.body.toString());
    case 500:
    default:
      throw FetchDataException(
          'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
  }
}

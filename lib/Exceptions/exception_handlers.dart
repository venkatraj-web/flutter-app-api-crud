import 'dart:convert';

import 'app_exception.dart';
import 'package:http/http.dart' as http;

class ExceptionHandlers {
   returnResponse(http.Response response) async {
    // print("mass");
     print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        // print(responseJson);
        // print("suma");
        return await responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        // print(json.decode(response.body)['message']);
        // throw UnAuthorizedException(response.body.toString());
        throw UnAuthorizedException(json.decode(response.body)['message']);
        // throw UnAuthorizedException(response);
      case 422:
        var responseJson = json.decode(response.body.toString());
        // print(responseJson);
        return await responseJson;
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response
                .statusCode}');
    }
  }
}

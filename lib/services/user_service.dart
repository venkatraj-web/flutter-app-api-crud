import 'dart:convert';
import 'dart:io';

import 'package:qikcasual/Exceptions/exception_handlers.dart';
import 'package:qikcasual/models/casual.dart';
import 'package:qikcasual/repositories/repository.dart';
import 'package:http/http.dart' as http;

import '../Exceptions/app_exception.dart';

class UserService{

  Repository? _repository;
  ExceptionHandlers? exceptionHandler;

  UserService(){
    _repository = Repository();
    exceptionHandler = ExceptionHandlers();
  }

  Future<dynamic> getLogin(Casual data) async{
    var responsedJson;
    // return await _repository!.httpPost("casual/login", jsonEncode(data.toJson()));
    try {

      var response = await _repository!.httpPost("casual/login", jsonEncode(data.toJson()));
      print("Check2");
      // responsedJson = _returnResponse(response);
      responsedJson = exceptionHandler?.returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on Exception catch (e) {
      print(e);
      throw e;
    }
    return await responsedJson;
  }

  Future<dynamic> createCasual(Casual data) async {
    var responsedJson;

    try {
      var response = await _repository!.httpPost('casual/register', json.encode(data.toJson()));
      responsedJson = exceptionHandler?.returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on Exception catch (e) {
      print(e);
      throw e;
    }
    return await responsedJson;
  }
  Future<dynamic> createCasualFormData(Casual data, String filepath) async {
    var responsedJson;

    try {
      // var response = await _repository!.httpPostFormData('casual/register', json.encode(data.toJson()), filepath);
      var response = await _repository!.httpPostFormData('casual/register', data.toJson(), filepath);
      print(response);
      responsedJson = exceptionHandler?.returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on Exception catch (e) {
      print(e);
      throw e;
    }
    return await responsedJson;
  }

  Future<dynamic> getCasualProfile() async{
    var responsedJson;
    try{
      var response = await _repository!.httpGet("casual/profile");
      responsedJson = exceptionHandler?.returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on Exception catch(e){
      throw(e);
    }
    return await responsedJson;
  }

}
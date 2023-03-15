import 'dart:io';

import 'package:qikcasual/Exceptions/app_exception.dart';
import 'package:qikcasual/repositories/repository.dart';

import '../Exceptions/exception_handlers.dart';

class CasualJobService{
  Repository? _repository;
  ExceptionHandlers? _exceptionHandlers;
  var responsedJson;

  CasualJobService(){
    _repository = Repository();
    _exceptionHandlers = ExceptionHandlers();
  }

  Future<dynamic> getCasualJobs() async{
    var responsedJson;
    try {
      var response = await _repository!.httpGet("job-list");
      responsedJson = _exceptionHandlers?.returnResponse(response);
    } on SocketException{
      throw FetchDataException('No Internet connection');
    } on Exception catch (e) {
      throw(e);
    }
    return responsedJson;
  }

  getJobListsByCityId(int? cityId) async{
    try {
      var response = await _repository!.httpGetById("job-list-by-city", cityId);
      responsedJson = _exceptionHandlers!.returnResponse(response);
    } on SocketException{
      throw FetchDataException("No Internet Connection");
    } on Exception catch (e) {
      throw e;
    }
    return responsedJson;
  }

  getJobListsByPropertyId(int? propertyId) async{
    try {
      var response = await _repository!.httpGetById("job-list-by-property", propertyId);
      responsedJson = _exceptionHandlers!.returnResponse(response);
    } on SocketException{
      throw FetchDataException("No Internet Connection");
    } on Exception catch (e) {
      throw e;
    }
    return responsedJson;
  }

}
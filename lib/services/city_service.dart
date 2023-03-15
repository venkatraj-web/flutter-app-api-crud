import 'dart:io';

import 'package:qikcasual/Exceptions/app_exception.dart';
import 'package:qikcasual/Exceptions/exception_handlers.dart';
import 'package:qikcasual/repositories/repository.dart';

class CityService{
  Repository? _repository;
  ExceptionHandlers? _exceptionHandlers;
  var responsedJson;

  CityService(){
    _repository = Repository();
    _exceptionHandlers = ExceptionHandlers();
  }

  getCities() async{
    try {
      var response = await _repository!.httpGet("city");
      responsedJson = _exceptionHandlers!.returnResponse(response);
    } on SocketException{
      throw FetchDataException("No Internet Connection");
    } on Exception catch (e) {
      throw e;
    }
    return responsedJson;
  }

}
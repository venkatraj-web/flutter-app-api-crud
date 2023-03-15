import 'dart:io';

import 'package:qikcasual/Exceptions/app_exception.dart';
import 'package:qikcasual/repositories/repository.dart';

import '../Exceptions/exception_handlers.dart';

class CasualPropertyService{
  Repository? _repository;
  ExceptionHandlers? _exceptionHandlers;
  var responsedJson;
  
  CasualPropertyService(){
    _repository = Repository();
    _exceptionHandlers = ExceptionHandlers();
  }
  
  getProperties() async{
    try {
      var response = await _repository!.httpGet("property-list");
      responsedJson = _exceptionHandlers!.returnResponse(response);
    } on SocketException{
      throw FetchDataException("No Internet Connection");
    }
    on Exception catch (e) {
      throw e;
    }
    return responsedJson;
  }



}
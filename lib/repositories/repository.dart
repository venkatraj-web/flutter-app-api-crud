import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Repository{
  String _baseUrl = "http://192.168.1.7:8000/api";

  getHeaders() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var token = _prefs.getString("token");
    Map<String, String> headedrs = {
      "Content-type" : "application/json",
      "Accept" : "application/json",
      "Access-Control-Allow-Origin": "*",
      "Authorization" : "Bearer $token",
    };
    return await headedrs;
  }

  getHeadersFile() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var token = _prefs.getString("token");
    Map<String, String> headedrs = {
      "Content-type" : "multipart/form-data",
      "Accept" : "multipart/form-data",
      "Access-Control-Allow-Origin": "*",
      "Authorization" : "Bearer $token",
    };
    return await headedrs;
  }

  Future<dynamic> httpPost(String api, data) async{
    print(data);
    return await http.post(Uri.parse(_baseUrl+"/"+api), body: data, headers: await getHeaders());
  }

  Future<dynamic> httpPostFormData(String api, model, String filepath) async{
    var request = http.MultipartRequest('POST',Uri.parse(_baseUrl+"/"+api));
    print(model);
    model.forEach((key, value){
      request.fields[key] = value.toString();
    });
    request.files.add(await http.MultipartFile.fromPath("id_card_front_photo",filepath));
    request.headers.addAll(await getHeadersFile());

    var data = await request.send();
    final response = await http.Response.fromStream(data);
    return response;
  }

  Future httpGet(String api) async{
    return await http.get(Uri.parse(_baseUrl + "/" + api), headers: await getHeaders());
  }

  Future httpGetById(String api,cityId) async{
    return await http.get(Uri.parse(_baseUrl + "/" + api + "/" + cityId.toString()));
  }

}
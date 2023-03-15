class City{
  int? id;
  String? city_name;
  String? city_slug;
  int? status;
  DateTime? created_at;
  DateTime? updated_at;

  City({this.id,this.city_name,this.city_slug,this.status,this.created_at,this.updated_at});

  Map<String, dynamic> toJson(){
    final Map<String,dynamic> data = new Map<String,dynamic>();
    data['id'] = this.id;
    data['city_name'] = this.city_name;
    data['city_slug'] = this.city_slug;
    data['status'] = this.status;
    data['created_at'] = this.created_at;
    data['updated_at'] = this.updated_at;

    return data;
  }

  City.fromJson(Map<String,dynamic> jsonData){
    id = jsonData['id'];
    city_name = jsonData['city_name'];
    city_slug = jsonData['city_slug'];
    status = jsonData['status'];
    created_at = DateTime.tryParse(jsonData['created_at']);
    updated_at = DateTime.tryParse(jsonData['updated_at']);
  }

}
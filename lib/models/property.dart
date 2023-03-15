import 'casual_job.dart';
import 'city.dart';

class Property{
  int? id;
  String? propertyId;
  String? propertyName;
  int? clientId;
  int? propertyTypeId;
  int? propertyGradeId;
  int? cityId;
  String? propertyAvatar;
  String? createdAt;
  String? updatedAt;
  List<CasualJob>? casualJobList;
  City? city;

  Property(
      {this.id,
        this.propertyId,
        this.propertyName,
        this.clientId,
        this.propertyTypeId,
        this.propertyGradeId,
        this.cityId,
        this.propertyAvatar,
        this.createdAt,
        this.updatedAt,
        this.casualJobList,
        this.city
      }
  );

  Property.fromJson(Map<String, dynamic> json){
    id = json['id'];
    propertyId = json['property_id'];
    propertyName = json['property_name'];
    clientId = json['client_id'];
    propertyTypeId = json['property_type_id'];
    propertyGradeId = json['property_grade_id'];
    cityId = json['city_id'];
    propertyAvatar = json['property_avatar'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];

    if (json['casual_job_list'] != null) {
      casualJobList = <CasualJob>[];
      json['casual_job_list'].forEach((v) {
        casualJobList!.add(new CasualJob.fromJson(v));
      });
    }
    city = json['get_city'] != null
          ? new City.fromJson(json['get_city'])
          : null;

  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['property_id'] = this.propertyId;
    data['property_name'] = this.propertyName;
    data['client_id'] = this.clientId;
    data['property_type_id'] = this.propertyTypeId;
    data['property_grade_id'] = this.propertyGradeId;
    data['city_id'] = this.cityId;
    data['property_avatar'] = this.propertyAvatar;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;

    if (this.casualJobList != null) {
      data['casual_job_list'] =
          this.casualJobList!.map((v) => v.toJson()).toList();
    }
    if(this.city != null){
      data['get_city'] == this.city!.toJson();
    }

    return data;
  }
}
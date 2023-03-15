import 'package:qikcasual/models/property.dart';

import 'city.dart';

class CasualJob{

  int? id;
  String? casual_job_id ;
  String? job_title;
  int? client_id;
  int? city_id;
  int? no_of_casuals;
  String? outlet_name;
  String? reporting_person;
  String? designation;
  int? event_type;
  DateTime? start_date;
  DateTime? end_date;
  DateTime? shift_time_start;
  DateTime? shift_time_end;
  int? payment_type;
  int? amount;
  String? job_description;
  String? message_for_casual;
  String? things_to_bring;
  int? status;
  DateTime? created_at;
  DateTime? updated_at;
  City? city;
  Property? property;

  CasualJob(
      {this.id,
        this.casual_job_id,
        this.job_title,
        this.client_id,
        this.city_id,
        this.no_of_casuals,
        this.outlet_name,
        this.reporting_person,
        this.designation,
        this.event_type,
        this.start_date,
        this.end_date,
        this.shift_time_start,
        this.shift_time_end,
        this.payment_type,
        this.amount,
        this.job_description,
        this.message_for_casual,
        this.things_to_bring,
        this.status,
        this.created_at,
        this.updated_at,
        this.city,
        this.property});

  CasualJob.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    casual_job_id = json['casual_job_id'];
    job_title = json['job_title'];
    client_id = json['client_id'];
    city_id = json['city_id'];
    no_of_casuals = json['no_of_casuals'];
    outlet_name = json['outlet_name'];
    reporting_person = json['reporting_person'];
    designation = json['designation'];
    event_type = json['event_type'];
    start_date = DateTime.tryParse(json['start_date']);
    end_date = DateTime.tryParse(json['end_date']);
    shift_time_start = DateTime.tryParse(json['shift_time_start']);
    shift_time_end = DateTime.tryParse(json['shift_time_end']);
    payment_type = json['payment_type'];
    amount = json['amount'];
    job_description = json['job_description'];
    message_for_casual = json['message_for_casual'];
    things_to_bring = json['things_to_bring'];
    status = json['status'];
    created_at = DateTime.tryParse(json['created_at']);
    updated_at = DateTime.tryParse(json['updated_at']);
    city = json['get_city'] != null
        ? new City.fromJson(json['get_city'])
        : null;
    property = json['get_property'] != null
        ? new Property.fromJson(json['get_property'])
        : null;
  }

  Map<String, dynamic> toJson(){
    final Map<String,dynamic> data = new Map<String,dynamic>();
    data['id'] = this.id;
    data['casual_job_id'] = this.casual_job_id;
    data['job_title'] = this.job_title;
    data['client_id'] = this.client_id;
    data['city_id'] = this.city_id;
    data['no_of_casuals'] = this.no_of_casuals;
    data['outlet_name'] = this.outlet_name;
    data['reporting_person'] = this.reporting_person;
    data['designation'] = this.designation;
    data['event_type'] = this.event_type;
    data['start_date'] = this.start_date;
    data['end_date'] = this.end_date;
    data['shift_time_start'] = this.shift_time_start;
    data['shift_time_end'] = this.shift_time_end;
    data['payment_type'] = this.payment_type;
    data['amount'] = this.amount;
    data['job_description'] = this.job_description;
    data['message_for_casual'] = this.message_for_casual;
    data['things_to_bring'] = this.things_to_bring;
    data['status'] = this.status;
    data['created_at'] = this.created_at;
    data['updated_at'] = this.updated_at;
    if (this.city != null) {
      data['get_city'] = this.city!.toJson();
    }
    if (this.property != null) {
      data['get_property'] = this.property!.toJson();
    }


    return data;
  }

}

// ======GetCity============


// class GetCity {
//   int? id;
//   String? cityName;
//   String? citySlug;
//   int? status;
//   String? createdAt;
//   String? updatedAt;
//
//   GetCity(
//       {this.id,
//         this.cityName,
//         this.citySlug,
//         this.status,
//         this.createdAt,
//         this.updatedAt});
//
//   GetCity.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     cityName = json['city_name'];
//     citySlug = json['city_slug'];
//     status = json['status'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['city_name'] = this.cityName;
//     data['city_slug'] = this.citySlug;
//     data['status'] = this.status;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }

// ===========Get Property ========
//
// class GetProperty {
//   int? id;
//   String? propertyId;
//   String? propertyName;
//   int? clientId;
//   int? propertyTypeId;
//   int? propertyGradeId;
//   int? cityId;
//   Null? propertyAvatar;
//   String? createdAt;
//   String? updatedAt;
//
//   GetProperty(
//       {this.id,
//         this.propertyId,
//         this.propertyName,
//         this.clientId,
//         this.propertyTypeId,
//         this.propertyGradeId,
//         this.cityId,
//         this.propertyAvatar,
//         this.createdAt,
//         this.updatedAt});
//
//   GetProperty.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     propertyId = json['property_id'];
//     propertyName = json['property_name'];
//     clientId = json['client_id'];
//     propertyTypeId = json['property_type_id'];
//     propertyGradeId = json['property_grade_id'];
//     cityId = json['city_id'];
//     propertyAvatar = json['property_avatar'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['property_id'] = this.propertyId;
//     data['property_name'] = this.propertyName;
//     data['client_id'] = this.clientId;
//     data['property_type_id'] = this.propertyTypeId;
//     data['property_grade_id'] = this.propertyGradeId;
//     data['city_id'] = this.cityId;
//     data['property_avatar'] = this.propertyAvatar;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }
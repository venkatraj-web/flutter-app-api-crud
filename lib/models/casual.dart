import 'dart:io';

class Casual {
  int? id;
  String? casual_id;
  String? casual_name;
  String? email;
  String? password;
  String? password_confirmation;
  int? casual_phone_no;
  int? city_id;
  DateTime? date_of_birth;
  String? gender;
  String? id_proof;
  String? casual_avatar;
  int? identification_number;
  String? id_card_front_photo;
  String? id_card_back_photo;
  String? qr_code;
  DateTime? email_verified_at;
  String? remember_token;
  DateTime? created_at;
  DateTime? updated_at;

  Casual({this.id,this.casual_id,this.casual_name,this.email,this.password,this.password_confirmation,this.casual_phone_no,this.city_id,
    this.date_of_birth,this.gender,this.id_proof,this.casual_avatar,this.identification_number,this.id_card_front_photo,
    this.id_card_back_photo,this.qr_code,this.email_verified_at,this.remember_token,this.created_at,
    this.updated_at});

  toJson() {
    // return {
    //   'id' : id.toString(),
    //   'casual_id' : casual_id.toString(),
    //   'casual_name' : casual_name.toString(),
    //   'email' : email,
    //   'password' : password,
    // };

    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['casual_id'] = this.casual_id;
    data['casual_name'] = this.casual_name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['password_confirmation'] = this.password_confirmation;
    data['casual_phone_no'] = this.casual_phone_no;
    data['city_id'] = this.city_id;
    data['date_of_birth'] = this.date_of_birth;
    data['gender'] = this.gender;
    data['id_proof'] = this.id_proof;
    data['casual_avatar'] = this.casual_avatar;
    data['identification_number'] = this.identification_number;
    data['id_card_front_photo'] = this.id_card_front_photo;
    data['id_card_back_photo'] = this.id_card_back_photo;
    data['qr_code'] = this.qr_code;
    data['email_verified_at'] = this.email_verified_at;
    data['remember_token'] = this.remember_token;
    data['created_at'] = this.created_at;
    data['updated_at'] = this.updated_at;
// print('toJson : ${data}');
    return data;
  }

  Casual.fromJson(Map<String,dynamic> jsonData){
    id = jsonData['id'];
    casual_id = jsonData['casual_id'];
    casual_name = jsonData['casual_name'];
    email = jsonData['email'];
    created_at = DateTime.tryParse(jsonData['created_at']);
    updated_at = DateTime.tryParse(jsonData['updated_at']);
  }


  getCasualNameWithNull() {
    Map<String, dynamic> casuaFieldNameWithNull = {
      'casual_id' : null,
      'casual_name' : null,
      'email' : null,
      'password' : null,
      'password_confirmation' : null,
      'casual_phone_no' : null,
      'city_id' : null,
      'date_of_birth' : null,
      'gender' : null,
      'id_proof' : null,
      'casual_avatar' : null,
      'identification_number' : null,
      'id_card_front_photo' : null,
      'id_card_back_photo' : null,
      'qr_code' : null,
      'email_verified_at' : null,
      'remember_token' : null,
      'created_at' : null,
      'updated_at' : null,
    };

    return casuaFieldNameWithNull;
  }
}

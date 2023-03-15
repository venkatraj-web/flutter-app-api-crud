import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qikcasual/models/casual.dart';
import 'package:qikcasual/services/user_service.dart';
import 'package:qikcasual/ui/auth/login_screen.dart';
import 'package:qikcasual/utils/constants.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  Casual _casual = Casual();

  bool _obscure = true;
  bool _cPassObscure = true;
  String? _gender, _idProof;
  File? _image;
  List<File> images = [];

  UserService _userService = UserService();

  // ===================Form Key========================
  final _registerForm = GlobalKey<FormState>();
  Map<String, dynamic> _errors = new Map<String, dynamic>();

  // =========Text Editing Controller ==================
  TextEditingController casual_name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone_no = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController cPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Register Screen",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _registerForm,
              child: Column(
                children: [
                  const Gap(14),
                  _title(),
                  const Gap(24),
                  _casualName(),
                  const Gap(10),
                  _casualEmail(),
                  const Gap(10),
                  _casualPhoneNo(),
                  const Gap(10),
                  _casualPassword(),
                  const Gap(10),
                  _casualPasswordConfirmation(),
                  const Gap(24),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: new Text("Id Proof :"),
                  ),
                  Column(
                    children: [
                      RadioListTile(
                        title: Text("National Id Card"),
                        value: "national_id_card",
                        groupValue: _idProof,
                        onChanged: ((value) {
                          setState(() {
                            _idProof = value.toString();
                          });
                        }),
                        dense: true,
                      ),
                      RadioListTile(
                        title: Text("Driving License"),
                        value: "driving_license",
                        groupValue: _idProof,
                        onChanged: ((value) {
                          setState(() {
                            _idProof = value.toString();
                          });
                        }),
                        dense: true,
                      ),
                      RadioListTile(
                        title: Text("Pancard"),
                        value: "pancard",
                        groupValue: _idProof,
                        onChanged: ((value) {
                          setState(() {
                            _idProof = value.toString();
                          });
                        }),
                        dense: true,
                      ),
                      _errors['id_proof'] != null
                          ? Text(
                              _errors['id_proof'],
                              style: TextStyle(color: Colors.red),
                            )
                          : Text(""),
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                    color: Colors.blueGrey,
                  ),
                  const Gap(24),
                  // _image != null ? ClipOval(child: Image.file(_image!, width: 150,height: 150,fit: BoxFit.cover,)) : FlutterLogo(size: 150),
                  _image != null
                      ? ClipOval(
                          child: Image.file(
                          _image!,
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ))
                      : Center(),
                  _buildButton(
                    title: 'Upload Id Proof',
                    icon: Icons.camera_alt_outlined,
                    onClicked: () {
                      pickImage(ImageSource.camera);
                      setState(() {

                      });
                    },
                  ),
                  Gap(5),
                  _errors['id_card_front_photo'] != null
                      ? Text(
                          _errors['id_card_front_photo'],
                          style: TextStyle(color: Colors.red),
                        )
                      : Text(""),
                  const Gap(24),
                  _registerButton()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _title() {
    return Container(
      height: 90,
      child: Column(
        children: const [
          Text(
            "Register for Job",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          Gap(10),
          Text(
            "Enter Contact Details",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _casualName() {
    return Container(
      height: 70,
      child: TextFormField(
        controller: casual_name,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(10),
          labelText: "Casual Name",
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.person),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "Enter Casual Name by id proof";
          }
          if (_errors['casual_name'] != null) {
            return _errors['casual_name'];
          }
          return null;
        },
      ),
    );
  }

  Widget _casualEmail() {
    return Container(
      height: 70,
      child: TextFormField(
        controller: email,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(10),
          labelText: "Casual Email",
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.email_outlined),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "Enter Email-id";
          }
          if (_errors['email'] != null) {
            return _errors['email'];
          }
          return null;
        },
      ),
    );
  }

  Widget _casualPhoneNo() {
    return Container(
      height: 70,
      child: TextFormField(
        controller: phone_no,
        keyboardType: TextInputType.phone,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(10),
          labelText: "Casual Phone No",
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.phone_android),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "Enter Phone No";
          }
          if (_errors['casual_phone_no'] != null) {
            return _errors['casual_phone_no'];
          }
          return null;
        },
      ),
    );
  }

  Widget _casualPassword() {
    return Container(
      height: 70,
      child: TextFormField(
        controller: password,
        obscureText: _obscure,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          labelText: "Password",
          border: OutlineInputBorder(),
          suffixIcon: IconButton(
            icon:
                _obscure ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
            onPressed: (() {
              setState(() {
                _obscure = !_obscure;
              });
            }),
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "Enter password above 4 char!";
          }
          if (_errors['password'] != null) {
            return _errors['password'];
          }
          return null;
        },
      ),
    );
  }

  Widget _casualPasswordConfirmation() {
    return Container(
      height: 70,
      child: TextFormField(
        controller: cPassword,
        obscureText: _cPassObscure,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          labelText: "Password Confirmation",
          border: OutlineInputBorder(),
          suffixIcon: IconButton(
            icon: _cPassObscure
                ? Icon(Icons.visibility_off)
                : Icon(Icons.visibility),
            onPressed: (() {
              setState(() {
                _cPassObscure = !_cPassObscure;
              });
            }),
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "Enter Password Confirmation";
          }
          return null;
        },
      ),
    );
  }

  Widget _registerButton() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30))),
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            "Register Now",
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
        onPressed: () {
          var model = Casual();
          model.casual_name = casual_name.text;
          model.email = email.text;
          model.casual_phone_no = int.tryParse(phone_no.text);
          model.password = password.text;
          model.password_confirmation = cPassword.text;
          model.id_proof = _idProof;
          // model.id_card_front_photo = _image;
          // _registerForm.currentState!.validate();
          print("Validation");
          _register(context, model);
        },
      ),
    );
  }

  void _register(BuildContext context, Casual model) async {
    try {
      String? imgPath;
      print(_image?.path);
      _image?.path != null ? imgPath = _image?.path : imgPath = null;
      // var result = await _userService.createCasual(model);
      var result = await _userService.createCasualFormData(model, _image?.path ?? "");
      print(result);

      setState(() {
        _errors = _casual.getCasualNameWithNull();
      });
      if (result['status']) {
        Constants.showFlushBar(context, result['message']);
        Constants.gotoLogin(context, LoginScreen());
      } else {
        if (result.containsKey('errors')) {
          print(result['errors']);
          result['errors'].forEach((k, v) {
            // print('$k : ${v[0]}');
            _errors.forEach((key, value) {
              if (k == key) {
                _errors[k] = v[0];
              }
            });
          });
          Constants.showFlutterToast(
              "All fields are mandatory!", Colors.redAccent);
          print(result.containsKey('errors'));
          print(_errors);
        }
      }
      _registerForm.currentState?.validate();
    } on Exception catch (e) {
      Constants.showFlushBar(context, e.toString());
    }
  }

  Widget _buildButton(
      {required String title,
      required IconData icon,
      required VoidCallback onClicked}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(46),
          primary: Colors.white,
          onPrimary: Colors.black,
          textStyle: TextStyle(fontSize: 15)),
      onPressed: onClicked,
      child: Row(
        children: [
          Icon(
            icon,
            size: 28,
          ),
          Gap(16),
          Text(title)
        ],
      ),
    );
  }

  Future pickImage(ImageSource source) async {
    try {
      final img = await ImagePicker().pickImage(source: source);
      if (img == null) return;
      final imageTemporary = File(img!.path);
      setState(() {
        this._image = imageTemporary;
        images.add(imageTemporary);
      });
    } on PlatformException catch (e) {
      Constants.showFlushBar(context, e.toString());
      print('Failed to Pick image : $e');
    }
  }
}

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qikcasual/models/casual.dart';
import 'package:qikcasual/services/user_service.dart';
import 'package:qikcasual/ui/auth/register_screen.dart';
import 'package:qikcasual/ui/bottom_bar.dart';
import 'package:qikcasual/ui/home_screen.dart';
import 'package:qikcasual/ui/select_city_screen.dart';
import 'package:qikcasual/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obsecure = true;
  UserService _userService = UserService();
  Casual _casual = Casual();

  // ==============TextEditingController==============
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  // ===================Form Key========================
  final _loginForm = GlobalKey<FormState>();
  Map<String, dynamic> _errors = new Map<String, dynamic>();

  @override
  void initState() {
    _setToken();
    // _setToken();
    super.initState();
  }

  // =========Set Token=============
  _setToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    // _prefs.setString("token", "yes");
    print("Token : ${_prefs.getString("token")}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          "Login Screen",
          style: TextStyle(color: Colors.white),
        )),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _loginForm,
              child: Column(
                children: [
                  // SizedBox(height: Constants.screenSize(context).height,),
                  const SizedBox(height: 14),
                  _title(),
                  const SizedBox(height: 10),
                  _email(),
                  const SizedBox(height: 10),
                  _password(),
                  const SizedBox(height: 24),
                  _loginButton(),
                  const SizedBox(height: 24),
                  _goToSignup(),
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
            "Welcome to",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            "Qikcasual",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget _email() {
    return Container(
      height: 70,
      child: TextFormField(
        controller: email,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(10),
          labelText: "Email",
          hintText: "example@gmail.com",
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.emailAddress,
        autofillHints: [AutofillHints.email],
        validator: ((value) {
          if(value!.isEmpty){
            return "please enter email";
          }
          if(_errors['email'] != null){
            return _errors['email'];
          }
          return null;
        }),
      ),
    );
  }

  Widget _password() {
    return Container(
      height: 70,
      child: TextFormField(
        controller: password,
        obscureText: _obsecure,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10),
          labelText: "Password",
          suffixIcon: IconButton(
            icon: Icon(_obsecure ? Icons.visibility_off : Icons.visibility),
            onPressed: () {
              setState(() {
                _obsecure = !_obsecure;
              });
            },
          ),
          border: const OutlineInputBorder(),
        ),
        validator: ((value) {
          if(value!.isEmpty){
            return "please enter password";
          }
          if(_errors['password'] != null){
            return _errors['password'];
          }
          return null;
        }),
      ),
    );
  }

  Widget _loginButton() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            "Login as Casual",
            style: TextStyle(fontSize: 18.0, color: Colors.white),
          ),
        ),
        onPressed: () {
          var model = Casual();
          model.email = email.text;
          model.password = password.text;
          // print("Email : ${model.email}");
          // print("Password : ${model.password}");
          _login(context, model);
        },
      ),
    );
  }

  Widget _goToSignup() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30))),
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            "Register For a Job",
            style: TextStyle(fontSize: 18.0, color: Colors.white),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => const RegisterScreen(),
            ),
          );
        },
      ),
    );
  }

  _login(BuildContext context,Casual model) async{
    try {
      _loginForm.currentState!.validate();
      var result = await _userService.getLogin(model);
      // var resultData = await json.decode(result.body);
      // print(resultData['errors']);
      print(result);

      setState(() {
        _errors = _casual.getCasualNameWithNull();
      });

      if(result['status']){
        SharedPreferences _pref = await SharedPreferences.getInstance();
        _pref.setString('token', result['access_token']);
        print(result['message']);
        Constants.showFlushBar(context, 'LoggedIn Successfully!');
        Timer(Duration(seconds: 3), () {
          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) => BottomBar()));
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) => SelectCityScreen()));
        },);
      }else{
        if(result.containsKey('errors')){
          result['errors'].forEach((k,v){
            // print("$k : ${v[0]}");
            _errors.forEach((key,value){
              // print("$k : $v");
              if(k == key){
                _errors[k] = v[0];
              }
            });
          });
          // Constants.showSnackBar(context);
          Constants.showFlutterToast("All fields are mandatory!", Colors.redAccent);
        }
        // print(result.containsKey('errors'));
        if(result.containsKey('message')){
          print(result['message']);

          // Constants.showFlutterToast(result['message']);

          Constants.showFlushBar(context, result['message']);
        }
      }

      print(_errors);
      _loginForm.currentState!.validate();
    } on Exception catch (e) {
      // Constants.showFlutterToast(e.toString());
      Constants.showFlushBar(context, e.toString());
    }

  }

}

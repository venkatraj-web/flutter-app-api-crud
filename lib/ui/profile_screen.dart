import 'package:flutter/material.dart';
import 'package:qikcasual/models/casual.dart';
import 'package:qikcasual/services/user_service.dart';
import 'package:qikcasual/ui/auth/login_screen.dart';
import 'package:qikcasual/utils/app_styles.dart';
import 'package:qikcasual/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with AutomaticKeepAliveClientMixin {
  bool _isLoading = true;

  // Casual _casual = Casual();
  Map<String, dynamic> _casualData = new Map<String, dynamic>();
  UserService _userService = UserService();

  @override
  void initState() {
    getCasualProfile();
    super.initState();
  }

  getCasualProfile() async {
    try {
      var result = await _userService.getCasualProfile();
      print(result['user']);
      if (result['status']) {
        print(_casualData);
        setState(() {
          _casualData = result['user'];
          _isLoading = false;
        });
      } else {
        Constants.showSnackBar(context);
      }
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      print("Token " + _prefs.getString("token").toString());
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=> LoginScreen()));
    } on Exception catch (e) {
      // Constants.showFlushBar(context, e.toString());
      // if(e.toString() == "Unauthenticated."){
      //   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx) => LoginScreen()), (route) => false);
      // }
      // print(e == 401);
      print(Constants.checkTokenExpiration(context, e));

      // Constants.gotoLogin(context, MaterialPageRoute(builder: (ctx) => LoginScreen()));
      // Constants.gotoLogin(context, LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 24,
                      ),
                      Center(
                        child: CircleAvatar(
                          backgroundColor: Colors.blueGrey,
                          // backgroundImage: _casualData['casual_avatar'] == null ? AssetImage('assets/images/person.png') as ImageProvider : NetworkImage(Constants.Domain + _casualData['casual_avatar']),
                          backgroundImage: _casualData['casual_avatar'] == null
                              ? Image.asset('assets/images/person.png').image
                              : NetworkImage(Constants.Domain +
                                  _casualData['casual_avatar']),
                          radius: 80,
                        ),
                      ),
                      // Image.network(
                      //   Constants.Domain + _casualData['casual_avatar'],
                      // ),
                      SizedBox(
                        height: 24,
                      ),
                      Text("id : ${_casualData['casual_id']}"),
                      SizedBox(
                        height: 24,
                      ),
                      Text("Name : ${_casualData['casual_name']}"),
                      SizedBox(
                        height: 24,
                      ),
                      Text("Email : ${_casualData['email']}"),
                      SizedBox(
                        height: 24,
                      ),
                      Text("Phone No : ${_casualData['casual_phone_no']}"),
                      SizedBox(
                        height: 24,
                      ),
                      Text("Gender : ${_casualData['gender']}"),
                      SizedBox(
                        height: 24,
                      ),
                      Text("Id Proof : ${_casualData['id_proof']}"),
                    ],
                  )
                ],
              ),
      ),
      floatingActionButton: buildEditProfileButton(),
    );
  }

  Widget buildEditProfileButton() {
    return FloatingActionButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14)
      ),
      backgroundColor: Styles.secondaryColor,
      child: Icon(Icons.edit, color: Styles.lightBgColor),
      onPressed: () {
        print("Pressed");
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

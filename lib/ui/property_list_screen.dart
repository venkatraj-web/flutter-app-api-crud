import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qikcasual/services/casual_property_service.dart';
import 'package:qikcasual/utils/constants.dart';

import '../models/casual_job.dart';
import '../models/property.dart';
import '../services/casual_job_service.dart';
import '../utils/app_styles.dart';

class PropertyListScreen extends StatefulWidget {
  PropertyListScreen({Key? key}) : super(key: key);

  @override
  State<PropertyListScreen> createState() => _PropertyListScreenState();
}

class _PropertyListScreenState extends State<PropertyListScreen> {
  final df = new DateFormat("yyyy-MM-dd");
  CasualPropertyService _casualPropertyService = CasualPropertyService();
  List<Property> _propertyList = <Property>[];

  @override
  void initState() {
    getProperties();
    super.initState();
  }

  Future<List<Property>> getProperties() async{
    try {
      var result = await _casualPropertyService.getProperties();
      if(result != null){
        if(result['status']){
          result['properties'].forEach((data){
            setState(() {
              _propertyList.add(Property.fromJson(data));
            });
          });
        }else{
          Constants.showSnackBar(context);
        }
      }else{
        Constants.showFlutterToast("No Data", Styles.primaryColor);
      }
    } on Exception catch (e) {
      Constants.checkTokenExpiration(context, e);
    }
    return _propertyList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
            color: Colors.white
        ),
        backgroundColor: Styles.textColor,
        title: Center(child: Text("Property", style: Styles.headLineStyle2.copyWith(color: Colors.white),)),
        actions: [
          IconButton(
              color: Colors.white,
              onPressed: () {
                print("Menu");
              },
              icon: Icon(Icons.more_vert))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 15,top: 15),
          child: Column(
            children: [
              Container(
                height: Constants.screenSize(context).height,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Styles.textColor,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(24))
                ),
                child: Column(
                  children: [
                    Expanded(child: buildPropertyList())
                  ],
                )
              ),
            ],
          ),
        ),
      )
    );
  }

  Widget buildPropertyList() {
    return ListView.builder(
      itemCount: _propertyList.length,
      itemBuilder: (context, index) {
        final item = _propertyList[index];
        return buildProperty(item);
      },);
  }

  Widget buildProperty(Property item) {
    return Container(
      child: Column(
        children: [
          Text(item.propertyName!, style: Styles.headLineStyle1.copyWith(color: Colors.white),)
        ],
      ),
    );
  }
}

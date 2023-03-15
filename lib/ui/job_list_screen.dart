import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:qikcasual/models/casual_job.dart';
import 'package:qikcasual/models/property.dart';
import 'package:qikcasual/services/casual_job_service.dart';
import 'package:qikcasual/ui/bottom_bar.dart';
import 'package:qikcasual/ui/filter/filter_screen.dart';
import 'package:qikcasual/ui/help_center/help_screen.dart';
import 'package:qikcasual/ui/job_details_screen.dart';
import 'package:qikcasual/ui/property_list_screen.dart';
import 'package:qikcasual/utils/app_styles.dart';
import 'package:qikcasual/utils/constants.dart';

class JobListScreen extends StatefulWidget {
  Property? property;

  JobListScreen({this.property, Key? key}) : super(key: key);

  @override
  State<JobListScreen> createState() => _JobListScreenState();
}

class _JobListScreenState extends State<JobListScreen> {

  final df = new DateFormat("yyyy-MM-dd");
  CasualJobService _casualJobService = CasualJobService();
  List<CasualJob> _casualJobList = <CasualJob>[];

  @override
  void initState(){
    getJobsByProperty();
    super.initState();
  }

  Future<List<CasualJob>> getJobsByProperty() async{
    // print(_casualJobList);
    try {
      var result = await _casualJobService.getJobListsByPropertyId(widget.property!.id);
      if(result != null){
        if(result['status']){
          result['job-list'].forEach((data){
            setState(() {
              _casualJobList.add(CasualJob.fromJson(data));
            });
          });
        }else{
          Constants.showSnackBar(context);
        }
      }else{
        Constants.showFlutterToast("No data", Colors.yellow);
      }
    } on Exception catch (e) {
      Constants.checkTokenExpiration(context, e);
    }
    // print(_casualJobList);
    return _casualJobList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
        backgroundColor: Styles.textColor,
        title: Center(child: Text(this.widget.property!.propertyName!, style: Styles.headLineStyle2.copyWith(color: Colors.white),)),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              Navigator.push(context, MaterialPageRoute(builder: (_) => HelpScreen()));
            },
            itemBuilder:(context) => [
              PopupMenuItem(
                value: 1,
                // row has two child icon and text.
                child: Row(
                  children: [
                    Icon(Icons.help, color: Styles.darkBgColor,),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Help")
                  ],
                ),
              ),
            ], ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 15, top: 15),
          child: Column(
            children: [
              Container(
                height: Constants.screenSize(context).height,
                width: double.infinity,
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  color: Styles.textColor,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(24))
                ),
                child: Column(
                  children: [
                    Gap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("Jobs", style: Styles.headLineStyle1.copyWith(color: Colors.white),),
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 5,
                            children: [
                              Icon(Icons.person_add, color: Colors.white),
                              Text("${widget.property!.casualJobList!.length} Vacancies", style: Styles.headLineStyle4.copyWith(color: Colors.white),)
                            ],
                          ),
                        )
                      ],
                    ),
                    Gap(20),
                    Expanded(child: buildPropertyJobList()),
                    Gap(20),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPropertyJobList() {
    return Container(
      // padding: EdgeInsets.only(left: 10),
      child: ListView.separated(
        itemCount: _casualJobList.length,
        separatorBuilder: (context, index) => const Gap(15),
        itemBuilder: (context, index) {
          final item = _casualJobList[index];
          // print(widget.property!.city!.city_name);
          return buildPropertyJob(item);
        },
      ),
    );
  }

  Widget buildPropertyJob(CasualJob item) {
    return InkWell(
      onTap: () {
        print(item!.start_date);
        print(item!.city!.city_name);
        Navigator.push(context, MaterialPageRoute(builder: (context) => JobDetailsScreen(job: item),));
      },
      child: Container(
        height: 110,
        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
        decoration: BoxDecoration(
          color: Styles.lightBgColor,
          borderRadius: const BorderRadius.horizontal(
            left: Radius.circular(16)
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(item!.job_title!.toUpperCase(),style: Styles.headLineStyle3.copyWith(fontWeight: FontWeight.bold),),
                Text("${item!.amount!} BHAT/day",style: Styles.headLineStyle3.copyWith(fontWeight: FontWeight.bold),)
              ],
            ),
            Gap(10),
            Text(widget.property!.propertyName!, style: Styles.headLineStyle3.copyWith(color: Styles.secondaryColor),),
            Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${item.no_of_casuals} Vacancies", style: Styles.headLineStyle4,),
                Text("Casual"),
                Text(df.format(item.start_date!))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

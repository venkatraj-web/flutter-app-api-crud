import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:qikcasual/models/casual.dart';
import 'package:qikcasual/models/casual_job.dart';
import 'package:qikcasual/services/casual_job_service.dart';
import 'package:qikcasual/services/casual_property_service.dart';
import 'package:qikcasual/ui/auth/login_screen.dart';
import 'package:qikcasual/ui/filter/filter_screen.dart';
import 'package:qikcasual/ui/job_details_screen.dart';
import 'package:qikcasual/ui/job_list_screen.dart';
import 'package:qikcasual/ui/property_list_screen.dart';
import 'package:qikcasual/utils/app_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/city.dart';
import '../models/property.dart';
import '../utils/constants.dart';

class HomeScreen extends StatefulWidget {
  City? city;

  HomeScreen({this.city, Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {
  CasualJobService _casualJobService = CasualJobService();
  CasualPropertyService _casualPropertyService = CasualPropertyService();
  Map<String, dynamic> _casualJobData = new Map<String, dynamic>();
  CasualJob _casualJob = CasualJob();

  final df = new DateFormat('yyyy-MM-dd');

  List<CasualJob> _casualJobList = <CasualJob>[];
  List<Property> _propertyList = <Property>[];

  List jobList = List.generate(15, (index) => "Item ${index}");

  @override
  void initState() {
    _loadResources(true);
    super.initState();
  }

  Future<void> _loadResources(bool reload) async{
    _casualJobList = [];
    _propertyList = [];
    await getJobs();
    await getProperties();
  }

  Future<List<CasualJob>> getJobs() async {
    try {
      var result = await _casualJobService.getCasualJobs();

      // print(result['job-list']);
      // print(result != null);
      if (result != null) {
        result['job-list'].forEach((data) {
          // print(CasualJob.fromJson(data).city!.city_name);
          // print(CasualJob.fromJson(data).runtimeType);
          setState(() {
            _casualJobList.add(CasualJob.fromJson(data));
          });
        });
      }
    } on Exception catch (e) {
      // Constants.showFlushBar(context, e.toString());
      Constants.checkTokenExpiration(context, e);
    }
    return _casualJobList;
  }

  Future<List<Property>> getProperties() async {
    try {
      var result = await _casualPropertyService.getProperties();
      // print(result["properties"][0]["casual_job_list"][0]['job_title']);
      if (result != null) {
        if (result['status']) {
          result['properties'].forEach((data) {
            // print(data);
            setState(() {
              _propertyList.add(Property.fromJson(data));
            });
          });
        } else {
          Constants.showSnackBar(context);
        }
      } else {
        Constants.showFlutterToast("No data", Colors.yellow);
      }
    } on Exception catch (e) {
      Constants.checkTokenExpiration(context, e);
    }
    // _propertyList.forEach((element) {
    //   print(element.casualJobList!.length);
    // });
    return _propertyList;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        body: RefreshIndicator(
      onRefresh: () async {
        await _loadResources(true);
      },
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 20, top: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                        color: Colors.deepOrangeAccent,
                        borderRadius: BorderRadius.circular(14)),
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => FilterScreen()));
                      },
                      iconSize: 28,
                      icon: const Icon(Icons.filter_list),
                      color: Colors.white,
                    ),
                  ),
                  const Gap(10),
                  Expanded(child: tagList()),
                ],
              ),
              const Gap(14),
              Container(
                padding: const EdgeInsets.only(top: 10, left: 15),
                height: Constants.screenSize(context).height,
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(18)),
                  color: Color(0Xff111E28),
                ),
                child: Column(
                  children: [
                    const Gap(18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Top Jobs".toUpperCase(),
                          style: const TextStyle(
                              color: Colors.white,
                              wordSpacing: 4,
                              letterSpacing: 1.5),
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => PropertyListScreen()));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 18.0),
                              child: Text(
                                "Load More".toUpperCase(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    wordSpacing: 4,
                                    letterSpacing: 1.5),
                              ),
                            )),
                      ],
                    ),
                    const Gap(18),
                    Row(
                      children: [
                        Expanded(child: buildPropertyList()),
                      ],
                    ),
                    const Gap(18),
                    Row(
                      children: [
                        Text(
                          "Suggest Jobs".toUpperCase(),
                          style: const TextStyle(
                              color: Colors.white,
                              // fontWeight: FontWeight.bold,
                              wordSpacing: 8,
                              letterSpacing: 1.5),
                        ),
                      ],
                    ),
                    const Gap(18),
                    Expanded(child: buildCasualJobList()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Widget tagList() {
    return Container(
      height: 70,
      // color: Colors.deepOrangeAccent,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: jobList.length,
          separatorBuilder: (context, index) => const SizedBox(
                width: 12,
              ),
          itemBuilder: ((context, index) {
            final item = jobList[index];
            return buildTagCard(item);
          })),
    );
  }

  Widget buildTagCard(item) {
    return Container(
      width: 150,
      // height: 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: const Color(0xff01A4D0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Center(
        child: Text(
          item,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Widget buildCasualJobList() {
    return Container(
      child: _casualJobList.length > 0
          ? ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemCount: _casualJobList.length,
              separatorBuilder: (context, index) => const Gap(10),
              itemBuilder: ((context, index) {
                final job = _casualJobList[index];
                return CasualJobList(job);
              }),
            )
          : Text(
              "No Casual Job Data Founded!!",
              style: TextStyle(color: Colors.white),
            ),
    );
  }

  Widget CasualJobList(CasualJob job) {
    return InkWell(
      onDoubleTap: () {
        print(job!.start_date);
        print(job.property!.propertyName);
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => JobDetailsScreen(job: job,)));
      },
      child: Container(
        width: double.infinity,
        height: 110,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), bottomLeft: Radius.circular(16))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  job.job_title!.toUpperCase(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      fontSize: 15),
                ),
                Text(
                  "${job.amount!}${" baht".toUpperCase()}/day",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      fontSize: 15),
                )
              ],
            ),
            const Gap(10),
            Text(
              job!.property?.propertyName ?? "place",
              style: TextStyle(color: Color(0xffE47B01), fontSize: 16),
            ),
            const Gap(15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Icon(Icons.location_on, size: 18),
                    Text(
                      job!.city?.city_name ?? "india",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                          fontSize: 12,
                          color: Color(0xff4C646A)),
                    ),
                  ],
                ),
                Text(
                  "Casual".toUpperCase(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      fontSize: 12,
                      color: Color(0xff4C646A)),
                ),
                Text(
                  df.format(job!.start_date!),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      fontSize: 14,
                      color: Color(0xff4C646A)),
                )
              ],
            ),
          ],
        ),
      ),
    );
    // return Text(
    //   job.toString(),
    //   style: TextStyle(color: Colors.white),
    // );
  }

  Widget buildPropertyList() {
    return Container(
      padding: EdgeInsets.only(left: 10),
      height: 200,
      // width: 200,
      // color: Colors.yellow,
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const Gap(20),
        itemCount: _propertyList.length,
        itemBuilder: (context, index) {
          final item = _propertyList[index];
          return propertyList(item);
        },
      ),
    );
  }

  Widget propertyList(Property item) {
    return Stack(
      clipBehavior: Clip.hardEdge,
      children: [
      Container(
        clipBehavior: Clip.hardEdge,
        width: Constants.screenSize(context).width * 0.5,
        height: Constants.screenSize(context).longestSide,
        // margin: EdgeInsets.symmetric(
        //   vertical: 10,
        // ),
        padding: EdgeInsets.only(top:15, left: 20, right: 10, bottom: 40),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item!.propertyName!.toUpperCase(),
                style: Styles.headLineStyle1,
              ),
              const Gap(14),
              Text(
                "${item!.casualJobList!.length.toString()} Vacancies",
                style: Styles.headLineStyle2,
              ),
              const Gap(14),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Icon(Icons.location_pin),
                  Text(
                    item!.city?.city_name ?? "",
                    style: Styles.headLineStyle3,
                  ),
                ],
              ),
              const Gap(14),
            ],
          ),
        ),
      ),
      Positioned(
        bottom: 0,
        right: 0,
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => JobListScreen(property: item,)));
          },
          child: Container(
            padding: EdgeInsets.all(10),
            width: 130,
            height: 40,
            decoration: BoxDecoration(
              color: Styles.secondaryColor,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(7),bottomRight: Radius.circular(20))
            ),
            child: Center(child: Text("Show All", style: Styles.headLineStyle2,)),
          ),
        )
      ),
    ]);
  }
}

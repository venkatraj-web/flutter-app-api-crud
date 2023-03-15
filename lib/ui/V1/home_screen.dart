import 'package:flutter/material.dart';
import 'package:qikcasual/models/casual.dart';
import 'package:qikcasual/models/casual_job.dart';
import 'package:qikcasual/services/casual_job_service.dart';
import 'package:qikcasual/ui/auth/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/city.dart';
import '../../utils/constants.dart';



class HomeScreen extends StatefulWidget {
  City? city;
  HomeScreen({this.city,Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CasualJobService _casualJobService = CasualJobService();
  Map<String, dynamic> _casualJobData = new Map<String, dynamic>();
  CasualJob _casualJob = CasualJob();


  @override
  void initState() {
    getJobs();
    super.initState();
  }

  Future<List<CasualJob>> getJobs() async {
    List<CasualJob> _casualJobList = <CasualJob>[];
    try {
      var result = await _casualJobService.getCasualJobs();

      print(result['job-list']);
      print(result != null);
      if (result != null) {
        // result['job-list'].forEach((data) {
        //   // print("Data : ${data}");
        //   var model = CasualJob();
        //   model.id = data['id'];
        //   model.casual_job_id = data['casual_job_id'];
        //   model.job_title = data['job_title'];
        //   model.client_id = data['client_id'];
        //   model.city_id = data['city_id'];
        //   model.no_of_casuals = data['no_of_casuals'];
        //   model.outlet_name = data['outlet_name'];
        //   model.reporting_person = data['reporting_person'];
        //   model.designation = data['designation'];
        //   model.event_type = data['event_type'];
        //   model.start_date = DateTime.tryParse(data['start_date']);
        //   model.end_date = DateTime.tryParse(data['end_date']);
        //   model.shift_time_start = DateTime.tryParse(data['shift_time_start']);
        //   model.shift_time_end = DateTime.tryParse(data['shift_time_end']);
        //   model.payment_type = data['payment_type'];
        //   model.amount = data['amount'];
        //   model.job_description = data['job_description'];
        //   model.message_for_casual = data['message_for_casual'];
        //   model.things_to_bring = data['things_to_bring'];
        //   model.status = data['status'];
        //   model.created_at = DateTime.tryParse(data['created_at']);
        //   model.updated_at = DateTime.tryParse(data['updated_at']);
        //
        //   // setState(() {
        //     _casualJobList.add(model);
        //   // });
        // });
        // print(result['job-list'].map<CasualJob>(CasualJob.fromJson).toList());
        // result['job-list'].map<CasualJob>(CasualJob.fromJson).toList();
        result['job-list'].forEach((data){
          print(CasualJob.fromJson(data).runtimeType);
          _casualJobList.add(CasualJob.fromJson(data));
        });
      }

    } on Exception catch (e) {
      // Constants.showFlushBar(context, e.toString());
      Constants.checkTokenExpiration(context, e);
    }

    return _casualJobList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder<List<CasualJob>>(
          future: getJobs(),
          builder:
              (BuildContext context, AsyncSnapshot<List<CasualJob>> snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: const CircularProgressIndicator());
            }else if(snapshot.hasError){
              return Text("${snapshot.error}!");
            }
            else if (snapshot.hasData) {
              // return ListView.builder(scrollDirection: Axis.horizontal,
              //   itemCount: snapshot.data!.length,
              //   itemBuilder: (context, index){
              //     return Padding(
              //       padding: const EdgeInsets.all(30.0),
              //       child: Card(
              //         margin: EdgeInsets.all(30),
              //         child: Text(snapshot.data![index].job_title!),
              //       ),
              //     );
              //   },
              // );
              final Jobs = snapshot.data!;
              return buildJobs(Jobs);
            }else{
              return const Text("No Jobs Data!!!");
            }
          },
        ),
      )
    );
  }

  Widget buildJobs(List<CasualJob> jobs) {
    return ListView.builder(
      // scrollDirection: Axis.horizontal,
      itemCount: jobs.length,
      itemBuilder: (context, index) {
        final job = jobs[index];
        return Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          width: Constants.screenSize(context).width* 0.6,
          height: Constants.screenSize(context).height * 0.1,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.blueGrey
          ),
          child: Column(
            children: [
              Text(job.job_title!),
              Text(job.job_description!)
            ],
          ),
        );
      },
    );
  }
}

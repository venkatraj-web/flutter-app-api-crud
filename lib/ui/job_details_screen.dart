import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qikcasual/models/casual_job.dart';
import 'package:qikcasual/ui/home_screen.dart';

class JobDetailsScreen extends StatefulWidget {
  CasualJob? job;
  JobDetailsScreen({required this.job, Key? key}) : super(key: key);

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  final df = new DateFormat('yyyy-MM-dd hh:mm a');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.job);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Job Details Screen"),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name : ${widget.job!.job_title!}"),
            const SizedBox(height: 10,),
            Text("City : ${widget.job!.city!.city_name!}"),
            const SizedBox(height: 10,),
            Text("Job Description : ${widget.job!.job_description!}"),
            const SizedBox(height: 10,),
            Text("Amount : ${widget.job!.amount!} Bhat/day"),
            const SizedBox(height: 10,),
            Text("Message For Casual : ${widget.job!.message_for_casual!}"),
            const SizedBox(height: 10,),
            Text("Outlet : ${widget.job!.outlet_name!}"),
            const SizedBox(height: 10,),
            Text("Reporting Person : ${widget.job!.reporting_person!}"),
            const SizedBox(height: 10,),
            Text("Start Date : ${df.format(widget.job!.start_date!)}"),
            const SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}

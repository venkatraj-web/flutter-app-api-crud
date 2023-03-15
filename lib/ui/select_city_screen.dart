import 'package:flutter/material.dart';
import 'package:qikcasual/models/city.dart';
import 'package:qikcasual/services/city_service.dart';
import 'package:qikcasual/ui/bottom_bar.dart';
import 'package:qikcasual/utils/constants.dart';

class SelectCityScreen extends StatefulWidget {
  const SelectCityScreen({Key? key}) : super(key: key);

  @override
  State<SelectCityScreen> createState() => _SelectCityScreenState();
}

class _SelectCityScreenState extends State<SelectCityScreen> {
  // final List cities = List.generate(15, (index) => "Item ${index}");
  final List<City> cities = <City>[];
  CityService _cityService = CityService();
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCities();
  }

  Future<List<City>?> fetchCities() async {
    if (isLoading) return null;
    isLoading = true;
    try {
      Map<String, dynamic> result = await _cityService.getCities();
      print(result['cities']);
      // print(cities);
      print(result != null);
      if (result != null) {
        if (result['status']) {
          isLoading = false;
          result['cities'].forEach((cityData) {
            // print(cityData);
            setState(() {
              cities.add(City.fromJson(cityData));
            });
          });
        } else {
          Constants.showSnackBar(context);
        }
      }
      // print(cities);
    } on Exception catch (e) {
      // Constants.showFlushBar(context, e.toString());
      print(Constants.checkTokenExpiration(context, e));
    }
    return cities;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 15, top: 15),
          padding: EdgeInsets.all(15),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20)),
              color: Color(0xff2E394A)),
          child: Column(
            children: [
              Container(
                height: 50,
                // color: Colors.orange,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    // SizedBox(
                    //   height: 54,
                    // ),
                    Text(
                      "Choose Your City",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    // SizedBox(
                    //   height: 24,
                    // ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: isLoading? Center(child: CircularProgressIndicator()) :buildGridView(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildGridView() {
    return GridView.builder(
        // scrollDirection: Axis.vertical,
        //   shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          // childAspectRatio: 1 / 1,
          // childAspectRatio: MediaQuery.of(context).size.width /
          //     (MediaQuery.of(context).size.height / 4),
          mainAxisExtent: 150,
        ),
        itemCount: cities.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final city = cities[index];
          return buildCityCard(city);
        });
  }

  Widget buildCityCard(City city) => Container(
        // color: Colors.lightGreenAccent,
        child: InkWell(
          onTap: () {
            Constants.showFlutterToast(city.city_name!, Colors.purple);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>BottomBar()));
          },
          child: Card(
            // semanticContainer: true,
            // clipBehavior: Clip.antiAlias,
            color: Colors.redAccent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                      child: Text(
                    city.city_name!,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  )),
                ],
              ),
            ),
          ),
        ),
      );
}

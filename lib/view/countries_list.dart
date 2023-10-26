import 'package:covid_tracker/services/utilities/states_services.dart';
import 'package:covid_tracker/view/country_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({Key? key}) : super(key: key);

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();

    return Scaffold(
      backgroundColor: Colors.teal.shade200,
      appBar: AppBar(
        backgroundColor: Colors.teal,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {

                  });
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  hintText: 'Search with country name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50)
                  )
                ),
              ),
            ),

            Expanded(
              child: FutureBuilder(
                future: statesServices.countriesListApi(),
                  builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {

                    if(snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                          String countryName = snapshot.data![index]['country'];

                          if(searchController.text.isEmpty) {
                            return ListTile(
                              onTap: () => Get.to(() => CountryDetailScreen(snapshot: snapshot.data![index],)),
                              title: Text(snapshot.data![index]['country']),
                              subtitle: Text(snapshot.data![index]['cases'].toString()),
                              leading: Image(
                                  width: 50,
                                  height: 50,
                                  image: NetworkImage(snapshot.data![index]['countryInfo']['flag'])
                              ),
                            );

                          }else if(countryName.toLowerCase().contains(searchController.text.toLowerCase())) {
                            return ListTile(
                              onTap: () => Get.to(() => CountryDetailScreen(snapshot: snapshot.data![index],)),
                              title: Text(snapshot.data![index]['country']),
                              subtitle: Text(snapshot.data![index]['cases'].toString()),
                              leading: Image(
                                  width: 50,
                                  height: 50,
                                  image: NetworkImage(snapshot.data![index]['countryInfo']['flag'])
                              ),
                            );

                          }else {
                            return Container();
                          }
                      });
                    }else {

                      return ListView.builder(
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return Shimmer.fromColors(
                              baseColor: Colors.grey.shade700,
                              highlightColor: Colors.grey.shade100,
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Container(height: 10, width: 80, color: Colors.white,),
                                    subtitle: Container(height: 10, width: 80, color: Colors.white,),
                                    leading: Container(height: 50, width: 50, color: Colors.white,)
                                  )
                                ],
                              ),
                            );
                          });
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}

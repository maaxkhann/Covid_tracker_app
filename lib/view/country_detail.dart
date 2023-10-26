import 'package:covid_tracker/view/world_states.dart';
import 'package:flutter/material.dart';

class CountryDetailScreen extends StatelessWidget {
  final snapshot;

  const CountryDetailScreen({Key? key, required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade200,
      appBar: AppBar(
        title: Text(snapshot['country']),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.07),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.07),
                    child: Center(
                      child: Card(
                        color: Colors.teal,
                        child: Column(
                          children: [
                            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                            ReUsableRow(title: 'Cases', value: snapshot['cases'].toString()),
                            ReUsableRow(title: 'Today Cases', value: snapshot['todayCases'].toString()),
                            ReUsableRow(title: 'Recovered', value: snapshot['recovered'].toString()),
                            ReUsableRow(title: 'Today Recovered', value: snapshot['todayRecovered'].toString()),
                            ReUsableRow(title: 'Deaths', value: snapshot['deaths'].toString()),
                            ReUsableRow(title: 'Today Deaths', value: snapshot['todayDeaths'].toString()),
                            ReUsableRow(title: 'Critical', value: snapshot['critical'].toString()),
                          ],
                        ),
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(snapshot['countryInfo']['flag'],), )
                ],
              ),
            ],
          ),
        ),
      )
    );
  }
}

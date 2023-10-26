import 'package:covid_tracker/model/world_states_model.dart';
import 'package:covid_tracker/services/utilities/states_services.dart';
import 'package:covid_tracker/view/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({Key? key}) : super(key: key);

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen> with TickerProviderStateMixin {

  late final AnimationController controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this)..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285f4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {

    StatesServices statesServices = StatesServices();

    return Scaffold(
      backgroundColor: Colors.teal.shade200,
      body: SafeArea(
        child: FutureBuilder(
          future: statesServices.fetchWorldStatesRecords(),
            builder: (BuildContext context, AsyncSnapshot<WorldStatesModel> snapshot) {

            if(snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
                    PieChart(
                      dataMap: {
                        'Total' : double.parse(snapshot.data!.cases.toString()),
                        'Recovered' : double.parse(snapshot.data!.recovered.toString()),
                        'Deaths' : double.parse(snapshot.data!.deaths.toString()),
                      },
                      colorList: colorList,
                      chartValuesOptions: const ChartValuesOptions(
                        showChartValuesInPercentage: true
                      ),
                      chartRadius: 130,
                      chartType: ChartType.ring,
                      ringStrokeWidth: 25,
                      animationDuration: const Duration(seconds: 2),
                      legendOptions: const LegendOptions(legendPosition: LegendPosition.left),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01,),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: Colors.teal,
                        child: Column(

                          children: [
                            ReUsableRow(title: 'Total', value: snapshot.data!.cases.toString()),
                            ReUsableRow(title: 'Deaths', value: snapshot.data!.deaths.toString()),
                            ReUsableRow(title: 'Recovered', value: snapshot.data!.recovered.toString()),
                            ReUsableRow(title: 'Active', value: snapshot.data!.active.toString()),
                            ReUsableRow(title: 'Critical', value: snapshot.data!.critical.toString()),
                            ReUsableRow(title: 'Today Deaths', value: snapshot.data!.todayDeaths.toString()),
                            ReUsableRow(title: 'Today Recovered', value: snapshot.data!.todayRecovered.toString()),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04,),

                    InkWell(
                      onTap: () => Get.to(() => const CountriesListScreen()),
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: const Center(child: Text('Track Countries', style: TextStyle(fontSize: 18),)),
                      ),
                    )
                  ],
                ),
              );
            }else {

              return Center(
                child: SpinKitFadingCircle(
                  color: Colors.black,
                  size: 50,
                  controller: controller,
                ),
              );
            }
        }),
      ),
    );
  }
}

class ReUsableRow extends StatelessWidget {

  final String title;
  final String value;

  const ReUsableRow({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, top: 5, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontSize: 18),),
              Text(value.toString(), style: const TextStyle(fontSize: 18),),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.008,),
          const Divider()
        ],
      ),
    );
  }
}


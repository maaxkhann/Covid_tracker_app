import 'dart:async';

import 'package:covid_tracker/view/world_states.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {

 late final AnimationController controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this)..repeat();

 @override

 void dispose() {
    // TODO: implement dispose
   controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
   Timer(
       const Duration(seconds: 3),
     ()=> Get.to(()=> const WorldStatesScreen())
   );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.tealAccent,
      body: SafeArea(
        child: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
         //   crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedBuilder(
                  animation: controller,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: const Center(child: Image(image: AssetImage('images/virus.png'))),
                  ),
                  builder: (BuildContext context, Widget? child) {
                    return Transform.rotate(
                      angle: controller.value * 1.5 * math.pi,
                      child: child,
                    );
                  }
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),

              const Text('Covid-19\nTracker App', textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,),)
            ],
          ),
        ),
      ),
    );
  }
}

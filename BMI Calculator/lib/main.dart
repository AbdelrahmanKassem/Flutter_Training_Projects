import 'package:flutter/material.dart';
import 'package:my_first_app/modules/bmi_app/bmi/bmi_screen.dart';


void main() async {

  runApp(MyApp());
}

class MyApp extends StatelessWidget
{
  MyApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Directionality(
        textDirection: TextDirection.ltr,
        child: BmiScreen(),
      ),
    );
  }
}

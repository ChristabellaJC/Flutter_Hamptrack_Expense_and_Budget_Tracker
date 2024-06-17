import 'package:dev_hampter/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'BalooThambi2',
        // useMaterial3: true,
      ),
      initialRoute: RoutesClass.splashScreen,
      getPages: RoutesClass.routes,
    );
  }
}

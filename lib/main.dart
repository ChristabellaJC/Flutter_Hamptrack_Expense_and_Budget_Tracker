import 'package:dev_hampter/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

//Main page
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyDt6HtG2GTAP2tKCNfbXOyO7Ahwt6RDTls",
    appId: "1:413732506963:android:ff0ab03b35af123864e5a6",
    messagingSenderId: "413732506963",
    projectId: "hamptrack",
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'BalooThambi2',
      ),
      initialRoute: RoutesClass.splashScreen,
      getPages: RoutesClass.routes,
    );
  }
}

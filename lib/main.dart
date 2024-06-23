import 'package:dev_hampter/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "your_api_key",
      appId: "your_app_id",
      messagingSenderId: "your_messaging_sender_id",
      projectId: "your_project_id",
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'BalooThambi2',
        // Define your app's theme here
      ),
      initialRoute: RoutesClass.splashScreen,
      getPages: RoutesClass.routes,
    );
  }
}

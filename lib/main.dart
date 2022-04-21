import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamro_futsal/routes.dart';
import 'package:khalti/khalti.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Khalti.init(
      publicKey: 'test_public_key_0a937a73e9c14d078201ab452a07098e',
      enabledDebugging: false);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: GetRoutes.splash,
      getPages: GetRoutes.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}

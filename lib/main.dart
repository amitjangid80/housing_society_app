import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:housing_society_app/app_theme.dart';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:housing_society_app/blocs/blocs.dart';
import 'package:housing_society_app/routes/custom_router.dart';
import 'package:housing_society_app/routes/routes.dart';
import 'package:provider/provider.dart';

final FirebaseFirestore fireStore = FirebaseFirestore.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConnectivityAppWrapper(
      app: MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: AuthBloc()),
          ChangeNotifierProvider.value(value: UsersBloc()),
        ],
        child: MaterialApp(
          theme: themeData(),
          initialRoute: homeRoute,
          title: 'Housing Society App',
          debugShowCheckedModeBanner: false,
          onGenerateRoute: CustomRouter.generateRoutes,
        ),
      ),
    );
  }
}

handleException({
  @required exception,
  @required stackTrace,
  @required String exceptionClass,
  @required String exceptionMsg,
}) {
  debugPrint('\n');
  debugPrint("========================================START OF EXCEPTION========================================");
  debugPrint("==================================================================================================");
  debugPrint('\n');
  debugPrint('$exceptionClass - $exceptionMsg: \n${exception.toString()}\n$stackTrace');
  debugPrint('\n');
  debugPrint("==================================================================================================");
  debugPrint("=========================================END OF EXCEPTION=========================================");
  debugPrint('\n');
}
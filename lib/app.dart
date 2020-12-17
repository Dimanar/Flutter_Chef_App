import 'package:flutter/material.dart';
import 'package:master_chef/resources/constants.dart';
import 'package:master_chef/resources/routegenerator.dart';
import 'package:master_chef/resources/constants.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppConstant.TITLE,
        theme: ThemeData(
          primaryColor: AppConstant.kPrimaryColor,
          textTheme: Theme.of(context).textTheme.apply(bodyColor: AppConstant.kTextColor),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/splash',
        onGenerateRoute: RouteGenerator.generatorRoute
    );
  }
}
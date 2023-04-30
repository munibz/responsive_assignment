import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_assignment/screens/desktop.dart';
import 'package:responsive_assignment/screenutils/screen_util.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'constants/size_constants.dart';
import 'extensions/size_extenstions.dart';
import 'screens/mobile.dart';
import 'widgets/project_image.dart';
import 'widgets/social_widget.dart';
import 'widgets/user_stats_widget.dart';

void main() {
  ScreenUtil.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Color(0xff0f0f0f),
        body: ResponsiveBuilder(
          builder: (context, sizingInformation) {
            if (sizingInformation.isDesktop) {
              return DesktopUI();
            }
            if (sizingInformation.isTablet) {
              return DesktopUI();
            }

            if (sizingInformation.isMobile) {
              return const MobileUI();
            }

            return Container(color: Colors.purple);
          },
        ));
  }
}



// ignore: non_constant_identifier_names

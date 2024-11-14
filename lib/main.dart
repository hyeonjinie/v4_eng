import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:v4/screens/auth/login/login_screen.dart';
import 'package:v4/screens/auth/register/signup_one.dart';
import 'package:v4/screens/auth/register/signup_two.dart';
import 'package:v4/screens/crop_info/crop_info.dart';
import 'package:v4/screens/crop_recommend.dart';
import 'package:v4/screens/growth_info/growth_info.dart';
import 'package:v4/screens/main/main_screen.dart';
import 'package:v4/screens/price_info/price_info.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // GoRouter 설정
    final GoRouter _router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => MainDashboard(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => LoginScreen(),
        ),
        GoRoute(
          path: '/register',
          builder: (context, state) => SignUpStepOne(),
        ),
        GoRoute(
          path: '/register_next',
          builder: (context, state) => SignUpStepTwo(),
        ),
        GoRoute(
          path: '/price_info',
          builder: (context, state) => PriceInfoPage(),
        ),
        GoRoute(
          path: '/growth_info',
          builder: (context, state) => GrowthInfoPage(),
        ),
        GoRoute(
          path: '/crop_info',
          builder: (context, state) => CropInfoPage(),
        ),
        GoRoute(
          path: '/crop_recommend',
          builder: (context, state) => CropRecommendPage(),
        ),
      ],
    );

    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Pretendard',
      ),
    );
  }
}

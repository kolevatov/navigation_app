import 'package:flutter/material.dart';
import 'package:navigation_app/navigation_page.dart';
import 'package:navigation_app/pages/google_offices.dart';
import 'package:navigation_app/pages/implicit_animation.dart';
import 'package:navigation_app/pages/paralax_effect.dart';
import 'package:navigation_app/pages/scoped_model.dart';
import 'package:navigation_app/pages/sqlite.dart';
import 'pages/signup_form.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portfolio app',
      routes: {
        '/signup': (context) => const SignupForm(),
        '/google': (context) => GoogleOffices(),
        '/scoped': (context) => ScopedPage(),
        '/students': (context) => const StudentPage(),
        '/box': ((context) => const AnimatedBox()),
        '/paralax': (context) => const ParalaxPage(),
      },
      home: const NavigationPage(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:navigation_app/utils/colors.dart';

class FeaturePage extends StatelessWidget {
  final Function onToggle;

  const FeaturePage({Key? key, required this.onToggle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageFeaturesBackground,
      appBar: AppBar(
        backgroundColor: AppColors.appBarFeaturesBackground,
        leading: IconButton(
          onPressed: () => onToggle(),
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ),
        title: const Text("Features examples"),
      ),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(16),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: <Widget>[
          buildCard(context, 'Signup form', 'Fields with validations and hints',
              '/signup'),
          buildCard(context, 'Public API call',
              'Display Google' 's offices list', '/google'),
          buildCard(context, 'Scoped model', 'Scoped model widgets', '/scoped'),
          buildCard(context, 'SQLite', 'SQLite demo page', '/students'),
          buildCard(context, 'Implicit animation',
              'Animated \' without border \' Box', '/box'),
          buildCard(context, 'Paralax effect', 'Scrolling with paralax effect',
              '/paralax'),
        ],
      ),
    );
  }

  Widget buildCard(
      BuildContext context, String title, String subtitle, String routeName) {
    return Card(
      color: AppColors.tileBackground,
      elevation: 8,
      child: InkWell(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              subtitle,
              softWrap: true,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.normal),
            ),
          ],
        ),
        onTap: () {
          Navigator.pushNamed(context, routeName);
        },
      ),
    );
  }
}

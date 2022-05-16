import 'package:flutter/material.dart';
import 'package:navigation_app/utils/colors.dart';

class AboutPage extends StatelessWidget {
  final Function onToggle;

  const AboutPage({Key? key, required this.onToggle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageAboutBackground,
      appBar: AppBar(
        backgroundColor: AppColors.appBarAboutBackground,
        title: const Text("About"),
        leading: IconButton(
          onPressed: () => onToggle(),
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ),
      ),
      body: const Center(
        child: Icon(
          Icons.emoji_food_beverage,
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}

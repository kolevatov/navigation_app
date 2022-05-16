import 'package:flutter/material.dart';
import 'package:navigation_app/utils/colors.dart';

class MyAppPage extends StatelessWidget {
  final Function onToggle;

  const MyAppPage({Key? key, required this.onToggle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageMyAppBackground,
      appBar: AppBar(
        backgroundColor: AppColors.appBarMyAppBackground,
        title: const Text("My Applications"),
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

import 'package:flutter/material.dart';
import 'package:navigation_app/pages/about.dart';
import 'package:navigation_app/pages/my_app_page.dart';
import 'package:navigation_app/pages/feature_page.dart';
import 'package:navigation_app/utils/colors.dart';
import 'package:navigation_app/widgets/menu_item.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage>
    with SingleTickerProviderStateMixin {
  late Widget aboutPage, myAppPage, featurePage;
  late AnimationController animationController;
  List pagesList = [];

  @override
  void initState() {
    aboutPage = AboutPage(
      onToggle: toggleNavigation,
    );
    myAppPage = MyAppPage(
      onToggle: toggleNavigation,
    );
    featurePage = FeaturePage(
      onToggle: toggleNavigation,
    );
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    pagesList.addAll([aboutPage, myAppPage, featurePage]);
    super.initState();
  }

  void toggleNavigation() => animationController.isDismissed
      ? animationController.forward()
      : animationController.reverse();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Material(
      color: AppColors.drawerBackground,
      child: Stack(
        children: [
          buildProfileCard(size),
          Transform(
            alignment: AlignmentDirectional.bottomCenter,
            transform: Matrix4.identity()
              ..scale(0.65)
              ..translate(0.0, size.height * 0.46),
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: buildBoxDecoration(),
              child: pagesList[2],
            ),
          ),
          Transform(
            alignment: AlignmentDirectional.bottomCenter,
            transform: Matrix4.identity()
              ..scale(0.75)
              ..translate(0.0, size.height * 0.55),
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: buildBoxDecoration(),
              child: pagesList[1],
            ),
          ),
          AnimatedBuilder(
            animation: animationController,
            builder: (ctx, _) {
              double scale = 1 - (animationController.value * 0.15);
              double slide = size.height * 0.64 * animationController.value;
              return Transform(
                alignment: AlignmentDirectional.bottomCenter,
                transform: Matrix4.identity()
                  ..scale(scale)
                  ..translate(0.0, slide),
                child: InkWell(
                  onTap: () {
                    animationController.isCompleted ? toggleNavigation() : null;
                  },
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: buildBoxDecoration(),
                    child: pagesList[0],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() {
    return BoxDecoration(borderRadius: BorderRadius.circular(4), boxShadow: [
      BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 16,
          spreadRadius: 4),
    ]);
  }

  Widget buildProfileCard(Size size) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 64),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 32,
                backgroundImage: AssetImage('images/avatar.png'),
              ),
              const SizedBox(
                width: 8,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Evgeny Kolevatov",
                      style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                    ),
                    const Text(
                      "Portfolio",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 50,
              ),
              IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Colors.grey,
                    size: 28,
                  ),
                  onPressed: () {
                    toggleNavigation();
                  }),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            vertical: size.height * 0.06,
            horizontal: size.width * 0.1,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    pagesList.remove(aboutPage);
                    pagesList.insert(0, aboutPage);
                  });
                  toggleNavigation();
                },
                child: const MenuItems(
                  icon: Icons.face,
                  category: "About",
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    pagesList.remove(myAppPage);
                    pagesList.insert(0, myAppPage);
                  });
                  toggleNavigation();
                },
                child: const MenuItems(
                  icon: Icons.android,
                  category: "My applications",
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    pagesList.remove(featurePage);
                    pagesList.insert(0, featurePage);
                  });
                  toggleNavigation();
                },
                child: const MenuItems(
                  icon: Icons.rocket_launch,
                  category: "Feature examples",
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

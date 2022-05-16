import 'package:flutter/material.dart';
import 'package:navigation_app/resources/images.dart';

class ParalaxPage extends StatefulWidget {
  const ParalaxPage({Key? key}) : super(key: key);

  @override
  State<ParalaxPage> createState() => _ParalaxPageState();
}

class _ParalaxPageState extends State<ParalaxPage> {
  final PageController _pageController = PageController(viewportFraction: 0.7);
  double pageOffset = 0;
  double imageSize = 250.0;

  @override
  void initState() {
    super.initState();

    _pageController.addListener(() {
      setState(() {
        pageOffset = _pageController.offset / imageSize;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView.separated(
          scrollDirection: Axis.vertical,
          controller: _pageController,
          itemCount: imagesParalax.length,
          itemBuilder: (context, index) {
            // ignore: sized_box_for_whitespace
            return Container(
              height: imageSize,
              child: Image.asset(
                imagesParalax[index],
                fit: BoxFit.fitWidth,
                alignment: Alignment(0, index - pageOffset),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 30,
            );
          },
        ),
      ),
    );
  }
}

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

    // create call back to show SnackBar
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final snackBar = SnackBar(
        content: const Text(
          'Simple paralax effect.\nThat is working using Image alignment property',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.blue,
        duration: const Duration(milliseconds: 5000),
        padding: const EdgeInsets.all(16.0),
        behavior: SnackBarBehavior.floating,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      );

      // Show SnackBar
      Future.delayed(const Duration(seconds: 1), () {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    });

    _pageController.addListener(() {
      setState(() {
        pageOffset = _pageController.offset / imageSize;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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

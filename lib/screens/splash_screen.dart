import 'package:flutter/material.dart';
import 'package:wordgridapp/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int delayInSecond = 3;
  double screenHeight = 0;
  double screenWidth = 0;

  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SizedBox(
        width: screenWidth,
        child: ColoredBox(
            color: Colors.blueAccent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text("Mobigic",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                          fontFamily: "monospace")),
                ),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Text("WHERE BUSINESS MEETS TECHNOLOGY",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        )),
                  ),
                ),
                SizedBox(
                  height: (30 / 100) * screenHeight,
                  child: const Center(
                      child: CircularProgressIndicator(
                    color: Colors.white,
                  )),
                )
              ],
            )),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(color: Colors.blueAccent),
        height: (10 / 100) * screenHeight,
        child: const Center(
            child: Text(
          "MOBIGIC® TECHNOLOGIES PRIVATE LIMITED",
          style: TextStyle(
              color: Colors.white, fontSize: 10, fontWeight: FontWeight.normal),
        )),
      ),
    );
  }

  void _navigateToHome() {
    Future.delayed(Duration(seconds: delayInSecond)).then((value) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
        (route) => false,
      );
    });
  }
}

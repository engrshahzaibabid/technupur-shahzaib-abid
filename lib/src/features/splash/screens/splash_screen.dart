import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shahzaib_abid/src/constants/asset_string.dart';
import 'package:shahzaib_abid/src/features/home/screens/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SvgPicture.asset(AssetString.bg),
          Align(
              alignment: Alignment.center,
              child: SvgPicture.asset(AssetString.logo)),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: SvgPicture.asset(AssetString.tp)),
          ),
        ],
      ),
    );
  }
}

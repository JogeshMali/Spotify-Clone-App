import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/core/configs/assets/app_vectors.dart';
import 'package:spotify/presentation/intro/pages/get_intro.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    redirect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: SvgPicture.asset(AppVectors.logo)),
    );
  }

  Future<void> redirect() async {
    await Future.delayed(Duration(seconds: 3));
    // Navigator.pushReplacement(context,
    //     MaterialPageRoute(builder: (BuildContext context) => GetIntroPage()));
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => GetIntroPage()));
  }
}

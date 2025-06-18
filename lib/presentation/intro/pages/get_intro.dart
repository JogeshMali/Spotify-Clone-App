import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/common/widgets/basic_app_button.dart';
import 'package:spotify/core/configs/assets/app_images.dart';
import 'package:spotify/core/configs/assets/app_vectors.dart';
import 'package:spotify/core/configs/theme/app_color.dart';
import 'package:spotify/presentation/choose_mode/pages/choose_mode.dart';

class GetIntroPage extends StatelessWidget {
  const GetIntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Container(
          padding: EdgeInsets.symmetric(vertical: 40, horizontal: 40),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AppImages.introBg), fit: BoxFit.fill))),
      Container(
        color: Colors.black.withOpacity(0.15),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 40),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: SvgPicture.asset(
                AppVectors.logo,
              ),
            ),
            Spacer(),
            Text(
              'Enjoy Listening to Music',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            SizedBox(
              height: 21,
            ),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
              style: TextStyle(
                  fontSize: 13,
                  color: Appcolor.grey,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            BasicAppButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => ChooseModePage()));
              },
              title: 'Get Started ',
            )
          ],
        ),
      ),
    ]));
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/common/widgets/basic_app_button.dart';
import 'package:spotify/core/configs/assets/app_images.dart';
import 'package:spotify/core/configs/assets/app_vectors.dart';
import 'package:spotify/core/configs/theme/app_color.dart';
import 'package:spotify/presentation/auth/pages/signup_or_signin_page.dart';
import 'package:spotify/presentation/choose_mode/bloc/theme_cubit.dart';

class ChooseModePage extends StatelessWidget {
  const ChooseModePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Container(
          padding: EdgeInsets.symmetric(vertical: 40, horizontal: 40),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AppImages.chooseModeBg),
                  fit: BoxFit.fill))),
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
              'Choose Mode',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            SizedBox(
              height: 40,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      context.read<ThemeCubit>().updateTheme(ThemeMode.dark);
                    },
                    child: ClipOval(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                              color: Color(0xff30393C).withOpacity(0.5),
                              shape: BoxShape.circle),
                          child: SvgPicture.asset(
                            AppVectors.moon,
                            fit: BoxFit.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'DarkMode',
                    style: TextStyle(
                        color: Appcolor.grey,
                        fontSize: 13,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
              SizedBox(
                width: 40,
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      context.read<ThemeCubit>().updateTheme(ThemeMode.light);
                    },
                    child: ClipOval(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                              color: Color(0xff30393C).withOpacity(0.5),
                              shape: BoxShape.circle),
                          child: SvgPicture.asset(
                            AppVectors.sun,
                            fit: BoxFit.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'LightMode',
                    style: TextStyle(
                        color: Appcolor.grey,
                        fontSize: 13,
                        fontWeight: FontWeight.w500),
                  )
                ],
              )
            ]),
            SizedBox(
              height: 40,
            ),
            BasicAppButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SignupOrSigninPage()));
              },
              title: 'Continue ',
            )
          ],
        ),
      ),
    ]));
  }
}

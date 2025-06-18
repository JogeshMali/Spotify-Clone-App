import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/common/helper/is_dark_mode.dart';
import 'package:spotify/common/widgets/basic_app_bar.dart';
import 'package:spotify/common/widgets/basic_app_button.dart';
import 'package:spotify/core/configs/assets/app_images.dart';
import 'package:spotify/core/configs/assets/app_vectors.dart';
import 'package:spotify/core/configs/theme/app_color.dart';
import 'package:spotify/presentation/auth/pages/signin_page.dart';
import 'package:spotify/presentation/auth/pages/signup_page.dart';

class SignupOrSigninPage extends StatelessWidget {
  const SignupOrSigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Image.asset(
              AppImages.auth_bg,
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(
              AppVectors.top_pattern,
              alignment: Alignment.topRight,
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: SvgPicture.asset(
              AppVectors.bottom_pattern,
              alignment: Alignment.bottomRight,
            ),
          ),
          Align(
            alignment: Alignment.center,
         child:  Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AppVectors.logo,
                ),
                SizedBox(
                  height: 55,
                ),
                Text('Enjoy listening to music',
                    style: TextStyle(

                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
                SizedBox(
                  height: 21,
                ),
                Text(
                    'Spotify is a proprietary Swedish audio streaming and media services provider',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: context.isDarkMode?Appcolor.grey:Appcolor.darkGrey,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children : [
                    Expanded(
                        flex : 1,
                        child: BasicAppButton(onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupPage())), title: 'Register')
                    ),
                    const SizedBox(width: 20,),

                    Expanded(child:
                    TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>SigninPage()));},

                        child: Text('Sign in' ,
                          style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                            color: context.isDarkMode? Colors.white:Colors.black
                        ),)))

                  ]
                )
              ],
            ),
          )
          )
        ],
      ),
    );
  }
}

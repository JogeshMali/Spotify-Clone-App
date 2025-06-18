import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotify/common/widgets/basic_app_bar.dart';
import 'package:spotify/common/widgets/basic_app_button.dart';
import 'package:spotify/common/widgets/basic_textfield.dart';
import 'package:spotify/core/configs/assets/app_vectors.dart';
import 'package:spotify/core/configs/theme/app_color.dart';
import 'package:spotify/data/models/auth/signin_user_req.dart';
import 'package:spotify/domain/usecases/auth/signinUsecase.dart';
import 'package:spotify/presentation/auth/pages/signup_page.dart';
import 'package:spotify/presentation/home/pages/home_page.dart';
import 'package:svg_flutter/svg.dart';

import '../../../service_locator.dart';

class SigninPage extends StatelessWidget {
  SigninPage({super.key});

  final TextEditingController _email =TextEditingController();
  final TextEditingController _password =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(title :SvgPicture.asset(AppVectors.logo,height: 40,width: 40,)
        ,),
      bottomNavigationBar: _signupText(context),
      body:

       SingleChildScrollView(
         padding:EdgeInsets.symmetric(vertical: 50,horizontal: 30),
       child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Sign in ',textAlign:TextAlign.center,style: TextStyle(fontSize:30,fontWeight: FontWeight.bold ),),
          SizedBox(height: 38,),
          BasicTextfield(title: 'Enter your email or username ',controller: _email,),
          SizedBox(height: 20,),
          BasicTextfield(title: 'Enter your password ',controller: _password,icon: Icon(CupertinoIcons.eye_slash),),
          SizedBox(height: 20,),
          BasicAppButton(onPressed: ()async {
            var result = await sl<SigninUseCase>().call(
                params: SigninUserReq(
                    email: _email.text.toString(),
                    password: _password.text.toString())
            );
            result.fold((l){
              var snackbar = SnackBar(content: Text(l));
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
            }, (r){
              var snackbar = SnackBar(content: Text(r));
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>HomePage()), (route)=>false);
            });
          }, title: 'Sign In')
        ],
      ),)

    );
    
  }
  Widget _signupText(BuildContext context){
    return Padding(padding: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Not A Member?',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),

          TextButton(onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupPage())),style: ButtonStyle(
              textStyle: WidgetStatePropertyAll(TextStyle(fontWeight: FontWeight.w500,fontSize: 15))
          ), child: Text('Register Now'))
        ],
      ),);
  }
}

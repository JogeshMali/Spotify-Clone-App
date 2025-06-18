

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/common/widgets/basic_app_bar.dart';
import 'package:spotify/common/widgets/basic_textfield.dart';
import 'package:spotify/data/models/auth/create_user_req.dart';
import 'package:spotify/domain/usecases/auth/signup_usecase.dart';
import 'package:spotify/presentation/auth/pages/signin_page.dart';
import 'package:spotify/presentation/home/pages/home_page.dart';

import '../../../common/widgets/basic_app_button.dart';
import '../../../core/configs/assets/app_vectors.dart';
import '../../../service_locator.dart';

class SignupPage extends StatelessWidget {
   SignupPage({super.key});
   final TextEditingController _fullName =TextEditingController();
   final TextEditingController _email =TextEditingController();
   final TextEditingController _password =TextEditingController();

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(title :SvgPicture.asset(AppVectors.logo,height: 40,width: 40,)
        ,),
      bottomNavigationBar: _signinText(context),
      body: SingleChildScrollView(
        padding:EdgeInsets.symmetric(vertical: 50,horizontal: 30),
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        Text('Register',textAlign: TextAlign.center,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
        SizedBox(height: 40,),
        BasicTextfield(title: 'Full Name',controller: _fullName,),
        SizedBox(height: 20,),
        BasicTextfield(title: 'Email',controller: _email,),
        SizedBox(height: 20,),
        BasicTextfield(title: 'Password',icon: Icon(CupertinoIcons.eye_slash),controller: _password,),
        SizedBox(height: 20,),
        BasicAppButton(onPressed: () async {
          var result = await sl<SignUpUseCase>().call(
            params: CreateUserReq(
                fullName: _fullName.text.toString(),
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
        }, title: 'Create Account')

        ],
      ),),
    );
  }
  Widget _signinText(BuildContext context){
    return Padding(padding: EdgeInsets.symmetric(vertical: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Do you have an account ?',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),

        TextButton(onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>SigninPage())),style: ButtonStyle(
          textStyle: WidgetStatePropertyAll(TextStyle(fontWeight: FontWeight.w500,fontSize: 15))
        ), child: Text('Sign in'))
      ],
    ),);
  }

}

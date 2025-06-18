import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify/core/configs/constants/app_urls.dart';
import 'package:spotify/data/models/auth/UserModel.dart';
import 'package:spotify/data/models/auth/create_user_req.dart';
import 'package:spotify/data/models/auth/signin_user_req.dart';
import 'package:spotify/domain/entities/auth/user.dart';

abstract class AuthFirebaseService{
  Future<Either> signup(CreateUserReq createUserReq);
  Future<Either> signin(SigninUserReq signinUserReq);
  Future<Either> getUser();
}
class AuthFirebaseServiceImpl extends AuthFirebaseService{
  @override
  Future<Either> signin(SigninUserReq signinUserReq) async {
    try{
      await  FirebaseAuth.instance.signInWithEmailAndPassword(
          email: signinUserReq.email,
          password: signinUserReq.password);

      return Right('Signin is Successful');
    }on FirebaseAuthException catch(e){
      String message = '';
      if(e.code == 'invalid-email') {
        message = 'User not found for that email';
      } else if (e.code == 'invalid-credential') {
        message = 'Wrong password';
      }
      return Left(message);
    }
  }

  @override
  Future<Either> signup(CreateUserReq createUserReq) async{
    try{
    var data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: createUserReq.email,
        password: createUserReq.password);
    print("User UID: ${data.user?.uid}");  // Debugging line
    FirebaseFirestore.instance.collection('Users').doc(data.user?.uid)
        .set(
        {
          'name' : createUserReq.fullName,
          'email' : data.user?.email,
        }
    );
    return Right('Signup is Successful');
    }on FirebaseAuthException catch(e){
      String message = '';
      if(e.code == 'weak-password') {
        message = 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exists with that email.';
      }
      return Left(message);
    }
  }

  @override
  Future<Either> getUser()async {
    try{
      FirebaseAuth firebaseAuth =FirebaseAuth.instance;
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      var user = await firebaseFirestore.collection('Users').doc(firebaseAuth.currentUser?.uid).get();
      UserModel userModel = UserModel.fromJson(user.data()!);
      userModel.photoUrl = firebaseAuth.currentUser?.photoURL ?? AppURLs.defaultImage;
      UserEntity userEntity = userModel.toEntity();
      return Right(userEntity);
    }catch(e){
      return left('An error occured');
    }
  }

}
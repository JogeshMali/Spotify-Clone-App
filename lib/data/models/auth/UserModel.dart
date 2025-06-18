import 'package:spotify/domain/entities/auth/user.dart';

class UserModel {


  String ?fullName;
  String ?email;
  String? photoUrl;



  UserModel({
    this.fullName,
    this.email,
    this.photoUrl
  });

  UserModel.fromJson(Map<String, dynamic> data){
    fullName = data['name'];
    email = data['email'];
  }
}
extension UserModelX on UserModel{
  UserEntity toEntity(){
  return UserEntity(photoUrl:photoUrl,fullName:fullName,email:email);
  }
}





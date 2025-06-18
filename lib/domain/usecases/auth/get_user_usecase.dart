import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecase/usecase.dart';
import 'package:spotify/domain/respository/auth/auth.dart';

import '../../../service_locator.dart';

class GetUserUseCase extends UseCase<Either,dynamic>{
  @override
  Future<Either> call({params}) async {
   return await sl<AuthRepository>().getUser();
  }

}
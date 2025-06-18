import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecase/usecase.dart';
import 'package:spotify/data/sources/song/song_firebase_service.dart';
import 'package:spotify/domain/respository/song/song_repository.dart';

import '../../../service_locator.dart';

class UserFavoriteSongUseCase extends UseCase<Either,dynamic>{
  @override
  Future<Either> call({params}) async{
    return await sl<SongRespository>().getUserFavoriteSong();
  }

}
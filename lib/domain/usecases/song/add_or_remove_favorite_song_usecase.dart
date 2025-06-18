import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecase/usecase.dart';
import 'package:spotify/domain/respository/song/song_repository.dart';

import '../../../service_locator.dart';

class addOrRemoveFavoriteSongUsecase extends UseCase<Either,String>{
  @override
  Future<Either> call({String? params})async {
   return await sl<SongRespository>().addOrRemoveFavoriteSong(params!);
  }

}

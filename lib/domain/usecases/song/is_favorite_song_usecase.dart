import 'package:spotify/core/usecase/usecase.dart';

import '../../../service_locator.dart';
import '../../respository/song/song_repository.dart';

class isFavoriteSongUsecase extends UseCase<bool,String>{
  @override
  Future<bool> call({String ?params}) async{
    return await sl<SongRespository>().isFavoriteSong(params!);
  }

}
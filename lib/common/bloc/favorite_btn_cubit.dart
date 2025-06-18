import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/common/bloc/favorite_btn_state.dart';
import 'package:spotify/domain/usecases/song/add_or_remove_favorite_song_usecase.dart';

import '../../service_locator.dart';

class FavoriteBtnCubit extends Cubit<FavoriteBtnState>{
  FavoriteBtnCubit():super(FavoriteBtnInitial());

  Future<void> favoriteBtnUpdated (String songId)async{
    var result = await sl<addOrRemoveFavoriteSongUsecase>().call(params:songId );
    result.fold((l){}, (isFavorite){emit(FavoriteBtnUpdated(isFavorite: isFavorite));});
  }
}
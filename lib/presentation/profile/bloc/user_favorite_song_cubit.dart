
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/domain/usecases/song/user_favorite_song_usecase.dart';
import 'package:spotify/presentation/profile/bloc/user_favorite_song_state.dart';

import '../../../domain/entities/song/song_entity.dart';
import '../../../service_locator.dart';

class UserFavoriteSongCubit extends Cubit<UserFavoriteSongState>{
  UserFavoriteSongCubit():super(UserFavoriteSongLoading());
  List<SongEntity> favoriteSongs = [];
  Future<void> getFavoriteSong()async{
    var favSong = await sl<UserFavoriteSongUseCase>().call();
    favSong.fold((l)=>emit(UserFavoriteSongFailure()), (r){
      favoriteSongs=r;
      emit(UserFavoriteSongLoaded(favoriteSongs: favoriteSongs));
    });
  }
  Future<void> removeSong(int index)async{


    favoriteSongs.removeAt(index);
    emit(UserFavoriteSongLoaded(favoriteSongs: favoriteSongs));
  }
}

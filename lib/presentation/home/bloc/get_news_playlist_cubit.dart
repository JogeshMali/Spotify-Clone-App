import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/domain/usecases/song/get_news_playlist_usecase.dart';
import 'package:spotify/presentation/home/bloc/get_news_playlist_state.dart';

import '../../../service_locator.dart';

class GetNewsPlaylistCubit extends Cubit<GetNewsPlaylistState>{
   GetNewsPlaylistCubit():super(NewsPlaylistLoading());
   Future<void> getNewsPlaylist ()async {
     var returnedSong = await sl<GetNewsPlaylistUsecase>().call();
     returnedSong.fold((l) {
       emit(NewsPlaylistLoadFailure());
     }, (data) {
       emit(NewsPlaylistLoaded(songs: data));
     });
   }
}
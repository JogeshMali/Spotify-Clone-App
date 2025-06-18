import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/domain/usecases/song/get_news_song_usecase.dart';
import 'package:spotify/presentation/home/bloc/news_song_state.dart';

import '../../../service_locator.dart';

class NewsSongCubit extends Cubit<NewsSongState>{
  NewsSongCubit():super(NewsSongLoading());

  Future<void> getNewsSongs ()async{
    var returnedSong  = await sl<GetNewsSongUseCase>().call();
    returnedSong.fold((l){
      emit(NewsSongLoadFailure());
    }, (data){
      emit(NewsSongLoaded(songs: data));
    });
  }
}
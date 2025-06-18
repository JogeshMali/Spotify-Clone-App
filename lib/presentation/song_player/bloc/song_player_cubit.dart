import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spotify/presentation/song_player/bloc/song_player_state.dart';

class SongPlayerCubit extends Cubit<SongPlayerState>{
  AudioPlayer audioPlayer = new AudioPlayer();
  Duration  songDuration =  Duration.zero;
  Duration  songPosition =  Duration.zero;
  SongPlayerCubit():super(SongPlayerLoading()){
    audioPlayer.positionStream.listen((position){
      songPosition = position;
      updateSong();
      });
    audioPlayer.durationStream.listen((duration){
      songDuration = duration!;
      updateSong();
    });
  }



  void updateSong(){
    emit(SongPlayerLoaded());
  }

  Future<void> loadSong(String url) async{
    try{
      await audioPlayer.setAudioSource(AudioSource.asset(url));
      audioPlayer.play();
      emit(SongPlayerLoaded());
    }catch(e){
      emit(SongPlayerLoadFailure());
    }
  }

  void playOrPause(){
    if(audioPlayer.playing){
      audioPlayer.pause();
    }
    else{
      audioPlayer.play();
    }
    emit(SongPlayerLoaded());
  }
  @override
  Future<void> close() {
    audioPlayer.dispose();
    return super.close();
  }
}
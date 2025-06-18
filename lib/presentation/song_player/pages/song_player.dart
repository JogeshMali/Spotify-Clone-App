import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/common/widgets/basic_app_bar.dart';
import 'package:spotify/domain/entities/song/song_entity.dart';
import 'package:spotify/presentation/song_player/bloc/song_player_cubit.dart';
import 'package:spotify/presentation/song_player/bloc/song_player_state.dart';

import '../../../common/widgets/favorite_button.dart';
import '../../../core/configs/theme/app_color.dart';


class SongPlayerPage extends StatelessWidget {
  final SongEntity songEntity ;
  const SongPlayerPage({super.key, required this.songEntity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: Text('Now Playing',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
      ),
      body:BlocProvider(create: (_)=>SongPlayerCubit()..loadSong('assets/songs/${songEntity.artist.replaceAll(RegExp(r'[, ]'),'_')}-${songEntity.title.replaceAll(RegExp(r'[, ]'),'_')}.mp3'),

      child: SingleChildScrollView(
        child:Padding(padding: EdgeInsets.symmetric(vertical: 16,horizontal: 16),
        child: Column(
          children: [
            _songCover(context),
             SizedBox(height: 20,),
            _songDetail(),
             SizedBox(height: 30,),
            _songPlayer(context)
          ],
        ),

      )
      ),
    )
    );
  }

  Widget _songCover(BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height/2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
                'assets/images/coversImg/${songEntity.artist.replaceAll(RegExp(r'[, ]'), '_')}-${songEntity.title.replaceAll(RegExp(r'[, ]'), '_')}.jpg'
            )
        )
      ),
    );
  }

  Widget _songDetail(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text(songEntity.title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
        SizedBox(height: 5,),
        Text(songEntity.artist,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14),),
    ],
    ),
        FavoriteButton(songEntity: songEntity)

      ]);
  }
  
  Widget _songPlayer(BuildContext context){
    return BlocBuilder<SongPlayerCubit,SongPlayerState>(
        builder:( context,state){
        if(state is SongPlayerLoading )
          return Container(alignment: Alignment.center,child: CircularProgressIndicator());
        if(state is SongPlayerLoaded){
          return Column(
            children: [
            GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTapDown: (details) {
              /// **Get Tap Position Relative to the Slider Width**
              RenderBox renderBox = context.findRenderObject() as RenderBox;
              double tapPosition = renderBox.globalToLocal(details.globalPosition).dx;

              /// **Calculate Seek Position Based on Tap**
              double newPositionInSeconds = (tapPosition / renderBox.size.width) * songEntity.duration*60;

              /// **Seek to the New Position**
              context.read<SongPlayerCubit>().audioPlayer.seek(Duration(seconds: newPositionInSeconds.toInt()));
            },
              child: Slider(
                  value: context.read<SongPlayerCubit>().songPosition.inSeconds.toDouble(),
                  min: 0.0,
                  max: context.read<SongPlayerCubit>().songDuration.inSeconds.toDouble(),
                  onChanged: (value){SongPlayerCubit().audioPlayer.seek(Duration(seconds: value.toInt()));}
              )
            ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text(
                  formatDuration(
                    context.read<SongPlayerCubit>().songPosition
                  )
                ),
                Text(
                    formatDuration(
                        context.read<SongPlayerCubit>().songDuration
                    )
                ),
                ]
              ),
              GestureDetector(
                onTap: (){
                  context.read<SongPlayerCubit>().playOrPause();
                },
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Appcolor.primary
                  ),
                  child: Icon(
                      context.read<SongPlayerCubit>().audioPlayer.playing ? Icons.pause : Icons.play_arrow
                  ),
                ),
              )
            ],
          );
        }
        return Container();
    });
  }
  String formatDuration(Duration duration){
    final min = duration.inMinutes.remainder(60);
    final sec = duration.inSeconds.remainder(60);
    return '${min.toString().padLeft(2,'0')}:${sec.toString().padLeft(2,'0')}';
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/common/helper/is_dark_mode.dart';
import 'package:spotify/common/widgets/favorite_button.dart';
import 'package:spotify/core/configs/theme/app_color.dart';
import 'package:spotify/domain/entities/song/song_entity.dart';
import 'package:spotify/presentation/home/bloc/get_news_playlist_cubit.dart';
import 'package:spotify/presentation/home/bloc/get_news_playlist_state.dart';
import 'package:spotify/presentation/song_player/pages/song_player.dart';

class GetNewsPlaylist extends StatelessWidget {
  const GetNewsPlaylist({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create:(_)=> GetNewsPlaylistCubit()..getNewsPlaylist(),
        child:  BlocBuilder<GetNewsPlaylistCubit,GetNewsPlaylistState>(
                builder: (context,state){
                  if(state is NewsPlaylistLoadFailure){
                    return Container(alignment:Alignment.center,child: CircularProgressIndicator(),);
                  }
                  if(state is NewsPlaylistLoaded){

                    return
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 40,
                              horizontal: 16
                          ),
                          child:Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('PlayLists',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                            Text('See More',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 12,color: Appcolor.grey),),

                          ],

                        ),
                        SizedBox(height: 20,),

                        _songsLoad(state.songs)
                      ],
                    ));
                  }

                  return Container();

                })

    );
  }
  Widget _songsLoad(List<SongEntity> songs){
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context,index){

          return
             GestureDetector(
               onTap: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>SongPlayerPage(songEntity: songs[index],))),
             child:
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
               children: [
                Container(
                  width: 40,
                  height: 40,

                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.isDarkMode? Appcolor.darkGrey:Color(0xffE6E6E6)
                  ),
                  child: Icon(Icons.play_arrow_rounded,color: context.isDarkMode? Color(0xff959595):Color(0xff555555)),
                ),

                  const SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(songs[index].title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                    SizedBox(height: 5,),
                    Text(songs[index].artist,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 12),),

                  ],
                ),
               ],),
                  Row(
                    children: [
                      Text(songs[index].duration.toString().replaceAll('.', ':')),
                      SizedBox(width: 20,),
                      FavoriteButton(songEntity: songs[index])
                    ],
                  )
                ]));
        },
        separatorBuilder: (context,index)=>SizedBox(height: 8,),
        itemCount: songs.length);
  }

}

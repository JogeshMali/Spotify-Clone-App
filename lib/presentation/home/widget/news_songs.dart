import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/common/helper/is_dark_mode.dart';
import 'package:spotify/core/configs/constants/app_urls.dart';
import 'package:spotify/core/configs/theme/app_color.dart';
import 'package:spotify/domain/entities/song/song_entity.dart';
import 'package:spotify/presentation/home/bloc/news_song_cubit.dart';
import 'package:spotify/presentation/home/bloc/news_song_state.dart';

import '../../song_player/pages/song_player.dart';

class NewsSongs extends StatelessWidget {
  const NewsSongs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create:(_)=> NewsSongCubit()..getNewsSongs(),
        child: SizedBox(
          height: 200,
          child: BlocBuilder<NewsSongCubit,NewsSongState>(
              builder: (context,state){
                if(state is NewsSongLoading){
                  return Container(alignment:Alignment.center,child: CircularProgressIndicator(),);
                }
                if(state is NewsSongLoaded){
                  return _songsLoad(state.songs);
                }

                  return Container();

              })
        )
    );
  }

  Widget _songsLoad(List<SongEntity> songs){
    return  ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context,index){
         // print('Image path: assets/images/coversImg/${songs[index].artist}-${songs[index].title}.jpg');
          return GestureDetector(
            onTap: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>SongPlayerPage(songEntity: songs[index],))),
            child: SizedBox(
           width: 160,
           child:Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Expanded(
                   child:Container(
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(30),
                       image: DecorationImage(
                           fit: BoxFit.cover,
                           image: AssetImage('assets/images/coversImg/${songs[index].artist.replaceAll(RegExp(r'[, ]'), '_')}-${songs[index].title.replaceAll(RegExp(r'[, ]'), '_')}.jpg')
                       ),

                     ),
                     child: Align(
                       alignment: Alignment.bottomRight,
                       child: Container(
                       width: 40,
                       height: 40,
                       transform: Matrix4.translationValues(10, 10, 0),
                       decoration: BoxDecoration(
                         shape: BoxShape.circle,
                         color: context.isDarkMode? Appcolor.darkGrey:Color(0xffE6E6E6)
                       ),
                       child: Icon(Icons.play_arrow_rounded,color: context.isDarkMode? Color(0xff959595):Color(0xff555555)),
                     ),
                   ))),
               SizedBox(height: 10,),
               Text(songs[index].title,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
               SizedBox(height: 5,),
               Text(songs[index].artist,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400),),
             ],
           ) ,
         ));
        },
        separatorBuilder: (context,index)=>SizedBox(width: 14,),
        itemCount: songs.length
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/common/helper/is_dark_mode.dart';
import 'package:spotify/common/widgets/basic_app_bar.dart';
import 'package:spotify/core/configs/theme/app_color.dart';
import 'package:spotify/presentation/profile/bloc/profile_info_cubit.dart';
import 'package:spotify/presentation/profile/bloc/profile_info_state.dart';
import 'package:spotify/presentation/profile/bloc/user_favorite_song_cubit.dart';
import 'package:spotify/presentation/profile/bloc/user_favorite_song_state.dart';
import 'package:spotify/presentation/song_player/pages/song_player.dart';

import '../../../common/widgets/favorite_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: BasicAppBar(title: Text('Profile'),backgroundColor: Color(0x2C3B3B3B),),
    body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _profileInfo(context),
        SizedBox(height: 20,),
        _favSongPlayList()
      ],
    )
    );
    
  }

  Widget _profileInfo(BuildContext context){
    return BlocProvider(create: (_)=>ProfileInfoCubit()..getUser(),
    child:
      Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height/3.5,
      decoration: BoxDecoration(
          color: context.isDarkMode? Color(0x2C3B3B3B):Appcolor.grey,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50),bottomRight: Radius.circular(50))
      ),
    child: BlocBuilder<ProfileInfoCubit,ProfileInfoState>(
        builder: (context,state){
        if(state is ProfileInfoFailure){
          return Text('Try again ');
        }
        if(state is ProfileInfoLoading ){
          return Align(alignment: Alignment.center,child: CircularProgressIndicator(),);
        }
        if(state is ProfileInfoLoaded){
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image: NetworkImage(state.userEntity.photoUrl!))
                ),
              ),
              SizedBox(height: 15,),
              Text(state.userEntity.email!,),
              SizedBox(height: 10,),
              Text(state.userEntity.fullName!,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
            ],
          );
        }
        return Container();
        }
        ),
      )

    );
  }
  Widget _favSongPlayList(){
    return BlocProvider(create: (context)=>UserFavoriteSongCubit()..getFavoriteSong(),
    child:Padding(padding: EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text('FAVORITE SONGS'),
        const SizedBox(
          height: 20,
        ),
        BlocBuilder<UserFavoriteSongCubit,UserFavoriteSongState>(
        builder: (context,state){
          if(state is UserFavoriteSongFailure){
            return Text('Try again ');
          }
          if(state is UserFavoriteSongLoading ){
            return Align(alignment: Alignment.center,child: CircularProgressIndicator(),);
          }
          if(state is UserFavoriteSongLoaded){
            return  ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context,index){
                   return GestureDetector(
                     onTap:()=> Navigator.push(context,MaterialPageRoute(builder: (context)=> SongPlayerPage(songEntity: state.favoriteSongs[index]))),
                     child:
                   Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Row(
                           children: [
                             Container(
                               width: 70,
                               height: 70,

                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(20),
                                 image: DecorationImage(
                                     image: AssetImage(
                                         'assets/images/coversImg/${state.favoriteSongs[index].artist.replaceAll(RegExp(r'[, ]'), '_')}-${state.favoriteSongs[index].title.replaceAll(RegExp(r'[, ]'), '_')}.jpg'
                                     ))
                               ),

                             ),

                             const SizedBox(width: 10,),
                             Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text(state.favoriteSongs[index].title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                 SizedBox(height: 5,),
                                 Text(state.favoriteSongs[index].artist,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 12),),

                               ],
                             ),
                           ],),
                         Row(
                           children: [
                             Text(state.favoriteSongs[index].duration.toString().replaceAll('.', ':')),
                             SizedBox(width: 20,),

                             FavoriteButton(songEntity: state.favoriteSongs[index],key: UniqueKey(),function: ()=>context.read<UserFavoriteSongCubit>().removeSong(index))
                           ],
                         )
                       ]));
                },
                separatorBuilder: (context,index)=>SizedBox(height: 20,),
                itemCount: state.favoriteSongs.length);

          }
          return Container();
        })]
    ),
    ));
  }
  
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/common/bloc/favorite_btn_cubit.dart';
import 'package:spotify/common/bloc/favorite_btn_state.dart';
import 'package:spotify/domain/entities/song/song_entity.dart';

import '../../core/configs/theme/app_color.dart';

class FavoriteButton extends StatelessWidget {
  final SongEntity songEntity;
  final Function? function;
  const FavoriteButton({super.key, required this.songEntity,  this.function});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_)=>FavoriteBtnCubit(),
    child: BlocBuilder<FavoriteBtnCubit,FavoriteBtnState>(
        builder: (context,state){
          if(state is FavoriteBtnInitial){
            return IconButton(
                onPressed: ()async{
                  await context.read<FavoriteBtnCubit>().favoriteBtnUpdated(songEntity.songId);
                  if(function!= null){
                    function!();
                  }
                  },
                icon: Icon(
                 songEntity.isFavorite?Icons.favorite: Icons.favorite_outline_outlined,
                  size:25,color: Appcolor.darkGrey ,));
          }
          if(state is FavoriteBtnUpdated){
            return IconButton(
                onPressed: ()=>context.read<FavoriteBtnCubit>().favoriteBtnUpdated(songEntity.songId),
                icon: Icon(
                  state.isFavorite?Icons.favorite: Icons.favorite_outline_outlined,
                  size:25,color: Appcolor.darkGrey ,));
          }
          return Container();
        }
    ),
    );
  }
}

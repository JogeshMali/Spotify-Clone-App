import 'package:spotify/domain/entities/song/song_entity.dart';

abstract class UserFavoriteSongState {}
class UserFavoriteSongLoading extends UserFavoriteSongState{}
class UserFavoriteSongLoaded extends UserFavoriteSongState{
  final List<SongEntity> favoriteSongs ;
  UserFavoriteSongLoaded({required this.favoriteSongs});
}
class  UserFavoriteSongFailure extends UserFavoriteSongState{}
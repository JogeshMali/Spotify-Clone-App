import 'package:spotify/domain/entities/song/song_entity.dart';

abstract class NewsSongState {}
class NewsSongLoading extends NewsSongState{}
class NewsSongLoaded extends NewsSongState{
  final List<SongEntity> songs ;
  NewsSongLoaded({required this.songs});
}
class NewsSongLoadFailure extends NewsSongState{}
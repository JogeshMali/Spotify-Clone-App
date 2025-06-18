import 'package:spotify/domain/entities/song/song_entity.dart';

abstract class GetNewsPlaylistState {}
class NewsPlaylistLoading extends GetNewsPlaylistState{}
class NewsPlaylistLoaded extends GetNewsPlaylistState{
  final List<SongEntity> songs ;
  NewsPlaylistLoaded({required this.songs});
}
class NewsPlaylistLoadFailure extends GetNewsPlaylistState{}
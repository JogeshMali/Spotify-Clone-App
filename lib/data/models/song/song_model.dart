import 'package:spotify/domain/entities/song/song_entity.dart';
import 'package:spotify/domain/usecases/song/is_favorite_song_usecase.dart';

class SongModel{
   String ?title,artist,songId;
   num ?duration;
   bool? isFavorite;
  SongModel({
    required this.title,
    required this.artist,
    required this.duration,
    required this.isFavorite,
    required this.songId});

  SongModel.fromJson(Map<String,dynamic> data){
     title = data['title'];
     artist =data['artist'];
     duration =data['duration'];

  }
}
extension SongModelX on SongModel{
  SongEntity toEntity(){
    return SongEntity(title: title!, artist: artist!,duration: duration!,isFavorite:isFavorite!,songId: songId!);
  }
}
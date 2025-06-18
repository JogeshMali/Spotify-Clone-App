import 'package:dartz/dartz.dart';
import 'package:spotify/data/sources/song/song_firebase_service.dart';
import 'package:spotify/domain/respository/song/song_repository.dart';

import '../../../service_locator.dart';

class SongRepositoryImpl extends SongRespository{
  @override
  Future<Either> getNewSongs() async{
    return await sl<SongFirebaseService>().getNewSongs();
  }

  @override
  Future<Either> getNewsPlaylist() async{
    return await sl<SongFirebaseService>().getNewsPlaylist();
  }
  @override
  Future<Either> addOrRemoveFavoriteSong(String songId) async{
    return await sl<SongFirebaseService>().addOrRemoveFavoriteSong(songId);
  }
  @override
  Future<Either> getUserFavoriteSong() async{
    return await sl<SongFirebaseService>().getUserFavoriteSong();
  }
  @override
  Future<bool>  isFavoriteSong(String songId) async{
    return await sl<SongFirebaseService>().isFavoriteSong(songId);
  }

}
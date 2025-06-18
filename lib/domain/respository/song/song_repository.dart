import 'package:dartz/dartz.dart';

abstract class SongRespository{
  Future<Either> getNewSongs();
  Future<Either> getNewsPlaylist();
  Future<Either> addOrRemoveFavoriteSong(String songId);
  Future<bool> isFavoriteSong(String songId);
  Future<Either> getUserFavoriteSong();
}
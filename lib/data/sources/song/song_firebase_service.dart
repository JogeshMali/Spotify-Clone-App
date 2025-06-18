import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify/data/models/song/song_model.dart';
import 'package:spotify/domain/entities/song/song_entity.dart';
import 'package:spotify/domain/usecases/song/is_favorite_song_usecase.dart';

import '../../../service_locator.dart';

abstract class SongFirebaseService{
  Future<Either> getNewSongs();
  Future<Either> getNewsPlaylist();
  Future<Either> addOrRemoveFavoriteSong(String songId);
  Future<bool> isFavoriteSong(String songId);
  Future<Either> getUserFavoriteSong();
}
class SongFirebaseServiceImpl extends SongFirebaseService{
  @override
  Future<Either> getNewSongs() async{
   List<SongEntity> songs =[]; 
   try{
     var data = await FirebaseFirestore.instance.collection('songs').limit(3).get();
     for(var element in data.docs){
       var songModel = SongModel.fromJson(element.data());
       bool isFavorite = await sl<isFavoriteSongUsecase>().call(params: element.reference.id);
       songModel.isFavorite = isFavorite;
       songModel.songId = element.reference.id;
       songs.add(songModel.toEntity());
     }
     return Right(songs);
   }catch(e){
      return left('An error occured ,Pls try again');
   }
  }
  @override
  Future<Either> getNewsPlaylist() async{
    List<SongEntity> songs =[];
    try{
      var data = await FirebaseFirestore.instance.collection('songs').get();
      for(var element in data.docs){
        var songModel = SongModel.fromJson(element.data());
        bool isFavorite = await sl<isFavoriteSongUsecase>().call(params: element.reference.id);
        songModel.isFavorite = isFavorite;
        songModel.songId = element.reference.id;

        songs.add(songModel.toEntity());
      }
      return Right(songs);
    }catch(e){
      return left('An error occured ,Pls try again');
    }
  }

  @override
  Future<Either> addOrRemoveFavoriteSong(String songId) async{
    try {
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      late bool isFavorite;
      final String? uid = firebaseAuth.currentUser?.uid;
      //final String userid = firebaseFirestore
      QuerySnapshot favSnapshot = await firebaseFirestore.collection('Users')
          .doc(uid).collection('Favorite')
          .where('songId', isEqualTo: songId)
          .get();

      if (favSnapshot.docs.isNotEmpty) {
        await favSnapshot.docs.first.reference.delete();
        isFavorite = false;
      } else {
        await firebaseFirestore.collection('Users').doc(uid)
            .collection('Favorite')
            .add({
          'songId': songId,
          'addedDate': Timestamp.now()
        });
        isFavorite = true;
      }
      return Right(isFavorite);
    }catch(e){
      return left('An Error Occured');
    }
  }

  @override
  Future<bool> isFavoriteSong(String songId) async{
    try {
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final String? uid = firebaseAuth.currentUser?.uid;
      //final String userid = firebaseFirestore
      QuerySnapshot favSnapshot = await firebaseFirestore.collection('Users')
          .doc(uid).collection('Favorite')
          .where('songId', isEqualTo: songId)
          .get();

      if (favSnapshot.docs.isNotEmpty) {
          return true;
      } else {
        return false;
      }

    }catch(e){
      return false;
    }
  }

  @override
  Future<Either> getUserFavoriteSong() async{
    try {
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      var user = firebaseAuth.currentUser;
      List<SongEntity> favSongs = [];
      String uid = user!.uid;
      QuerySnapshot favSnapshot = await firebaseFirestore.collection('Users')
          .doc(uid).collection('Favorite')
          .get();

     for(var element in favSnapshot.docs){
       String songId =  element['songId'];
       var song = await firebaseFirestore.collection('songs').doc(songId).get();
       SongModel songModel = SongModel.fromJson(song.data()!);
       songModel.isFavorite=true;
       songModel.songId=songId;
       favSongs.add(songModel.toEntity());

     }
      return Right(favSongs);
    }catch(e){
      return Left('An error occured');
    }
  }

}
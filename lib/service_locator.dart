import 'package:get_it/get_it.dart';
import 'package:spotify/data/respository/song/song_repository_impl.dart';
import 'package:spotify/data/sources/auth/auth_firebase_service.dart';
import 'package:spotify/data/sources/song/song_firebase_service.dart';
import 'package:spotify/domain/respository/auth/auth.dart';
import 'package:spotify/domain/respository/song/song_repository.dart';
import 'package:spotify/domain/usecases/auth/get_user_usecase.dart';
import 'package:spotify/domain/usecases/auth/signinUsecase.dart';
import 'package:spotify/domain/usecases/auth/signup_usecase.dart';
import 'package:spotify/domain/usecases/song/get_news_playlist_usecase.dart';
import 'package:spotify/domain/usecases/song/get_news_song_usecase.dart';
import 'package:spotify/domain/usecases/song/user_favorite_song_usecase.dart';

import 'data/respository/auth/auth_repository_impl.dart';
import 'domain/usecases/song/add_or_remove_favorite_song_usecase.dart';
import 'domain/usecases/song/is_favorite_song_usecase.dart';

final sl =  GetIt.instance;
Future<void> initializeDependencies() async{
  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());
  sl.registerSingleton<AuthRepository>(AuthRespositoryImpl());
  sl.registerSingleton<SignUpUseCase>(SignUpUseCase());
  sl.registerSingleton<SigninUseCase>(SigninUseCase());
  sl.registerSingleton<GetUserUseCase>(GetUserUseCase());

  sl.registerSingleton<SongFirebaseService>(SongFirebaseServiceImpl());
  sl.registerSingleton<SongRespository>(SongRepositoryImpl());
  sl.registerSingleton<GetNewsSongUseCase>(GetNewsSongUseCase());
  sl.registerSingleton<GetNewsPlaylistUsecase>(GetNewsPlaylistUsecase());
  sl.registerSingleton<addOrRemoveFavoriteSongUsecase>(addOrRemoveFavoriteSongUsecase());
  sl.registerSingleton<isFavoriteSongUsecase>(isFavoriteSongUsecase());
  sl.registerSingleton<UserFavoriteSongUseCase>(UserFavoriteSongUseCase());

}
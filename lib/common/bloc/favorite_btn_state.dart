abstract class FavoriteBtnState {}
class FavoriteBtnInitial extends FavoriteBtnState{}
class FavoriteBtnUpdated extends FavoriteBtnState{
  final bool isFavorite;

  FavoriteBtnUpdated({required this.isFavorite});
}
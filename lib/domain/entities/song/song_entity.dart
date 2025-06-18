class SongEntity{
  final String title,artist;
  final num duration;
  final bool isFavorite;
  final String songId;

  SongEntity( {
    required this.title,
    required this.artist,
    required this.duration,
    required this.isFavorite,
    required this.songId});
}

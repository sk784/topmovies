class Movie {

 int id;
 double voteAverage;
 String title;
 String posterPath;
 String overview;
 String releaseDate;

  factory Movie(Map jsonMap) =>
      Movie._internalFromJson(jsonMap);

  Movie._internalFromJson(Map jsonMap)
      : id = jsonMap["id"].toInt(),
        voteAverage = jsonMap["vote_average"].toDouble(),
        title = jsonMap["title"],
        posterPath = jsonMap["poster_path"] ?? "",
        overview = jsonMap["overview"],
        releaseDate = jsonMap["release_date"];


 String getPosterUrl() => getMediumPictureUrl(posterPath);

 int getReleaseYear() {
   return releaseDate == null || releaseDate == ""
       ? 0
       : DateTime.parse(releaseDate).year;
 }

  Map <String, dynamic> toJson() => {
    'id': id,
    'vote_average': voteAverage,
    'title': title,
    'poster_path': posterPath,
    'overview': overview,
    'release_date': releaseDate,
  };

  final String _imageUrl = "https://image.tmdb.org/t/p/w300/";

  String getMediumPictureUrl(String path) => _imageUrl + path;

}


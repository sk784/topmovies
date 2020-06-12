import 'package:cinema_db_bloc/data/api_movies.dart';
import 'package:cinema_db_bloc/data/db.dart';

class MovieRepository {
  final _api = ApiMovies.instance;

  Future getMoviesFromApi() async {
    List<Movie> result = await _api.fetchMovies();
    for (int i = 0; i < result.length; i++) {
      DatabaseProvider.db.addMovie(result[i]);
      return result;
    }
  }

  Future getMoviesFromDB() async => await DatabaseProvider.db.getMovies();
}







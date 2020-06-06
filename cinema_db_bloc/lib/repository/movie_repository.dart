import 'package:cinema_db_bloc/data/api_movies.dart';
import 'package:cinema_db_bloc/data/db.dart';

class MovieRepository {
  final _api = ApiMovies.instance;

  Future getMoviesFromApi() async {
    await _api.fetchMovies().then ((data) {
     for (int i = 0; i < data.length; i++) {
        DatabaseProvider.db.addMovie(data[i]);
      }
    });
    return _api.fetchMovies();
  }

  Future getMoviesFromDB() async => await DatabaseProvider.db.getMovies();
}







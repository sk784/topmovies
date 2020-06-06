import 'dart:async';
import 'dart:io';
import 'package:cinema_db_bloc/model/movie.dart';
import 'package:cinema_db_bloc/repository/movie_repository.dart';
import 'bloc_provider.dart';

class MoviesBloc implements BlocBase {

  MoviesBloc() {
    getMovies();
  }

  final _repository = MovieRepository();

  final _moviesController = StreamController<List<Movie>>();


  StreamSink<List<Movie>> get _inMovies => _moviesController.sink;

  Stream<List<Movie>> get movies => _moviesController.stream;


  void getMovies() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        List<Movie> movies = await _repository.getMoviesFromApi();
        _inMovies.add(movies);
      }
    } on SocketException catch (_) {
      print('not connected');
      List<Movie> movies = await _repository.getMoviesFromDB();
      _inMovies.add(movies);
    }
  }

  @override
  void dispose() {
    _moviesController.close();
  }
}
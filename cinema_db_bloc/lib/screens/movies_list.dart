import 'package:cinema_db_bloc/bloc/bloc_provider.dart';
import 'package:cinema_db_bloc/bloc/movies_bloc.dart';
import 'package:cinema_db_bloc/model/movie.dart';
import 'package:flutter/material.dart';
import 'movie_item.dart';

class MoviesList extends StatefulWidget {
  MoviesList({
    Key key,
    this.title
  }) : super(key: key);

  final String title;

  @override
  _MoviesListState createState() => _MoviesListState();
}

class _MoviesListState extends State<MoviesList> {

  MoviesBloc _moviesBloc;

  @override
  void initState() {
    super.initState();
    _moviesBloc = BlocProvider.of<MoviesBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: StreamBuilder<List<Movie>>(
                stream: _moviesBloc.movies,
                builder: (BuildContext context,
                    AsyncSnapshot<List<Movie>> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.length == 0) {
                      return Center(
                          child: Text('No movies')
                      );
                    }
                    List<Movie> movies = snapshot.data;
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return MovieItem(movies[index], index + 1);
                      },
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:cinema_db_bloc/main.dart';
import 'package:cinema_db_bloc/model/movie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:network_to_file_image/network_to_file_image.dart';

import 'movie_detail.dart';

class MovieItem extends StatelessWidget {

  MovieItem(this.movie, this.number);
  final Movie movie;
  final int number;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) =>
              MovieDetail(movie,number)
          ),
        ),
        child: Column(
          children: <Widget>[
         Image(
             fit: BoxFit.cover,
             width: double.infinity,
             height: 200.0,
          image: NetworkToFileImage(
          url:  movie.getPosterUrl(),
          file: fileFromDocsDir("movie$number.png"),
          )
         ),
            _getTitleSection(context),
          ]
          ),
        ),
      );
  }

  Widget _getTitleSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: Text(
                movie.title,
                style: Theme
                    .of(context)
                    .textTheme
                    .subhead
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            width: 12.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    movie.voteAverage.toString(),
                    style: Theme.of(context).textTheme.body1,
                  ),
                  Container(
                    width: 4.0,
                  ),
                  Icon(
                    Icons.star,
                    size: 16.0,
                  )
                ],
              ),
              Container(
                height: 4.0,
              ),
              Row(
                children: <Widget>[
                  Text(
                    movie.getReleaseYear().toString(),
                    style: Theme.of(context).textTheme.body1,
                  ),
                  Container(
                    width: 4.0,
                  ),
                  Icon(
                    Icons.date_range,
                    size: 16.0,
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
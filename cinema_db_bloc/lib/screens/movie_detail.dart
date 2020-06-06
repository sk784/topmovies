import 'package:cinema_db_bloc/main.dart';
import 'package:cinema_db_bloc/model/movie.dart';
import 'package:flutter/material.dart';
import 'package:network_to_file_image/network_to_file_image.dart';

class MovieDetail extends StatelessWidget {

  final Movie movie;
  final int number;

  MovieDetail(this.movie,this.number);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            _buildAppBar(),
            _buildContentSection(),
          ],
        ));
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 240.0,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image(
                fit: BoxFit.cover,
                width: double.infinity,
                image: NetworkToFileImage(
                  url:  movie.getPosterUrl(),
                  file: fileFromDocsDir("movie$number.png"),
                )
            ),
            _buildMetaSection()
          ],
        ),
      ),
    );
  }

  Widget _buildMetaSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                movie.getReleaseYear().toString(),
                  style: TextStyle(color: Colors.white)
              ),
              Container(
                width: 8.0,
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.star,
                    size: 16.0,
                    color: Colors.white,
                  ),
                  Container(
                    width: 4.0,
                  ),
                  Text(movie.voteAverage.toString(),
                      style: TextStyle(color: Colors.white)
                  ),
                ],

              )
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(movie.title,
                style: TextStyle(color: Colors.white, fontSize: 20.0)),
          ),
        ],
      ),
    );
  }

  Widget _buildContentSection() {
    return SliverList(
      delegate: SliverChildListDelegate(<Widget>[
        Container(
          decoration: BoxDecoration(color: Colors.blue[800]),
          child: Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "ОПИСАНИЕ",
                  style: const TextStyle(color: Colors.white, fontSize: 16.0),
                ),
                Container(
                  height: 8.0,
                ),
                Text(movie.overview,
                    style:
                    const TextStyle(color: Colors.white)),
                Container(
                  height: 8.0,
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
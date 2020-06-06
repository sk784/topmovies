import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:cinema_db_bloc/screens/movies_list.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'bloc/bloc_provider.dart';
import 'bloc/movies_bloc.dart';

Directory _appDocsDir;

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  _appDocsDir = await getApplicationDocumentsDirectory();
  runApp(MyApp());
}

File fileFromDocsDir(String filename) {
  String pathName = p.join(_appDocsDir.path, filename);
  return File(pathName);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        bloc: MoviesBloc(),
        child: MoviesList(title: 'Movies'),
      ),
    );
  }
}


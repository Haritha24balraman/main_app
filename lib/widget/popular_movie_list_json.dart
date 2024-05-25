import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:main_app/model/popular_movie_response.dart';

class PopularMovieListJson extends StatefulWidget {
  const PopularMovieListJson({super.key});

  @override
  State<PopularMovieListJson> createState() => _PopularMovieListJsonState();
}

class _PopularMovieListJsonState extends State<PopularMovieListJson> {
  late List<PopularMovie> _popularMovieList = [];

  @override
  void initState() {
    super.initState();
    getPopularMovies();
  }

  void getPopularMovies() async {
    _popularMovieList = await fetchDataFromJson();
    setState(() {});
  }

  Future<List<PopularMovie>> fetchDataFromJson() async {
    final jsonString = await rootBundle.loadString('assets/popular_movies.json');
    final popularMoviesResponse = jsonDecode(jsonString);
    final movieList = (popularMoviesResponse['items'] as List<dynamic>)
        .map((movieJson) => PopularMovie.fromJson(movieJson))
        .toList();
    return movieList;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _popularMovieList.length,
      itemBuilder: (context, index) {
        final movie = _popularMovieList[index];
        return ListTile(
          title: Text(movie.title ?? "No title"),
          subtitle: Text(movie.year ?? "N/A"),
        );
      },
    );
  }
}

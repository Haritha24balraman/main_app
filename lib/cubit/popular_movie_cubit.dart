import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class UiState {}
class Initial extends UiState {}
class Loading extends UiState {}
class Success extends UiState {
  final List<PopularMovie> movies;
  Success(this.movies);

  get movieList => null;
}
class Error extends UiState {}


class PopularMovie {
  final String title;
  final String imageUrl;
  final double rating;

  PopularMovie({required this.title, required this.imageUrl, required this.rating, String? year});

  factory PopularMovie.fromJson(Map<String, dynamic> json) {
    return PopularMovie(
      title: json['title'],
      imageUrl: json['imageUrl'],
      rating: json['rating'].toDouble(),
    );
  }

  get year => null;
}


class PopularMovieCubit extends Cubit<UiState> {
  PopularMovieCubit() : super(Initial());

  void getPopularMovies() async {
    emit(Loading());
    try {
      final popularMovieList = await fetchDataFromJson();
      emit(Success(popularMovieList));
    } catch (e) {
      emit(Error());
    }
  }

  Future<List<PopularMovie>> fetchDataFromJson() async {
    final jsonString = await rootBundle.loadString('assets/popular_movies.json');
    final popularMoviesResponse = jsonDecode(jsonString);
    final movieList = (popularMoviesResponse['items'] as List<dynamic>)
        .map((movieJson) => PopularMovie.fromJson(movieJson))
        .toList();
    return movieList;
  }
}

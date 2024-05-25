import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main_app/cubit/top_rated_movie_list_ui_state.dart';
import 'package:http/http.dart' as http;
import 'package:main_app/model/top_rated_movie_response.dart';

class TopRatedMovieCubit extends Cubit<TopRatedMovieListUiState> {
  TopRatedMovieCubit() : super(Initial());

  void fetchTopRatedMoviesFromUrl() async {
    emit(Loading());
    try {
      final topRatedMovies = await _fetchDataFromUrl();
      emit(Success(topRatedMovies));
    } catch (e) {
      emit(Error());
    }
  }

  Future<List<TopRatedMovie>> _fetchDataFromUrl() async {
    const topRatedMoviesUrl = "https://movie-api-rish.onrender.com/top-rated";
    final topRatedMoviesUri = Uri.parse(topRatedMoviesUrl);

    final response = await http.get(topRatedMoviesUri);
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      final topRatedMoviesList = (responseJson['items'] as List<dynamic>)
          .map((topRatedMovie) => TopRatedMovie.fromJson(topRatedMovie))
          .toList();
      return topRatedMoviesList;
    } else {
      throw Exception('Failed to load top-rated movies');
    }
  }
}

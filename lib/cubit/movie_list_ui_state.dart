import '../model/popular_movie_response.dart';

abstract class UiState {}

class Initial extends UiState {}

class Loading extends UiState {}

class Success extends UiState {
  final List<PopularMovie> movieList;

  Success(this.movieList);
}

class Error extends UiState {}

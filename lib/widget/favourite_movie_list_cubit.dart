import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:main_app/cubit/favourite_movie_cubit.dart';
import 'package:main_app/model/popular_movie_hive.dart';

import '../cubit/popular_movie_cubit.dart';

class FavouriteMovieListCubit extends StatefulWidget {
  const FavouriteMovieListCubit({Key? key}) : super(key: key);

  @override
  State<FavouriteMovieListCubit> createState() => _FavouriteMovieListCubitState();
}

class _FavouriteMovieListCubitState extends State<FavouriteMovieListCubit> {
  late Box<PopularMovieHive> _movieBox;
  List<PopularMovie> _favoriteMovieList = [];

  @override
  void initState() {
    super.initState();
    _movieBox = Hive.box<PopularMovieHive>('popular-movies');
    context.read<FavouriteMovieCubit>().getFavouriteMovies();
    fetchFavouriteMovies();
  }

  void fetchFavouriteMovies() {
    _favoriteMovieList = _movieBox.values
        .map((movieHive) => PopularMovie(
      title: movieHive.title,
      year: movieHive.year,
      imageUrl: '',
      rating: null,
    ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouriteMovieCubit, List<PopularMovieHive>>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: _favoriteMovieList.length,
          itemBuilder: (context, index) {
            final movie = _favoriteMovieList[index];
            return ListTile(
              title: Text(movie.title ?? "No title"),
              subtitle: Text(movie.year ?? "1999"),
            );
          },
        );
      },
    );
  }
}

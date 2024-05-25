import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:main_app/cubit/popular_movie_cubit.dart';
import 'package:main_app/model/popular_movie_hive.dart';

class PopularMovieListCubit extends StatefulWidget {
  const PopularMovieListCubit({Key? key}) : super(key: key);

  @override
  State<PopularMovieListCubit> createState() => _PopularMovieListCubitState();
}

class _PopularMovieListCubitState extends State<PopularMovieListCubit> {
  late Box<PopularMovieHive> _movieBox;
  late List<PopularMovieHive> _favoriteMovieHiveList;

  @override
  void initState() {
    super.initState();
    _initHive();
  }

  Future<void> _initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(PopularMovieAdapter());
    _movieBox = await Hive.openBox<PopularMovieHive>('popular-movies');
    fetchFavouriteMovies();
    context.read<PopularMovieCubit>().getPopularMovies();
  }

  void _saveMovie(PopularMovieHive movie) {
    _movieBox.add(movie);
    fetchFavouriteMovies();
  }

  void _deleteMovie(PopularMovieHive movie) {
    movie.delete();
    fetchFavouriteMovies();
  }

  void fetchFavouriteMovies() {
    _favoriteMovieHiveList = _movieBox.values.toList();
    setState(() {}); // Trigger UI update
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularMovieCubit, UiState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case Initial:
          case Loading:
            return const Center(child: CircularProgressIndicator());

          case Success:
            final movieList = (state as Success).movieList;
            return ListView.builder(
              itemCount: movieList.length,
              itemBuilder: (context, index) {
                final movie = movieList[index];
                final isFavourite = _favoriteMovieHiveList.any((favMovie) => favMovie.title == movie.title);
                return ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(movie.title ?? "No title"),
                      IconButton(
                        icon: Icon(
                          isFavourite ? Icons.favorite : Icons.favorite_border,
                          size: 20,
                        ),
                        onPressed: () {
                          final movieHive = PopularMovieHive(title: movie.title, year: movie.year);
                          isFavourite ? _deleteMovie(movieHive) : _saveMovie(movieHive);
                        },
                      ),
                    ],
                  ),
                  subtitle: Text(movie.year ?? "N/A"),
                  tileColor: isFavourite ? Colors.greenAccent : Colors.white,
                );
              },
            );

          case Error:
            return const Center(child: Text('Something went wrong!'));

          default:
            return Container();
        }
      },
    );
  }
}

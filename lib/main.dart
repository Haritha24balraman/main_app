import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:main_app/cubit/favourite_movie_cubit.dart';
import 'package:main_app/cubit/popular_movie_cubit.dart';
import 'package:main_app/cubit/top_rated_movie_cubit.dart';
import 'package:main_app/model/popular_movie_hive.dart';
import 'package:main_app/screens/movie_grid_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(PopularMovieAdapter());
  await Hive.openBox<PopularMovieHive>('popular-movies');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PopularMovieCubit()),
        BlocProvider(create: (context) => FavouriteMovieCubit()),
        BlocProvider(create: (context) => TopRatedMovieCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.yellow,
        ),
        home: const MovieGridScreen(),
      ),
    );
  }
}

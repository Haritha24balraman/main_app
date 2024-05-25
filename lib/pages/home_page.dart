import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:main_app/pages/popular_movies_page.dart';
import 'package:main_app/pages/top_rated_movies_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.stacked_line_chart),),
              Tab(icon: Icon(Icons.timelapse),),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            PopularMoviesPage(),
            TopRatedMoviesPage(),
          ],
        ),
      ),
    );
  }
}

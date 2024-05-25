import 'package:flutter/material.dart';

class MovieGridScreen extends StatelessWidget {
  const MovieGridScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Grid'),
      ),
      body: Center(
        child: Text('This is the movie grid screen.'),
      ),
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors, avoid_unnecessary_containers
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

//Model
import '../models/movie.dart';

class MovieTile extends StatelessWidget {
  final GetIt getIt = GetIt.instance;
  final double height;
  final double width;
  final Movie movie;
  MovieTile({
    super.key,
    required this.height,
    required this.width,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [movieposterwidget(movie.posterURL())],
      ),
    );
  }

  Widget movieposterwidget(String imageUrl) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage(imageUrl)),
      ),
    );
  }
}

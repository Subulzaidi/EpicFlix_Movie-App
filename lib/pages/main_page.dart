// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors

import 'dart:ui';
//packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//model
import '../models/movie.dart';
import '../models/search_category.dart';
//widget
import '../widgets/movie_tile.dart';

class MainPage extends ConsumerWidget {
  late double deviceHeight;
  late double deviceWidth;
  late final TextEditingController searchTextFileController =
      TextEditingController();

  MainPage({super.key});

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: SizedBox(
          height: deviceHeight,
          width: deviceWidth,
          child: Stack(
            alignment: Alignment.center,
            children: [backgroundWidget(), foregroundWidget()],
          ),
        ));
  }

  Widget backgroundWidget() {
    return Container(
      height: deviceHeight,
      width: deviceWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
          image: NetworkImage(
            'https://upload.wikimedia.org/wikipedia/en/b/be/Godzilla_x_kong_the_new_empire_poster.jpg',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.2)),
        ),
      ),
    );
  }

  Widget foregroundWidget() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, deviceHeight * 0.02, 0, 0),
      // width: deviceWidth * 0.9,
      width: deviceWidth * 0.88,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          topbarWidget(),
          Container(
            height: deviceHeight * 0.83,
            padding: EdgeInsets.symmetric(vertical: deviceHeight * 0.01),
            child: movieListViewWidget(),
          )
        ],
      ),
    );
  }

  Widget topbarWidget() {
    return Container(
      height: deviceHeight * 0.08,
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [searchFieldWidget(), categorySelection()],
      ),
    );
  }

  Widget searchFieldWidget() {
    const borDer = InputBorder.none;
    return SizedBox(
      width: deviceWidth * 0.60,
      height: deviceHeight * 0.05,
      child: TextField(
        controller: searchTextFileController,
        onSubmitted: (value) {},
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          focusedBorder: borDer,
          border: borDer,
          hintStyle: TextStyle(color: Colors.white24),
          filled: false,
          fillColor: Colors.white24,
          prefixIcon: Icon(Icons.search, color: Colors.white24),
          hintText: "Search....",
        ),
      ),
    );
  }

  Widget categorySelection() {
    return DropdownButton(
      dropdownColor: Colors.black38,
      value: SearchCategory.popular,
      icon: Icon(Icons.menu, color: Colors.white24),
      underline: Container(
        height: 1,
        color: Colors.white24,
      ),
      onChanged: (value) {},
      items: [
        DropdownMenuItem(
          value: SearchCategory.popular,
          child: Text(
            SearchCategory.popular,
            style: TextStyle(color: Colors.white),
          ),
        ),
        DropdownMenuItem(
          value: SearchCategory.upcoming,
          child: Text(
            SearchCategory.upcoming,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget movieListViewWidget() {
    final List<Movie> movies = [];

    for (var i = 0; i < 20; i++) {
      movies.add(Movie(
        name: 'The Godfather',
        language: 'English',
        isAdult: true,
        description:
            'The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.',
        rating: 9.2,
        posterPath: '/3bhkrj58Vtu7enYsRolD1fZdja1.jpg',
        backdropPath: '/rSPw7tgCH9c6NqICZef4kZjFOQ5.jpg',
        releasingDate: '1972-03-24',
      ));
    }

    if (movies.isNotEmpty) {
      return ListView.builder(
        itemCount: movies.length,
        itemBuilder: (BuildContext context, int _count) {
          return Padding(
            padding: EdgeInsets.symmetric(
                vertical: deviceHeight * 0.01, horizontal: 0),
            child: GestureDetector(
              onTap: () {},
              child: MovieTile(
                  movie: movies[_count],
                  height: deviceHeight * 0.20,
                  width: deviceWidth * 0.85),
            ),
          );
        },
      );
    } else {
      return Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
        ),
      );
    }
  }
}

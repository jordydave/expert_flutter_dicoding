import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/genre.dart';
import '../../../../styles/colors.dart';
import '../../../bloc/movie/movie_genre_list_bloc.dart';

class GenreListMovie extends StatefulWidget {
  final List<Genre> genres;
  const GenreListMovie(
    this.genres, {
    Key? key,
  }) : super(key: key);

  @override
  State<GenreListMovie> createState() => _GenreListMovieState();
}

class _GenreListMovieState extends State<GenreListMovie> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<MovieGenreListBloc>().add(GetMovieGenreList(
            widget.genres.first.id,
          ));
    });
  }

  String selectedGenre = 'Action';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5, right: 5, bottom: 5),
      height: 60,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: widget.genres.length,
        itemBuilder: (BuildContext context, int index) {
          final genre = widget.genres[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedGenre = genre.name;
              });
              context.read<MovieGenreListBloc>().add(
                    GetMovieGenreList(
                      genre.id,
                    ),
                  );
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: selectedGenre == genre.name ? kPrussianRed : kDavysGrey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                widget.genres[index].name,
              ),
            ),
          );
        },
      ),
    );
  }
}

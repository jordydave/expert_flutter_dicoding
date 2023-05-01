import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/domain/entities/movie/video.dart';
import 'package:flutter/material.dart';

class DetailMovieVideoCard extends StatelessWidget {
  const DetailMovieVideoCard({
    Key? key,
    required this.videos,
  }) : super(key: key);

  final Videos videos;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://img.youtube.com/vi/${videos.key}/0.jpg',
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        const Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          top: 0,
          child: Icon(Icons.play_arrow, color: Colors.white, size: 50),
        ),
      ],
    );
  }
}

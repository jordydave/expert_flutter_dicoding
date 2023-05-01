import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../domain/entities/tv/tv.dart';
import '../../../../utils/constant.dart';
import '../../../styles/colors.dart';
import '../../pages/tv/tv_detail_page.dart';

class TVList extends StatelessWidget {
  final List<TV> tv;

  const TVList(this.tv, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final television = tv[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TVDetailpage.routeName,
                  arguments: television.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageUrl${television.posterPath}',
                  placeholder: (context, url) => Shimmer(
                    gradient: const LinearGradient(
                      colors: [
                        kDavysGrey,
                        kGrey,
                      ],
                      begin: Alignment(-1.0, -0.5),
                      end: Alignment(1.0, 0.5),
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: kPrussianRed,
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                      ),
                      // width: 80,
                      height: 200,
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tv.length,
      ),
    );
  }
}

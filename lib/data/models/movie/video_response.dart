import 'package:ditonton/data/models/movie/video_model.dart';
import 'package:equatable/equatable.dart';

class VideoResponse extends Equatable {
  final List<VideosModel> videoList;

  const VideoResponse({required this.videoList});

  factory VideoResponse.fromJson(Map<String, dynamic> json) => VideoResponse(
        videoList: List<VideosModel>.from(
          (json["results"] as List).map(
            (x) => VideosModel.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(
          videoList.map(
            (x) => x.toJson(),
          ),
        ),
      };

  @override
  List<Object> get props => [videoList];
}

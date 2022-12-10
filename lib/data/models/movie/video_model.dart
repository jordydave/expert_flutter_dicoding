import 'package:ditonton/domain/entities/movie/video.dart';
import 'package:equatable/equatable.dart';

class VideosModel extends Equatable {
  final String? name;
  final String? key;
  final String? site;
  final String? type;

  const VideosModel({
    this.name,
    this.key,
    this.site,
    this.type,
  });

  factory VideosModel.fromJson(Map<String, dynamic> json) => VideosModel(
        name: json["name"],
        key: json["key"],
        site: json["site"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "key": key,
        "site": site,
        "type": type,
      };

  Videos toEntity() {
    return Videos(
      name: name,
      key: key,
      site: site,
      type: type,
    );
  }

  @override
  List<Object?> get props => [
        name,
        key,
        site,
        type,
      ];
}

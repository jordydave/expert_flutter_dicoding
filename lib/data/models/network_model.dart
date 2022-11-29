import 'package:equatable/equatable.dart';

import '../../domain/entities/network.dart';

class NetworkModel extends Equatable {
  const NetworkModel({
    required this.id,
    required this.name,
    required this.logoPath,
    required this.originCountry,
  });

  final int id;
  final String name;
  final String? logoPath;
  final String originCountry;

  factory NetworkModel.fromJson(Map<String, dynamic> json) => NetworkModel(
        id: json["id"],
        name: json["name"],
        logoPath: json["logo_path"] ?? "",
        originCountry: json["origin_country"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "logo_path": logoPath,
        "origin_country": originCountry,
      };

  Network toEntity() {
    return Network(
      id: id,
      name: name,
      logoPath: logoPath!,
      originCountry: originCountry,
    );
  }

  @override
  List<Object?> get props => [id, name, logoPath, originCountry];
}

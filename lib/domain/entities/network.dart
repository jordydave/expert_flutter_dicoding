import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Network extends Equatable {
  Network({
    required this.id,
    required this.name,
    required this.logoPath,
    required this.originCountry,
  });
  int id;
  String name;
  String logoPath;
  String originCountry;

  @override
  List<Object> get props => [id, name, logoPath, originCountry];
}

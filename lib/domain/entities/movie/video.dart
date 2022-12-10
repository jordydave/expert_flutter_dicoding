import 'package:equatable/equatable.dart';

class Videos extends Equatable {
  final String? name;
  final String? key;
  final String? site;
  final String? type;

  const Videos({
    this.name,
    this.key,
    this.site,
    this.type,
  });

  @override
  List<Object?> get props => [
        name,
        key,
        site,
        type,
      ];
}

import 'package:ditonton/domain/entities/season.dart';
import 'package:equatable/equatable.dart';

class SeasonModel extends Equatable {
  SeasonModel({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory SeasonModel.fromJson(Map<String, dynamic> json) => SeasonModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  Season toEntity() {
    return Season(
      id: this.id,
      name: this.name,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
      ];
}

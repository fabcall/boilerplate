import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category extends Equatable {
  int id;
  String name;

  Category({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}

import 'package:hive/hive.dart';

part "movies.g.dart";

@HiveType(typeId: 0)
class Movies extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String description;

  Movies(this.name, this.description);
  String toString() {
    return 'Movies{name: $name, description: $description}';
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'name': name,
  //     'description': description,
  //   };
  // }

  // static Movies fromJson(Map<String, dynamic> json) {
  //   return Movies(
  //     json['name'],
  //     json['description'],
  //   );
  // }
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Movies &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          description == other.description;

  @override
  int get hashCode => description.hashCode ^ description.hashCode;
}

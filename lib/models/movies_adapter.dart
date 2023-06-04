import 'package:hive/hive.dart';
import 'package:travelui/models/movies.dart';

class MoviesAdapter extends TypeAdapter<Movies> {
  @override
  final int typeId = 0;

  @override
  Movies read(BinaryReader reader) {
    return Movies(reader.readString(), reader.readString());
  }

  @override
  void write(BinaryWriter writer, Movies obj) {
    writer.writeString(obj.name);
    writer.writeString(obj.description);
  }
}

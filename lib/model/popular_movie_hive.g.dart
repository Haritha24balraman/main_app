
part of 'popular_movie_hive.dart';



class PopularMovieAdapter extends TypeAdapter<PopularMovieHive> {
  @override
  final int typeId = 0;

  @override
  PopularMovieHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PopularMovieHive(
      title: fields[0] as String?,
      year: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PopularMovieHive obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.year);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is PopularMovieAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}
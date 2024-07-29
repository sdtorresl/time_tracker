abstract class Model<T> {
  T toEntity();
  Map<String, dynamic> toMap();

  static Model<T> fromEntity<T>(T entity, Model<T> Function(T) factory) {
    return factory(entity);
  }

  static Model<T> fromMap<T>(Map<String, dynamic> map,
      Model<T> Function(Map<String, dynamic>) factory) {
    return factory(map);
  }
}

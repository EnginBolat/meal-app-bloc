const String tableSavedNews = 'savedmeals';

class SavedMealFields {
  static final List<String> values = [id];

  static const String id = '_id';
}

class SavedMealModel {
  final int? id;

  const SavedMealModel({required this.id});

  SavedMealModel copy({int? id}) => SavedMealModel(id: id ?? this.id);

  static SavedMealModel fromJson(Map<String, Object?> json) => SavedMealModel(
        id: json[SavedMealFields.id] as int?,
      );

  Map<String, Object?> toJson() => {SavedMealFields.id: id};
}

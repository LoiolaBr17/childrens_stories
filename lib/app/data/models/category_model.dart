import 'dart:convert';

class CategoryModel {
  final int id;
  final String title;

  CategoryModel({
    required this.id,
    required this.title,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] as int,
      title: map['title'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  CategoryModel copyWith({
    int? id,
    String? title,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      title: title ?? this.title,
    );
  }
}

import 'dart:convert';

import 'package:childrens_stories/app/data/models/category_model.dart';

class StoryModel {
  final int id;
  final String title;
  final String imagebanner;
  final CategoryModel category;
  final List<String> content;

  StoryModel({
    required this.id,
    required this.title,
    required this.imagebanner,
    required this.category,
    required this.content,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'imagebanner': imagebanner,
      'category': category.toMap(),
      'content': content,
    };
  }

  // Aqui, você não precisa que o JSON inclua a categoria inteira,
  // apenas o category_id, que será mapeado manualmente depois.
  factory StoryModel.fromMap(Map<String, dynamic> map, CategoryModel category) {
    return StoryModel(
      id: map['id'] as int,
      title: map['title'] as String,
      imagebanner: map['imagebanner'] as String,
      category: category, // Passa o objeto CategoryModel
      content: List<String>.from(map['content']),
    );
  }

  String toJson() => json.encode(toMap());

  factory StoryModel.fromJson(String source, CategoryModel category) =>
      StoryModel.fromMap(json.decode(source) as Map<String, dynamic>, category);
}

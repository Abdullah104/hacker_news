import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../../serializers/serializers.dart';

part 'article.g.dart';

abstract class Article implements Built<Article, ArticleBuilder> {
  Article._();

  static Serializer<Article> get serializer => _$articleSerializer;

  int get id;
  bool? get deleted;
  String get type;
  String get by;
  int get time;
  String? get text;
  bool? get dead;
  int? get parent;
  int? get poll;
  BuiltList<int> get kids;
  String? get url;
  int? get score;
  String get title;
  BuiltList<int> get parts;
  int? get descendants;

  factory Article([Function(ArticleBuilder b) updates]) = _$Article;
}

List<int> parseTopStories(String json) {
  final parsed = jsonDecode(json);
  final idsList = List<int>.from(parsed);

  return idsList;
}

Article parseArticle(String json) {
  final parsed = jsonDecode(json);

  final article =
      standardSerializers.deserializeWith(Article.serializer, parsed)!;

  return article;
}

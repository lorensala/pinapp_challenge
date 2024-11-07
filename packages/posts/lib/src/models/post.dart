// ignore_for_file: public_member_api_docs

import 'dart:convert';

import 'package:equatable/equatable.dart';

/// {@template post}
/// Un post.
///
/// Se podría haber utilizado Freezed y JsonSerializable para generar la clase
/// de datos, pero al ser pocos modelos, opté por hacerlo con equatable y con
/// la extensión Dart Data Cass Generator.
/// {@endtemplate}
class Post extends Equatable {
  /// {@macro post}
  const Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  /// {@macro post}
  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      userId: map['userId'] as int,
      id: map['id'] as int,
      title: map['title'] as String,
      body: map['body'] as String,
    );
  }

  /// {@macro post}
  factory Post.fromJson(String source) =>
      Post.fromMap(json.decode(source) as Map<String, dynamic>);

  final int userId;
  final int id;
  final String title;
  final String body;

  @override
  List<Object> get props => [userId, id, title, body];

  /// {@macro post}
  Post copyWith({
    int? userId,
    int? id,
    String? title,
    String? body,
  }) {
    return Post(
      userId: userId ?? this.userId,
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }

  /// {@macro post}
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'id': id,
      'title': title,
      'body': body,
    };
  }

  /// {@macro post}
  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;
}

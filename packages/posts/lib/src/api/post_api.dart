// ignore_for_file: public_member_api_docs

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:posts/src/posts.dart';

/// {@template post_api}
/// API de posts.
/// {@endtemplate}
abstract interface class PostApi {
  Future<List<Post>> getPosts();
  Future<List<Comment>> getPostComments(int postId);
}

/// {@template post_api}
/// API de posts.
///
/// Utiliza el servicio de JSONPlaceholder para obtener los posts y comentarios.
/// Utiliza [Dio] para realizar las peticiones HTTP.
/// {@endtemplate}
class JsonPlaceholderPostApi implements PostApi {
  /// {@macro post_api}
  const JsonPlaceholderPostApi(this._dio);

  final Dio _dio;

  static const platform =
      MethodChannel('com.example.verygoodcore.pinapp_challenge/api');

  @override
  Future<List<Post>> getPosts() async {
    final response = await _dio
        .get<List<dynamic>>('https://jsonplaceholder.typicode.com/posts');

    return response.data!
        .map((dynamic json) => Post.fromMap(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<Comment>> getPostComments(int postId) async {
    final result =
        await platform.invokeMethod('getPostComments', {'postId': postId});

    final comments = result as List<dynamic>;

    return comments
        .map(
          (dynamic json) =>
              Comment.fromMap(Map<String, dynamic>.from(json as Map)),
        )
        .toList();
  }
}

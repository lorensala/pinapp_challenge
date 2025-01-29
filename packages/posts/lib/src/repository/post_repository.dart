// ignore_for_file: public_member_api_docs

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:fpdart/fpdart.dart';
import 'package:posts/src/posts.dart';

/// Errores que pueden surgir al comunicarse con la API de posts.
enum Failure {
  notFound,
  internalServerError,
  tooManyRequests,
  badRequest,
  platformException,
  unknown;

  factory Failure.fromDioException(DioException e) {
    switch (e.response?.statusCode) {
      case 404:
        return Failure.notFound;
      case 500:
        return Failure.internalServerError;
      case 429:
        return Failure.tooManyRequests;
      case 400:
        return Failure.badRequest;
      default:
        return Failure.unknown;
    }
  }

  /// Mensaje asociado al error.
  String get message => switch (this) {
        Failure.notFound => 'No se encontró el recurso solicitado.',
        Failure.internalServerError => 'Error interno del servidor.',
        Failure.tooManyRequests => 'Demasiadas solicitudes.',
        Failure.badRequest => 'Solicitud incorrecta.',
        Failure.unknown => 'Error desconocido.',
        Failure.platformException => 'Este dispositivo no es compatible.',
      };
}

/// {@template post_repository}
/// Repositorio de posts.
///
/// Se encarga de manejar la comunicación con la API de posts, y de manejar los
/// errores que puedan surgir.
/// {@endtemplate}
abstract interface class PostRepository {
  Future<Either<Failure, List<Post>>> getPosts();
  Future<Either<Failure, List<Comment>>> getPostComments(int postId);
  List<Post> showMore();
  bool get hasMore;
  @visibleForTesting
  int get limit;

  @visibleForTesting
  int get page;

  @visibleForTesting
  List<Post> get posts;
}

/// {@template post_repository_impl}
/// Repositorio de posts.
///
/// Se encarga de manejar la comunicación con la API de posts, y de manejar los
/// errores que puedan surgir.
///
/// Utiliza el servicio de JSONPlaceholder para obtener los posts y los
/// comentarios.
/// {@endtemplate}
class PostRepositoryImpl implements PostRepository {
  /// {@macro post_repository_impl}
  PostRepositoryImpl(this._api);

  final PostApi _api;

  List<Post> _posts = [];
  int _page = 1;
  final int _limit = 20;
  bool _hasMore = true;

  @override
  bool get hasMore => _hasMore;

  @override
  @visibleForTesting
  int get limit => _limit;

  @override
  @visibleForTesting
  int get page => _page;

  @override
  @visibleForTesting
  List<Post> get posts => _posts;

  @override
  Future<Either<Failure, List<Post>>> getPosts() async {
    try {
      final posts = await _api.getPosts();
      _posts = posts;
      return right(posts.take(_limit).toList());
    } on DioException catch (e) {
      return left(Failure.fromDioException(e));
    } catch (_) {
      return left(Failure.unknown);
    }
  }

  @override
  List<Post> showMore() {
    if (_page * _limit >= _posts.length) {
      _hasMore = false;
      return _posts;
    }
    _page++;
    return _posts.take(_page * _limit).toList();
  }

  @override
  Future<Either<Failure, List<Comment>>> getPostComments(int postId) async {
    try {
      final comment = await _api.getPostComments(postId);
      return right(comment);
    } on DioException catch (e) {
      return left(Failure.fromDioException(e));
    } on PlatformException catch (_) {
      return left(Failure.platformException);
    } catch (_) {
      return left(Failure.unknown);
    }
  }
}

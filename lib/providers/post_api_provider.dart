// coverage:ignore-file

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:posts/posts.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'post_api_provider.g.dart';

@Riverpod(keepAlive: true)
PostApi postApi(Ref ref) {
  final dio = Dio();
  return JsonPlaceholderPostApi(dio);
}

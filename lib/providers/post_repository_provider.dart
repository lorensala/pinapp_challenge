// coverage:ignore-file

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinapp_challenge/providers/providers.dart';
import 'package:posts/posts.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'post_repository_provider.g.dart';

@Riverpod(keepAlive: true)
PostRepository postRepository(Ref ref) {
  final service = ref.read(postApiProvider);
  return PostRepositoryImpl(service);
}

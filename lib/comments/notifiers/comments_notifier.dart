import 'package:pinapp_challenge/providers/post_repository_provider.dart';
import 'package:posts/posts.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'comments_notifier.g.dart';

@riverpod
class CommentsNotifier extends _$CommentsNotifier {
  @override
  Future<List<Comment>> build({required int postId}) {
    return _getComments(postId);
  }

  Future<List<Comment>> _getComments(int postId) async {
    final repository = ref.read(postRepositoryProvider);

    return repository.getPostComments(postId);
  }
}

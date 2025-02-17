import 'package:pinapp_challenge/providers/post_repository_provider.dart';
import 'package:posts/posts.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'post_notifier.g.dart';

@riverpod
class PostNotifier extends _$PostNotifier {
  @override
  Future<List<Post>> build() {
    return _getPosts();
  }

  Future<List<Post>> _getPosts() async {
    final repository = ref.read(postRepositoryProvider);

    return repository.getPosts();
  }

  void showMore() {
    if (state.isLoading || state.hasError) return;

    final repository = ref.read(postRepositoryProvider);

    final newPosts = repository.showMore();

    state = AsyncData(newPosts);
  }
}

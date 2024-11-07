import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:posts/posts.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit({required PostRepository repository})
      : _repository = repository,
        super(const PostsInitial());

  final PostRepository _repository;

  Future<void> getPosts() async {
    emit(const PostsLoading());
    final result = await _repository.getPosts();
    result.fold(
      (failure) => emit(PostsFailure(failure)),
      (posts) => emit(
        PostsSuccess(
          posts: posts,
          hasMore: _repository.hasMore,
        ),
      ),
    );
  }

  void showMore() {
    switch (state) {
      case PostsSuccess():
        final newPosts = _repository.showMore();

        emit(PostsSuccess(posts: newPosts, hasMore: _repository.hasMore));
      default:
        break;
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:posts/posts.dart';

part 'comments_state.dart';

class CommentsCubit extends Cubit<CommentsState> {
  CommentsCubit({required PostRepository repository})
      : _repository = repository,
        super(const CommentsInitial());

  final PostRepository _repository;

  Future<void> getPostComments(int postId) async {
    emit(const CommentsLoading());
    final result = await _repository.getPostComments(postId);
    result.fold(
      (failure) => emit(CommentsFailure(failure)),
      (comments) => emit(CommentsSuccess(comments)),
    );
  }
}

part of 'comments_cubit.dart';

sealed class CommentsState extends Equatable {
  const CommentsState();

  @override
  List<Object> get props => [];
}

final class CommentsInitial extends CommentsState {
  const CommentsInitial();
}

final class CommentsLoading extends CommentsState {
  const CommentsLoading();
}

final class CommentsSuccess extends CommentsState {
  const CommentsSuccess(this.comments);

  final List<Comment> comments;

  @override
  List<Object> get props => [comments];
}

final class CommentsFailure extends CommentsState {
  const CommentsFailure(this.failure);

  final Failure failure;

  @override
  List<Object> get props => [failure];
}

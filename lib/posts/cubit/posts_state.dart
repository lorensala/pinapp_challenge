part of 'posts_cubit.dart';

sealed class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object> get props => [];
}

final class PostsInitial extends PostsState {
  const PostsInitial();
}

final class PostsLoading extends PostsState {
  const PostsLoading();
}

final class PostsSuccess extends PostsState {
  const PostsSuccess({
    required this.posts,
    this.hasMore = true,
  });

  final List<Post> posts;
  final bool hasMore;

  @override
  List<Object> get props => [posts, hasMore];
}

final class PostsFailure extends PostsState {
  const PostsFailure(this.failure);
  final Failure failure;

  @override
  List<Object> get props => [failure];
}

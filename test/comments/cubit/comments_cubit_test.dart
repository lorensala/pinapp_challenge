import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pinapp_challenge/comments/comments.dart';
import 'package:posts/posts.dart';

import '../../mocks/mocks.dart';

void main() {
  const postId = 1;
  late PostRepository repository;
  group('CommentsCubit', () {
    setUpAll(() {
      repository = MockPostRepository();
    });
    test('instance', () {
      final commentsCubit = CommentsCubit(repository: repository);
      expect(commentsCubit, isA<CommentsCubit>());
    });

    test('initial state is CommentsInitial', () {
      final commentsCubit = CommentsCubit(repository: repository);
      expect(commentsCubit.state, const CommentsInitial());
    });

    group('getPostComments', () {
      blocTest<CommentsCubit, CommentsState>(
        '''emits [CommentsLoading, CommentsSuccess] states for successful getPostComments''',
        setUp: () {
          when(() => repository.getPostComments(postId))
              .thenAnswer((_) async => right(comments));
        },
        build: () => CommentsCubit(repository: repository),
        act: (commentsCubit) => commentsCubit.getPostComments(1),
        expect: () => [
          const CommentsLoading(),
          CommentsSuccess(comments),
        ],
      );

      blocTest<CommentsCubit, CommentsState>(
        '''emits [CommentsLoading, CommentsFailure] states for unsuccessful getPostComments''',
        setUp: () {
          when(() => repository.getPostComments(postId))
              .thenAnswer((_) async => left(Failure.notFound));
        },
        build: () => CommentsCubit(repository: repository),
        act: (commentsCubit) => commentsCubit.getPostComments(1),
        expect: () => [
          const CommentsLoading(),
          const CommentsFailure(Failure.notFound),
        ],
      );
    });
  });
}

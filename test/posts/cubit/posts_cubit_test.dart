import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pinapp_challenge/posts/cubit/posts_cubit.dart';
import 'package:posts/posts.dart';

import '../../mocks/mocks.dart';

void main() {
  group('PostsCubit', () {
    late PostRepository repository;

    setUp(() {
      repository = MockPostRepository();
    });

    test('initial state is PostsInitial', () {
      final cubit = PostsCubit(repository: repository);
      expect(cubit.state, const PostsInitial());
    });

    group('getPosts', () {
      blocTest<PostsCubit, PostsState>(
        'emits [PostsLoading, PostsSuccess] when getPosts succeeds',
        setUp: () {
          when(() => repository.hasMore).thenReturn(false);
          when(() => repository.getPosts())
              .thenAnswer((_) async => right(posts));
        },
        build: () => PostsCubit(repository: repository),
        act: (cubit) => cubit.getPosts(),
        expect: () => [
          const PostsLoading(),
          PostsSuccess(posts: posts, hasMore: false),
        ],
      );

      blocTest<PostsCubit, PostsState>(
        'emits [PostsLoading, PostsFailure] when getPosts fails',
        setUp: () {
          when(() => repository.getPosts())
              .thenAnswer((_) async => left(Failure.internalServerError));
        },
        build: () => PostsCubit(repository: repository),
        act: (cubit) => cubit.getPosts(),
        expect: () => [
          const PostsLoading(),
          const PostsFailure(Failure.internalServerError),
        ],
      );
    });

    group('showMore', () {
      blocTest<PostsCubit, PostsState>(
        'emits new PostsSuccess with updated posts when in PostsSuccess state',
        seed: () => PostsSuccess(posts: posts.take(repository.limit).toList()),
        setUp: () {
          when(() => repository.limit).thenReturn(20);
          when(() => repository.showMore())
              .thenReturn(posts.take(repository.limit * 2).toList());
          when(() => repository.hasMore).thenReturn(true);
        },
        build: () => PostsCubit(repository: repository),
        act: (cubit) => cubit.showMore(),
        expect: () => [
          PostsSuccess(
            posts: posts.take(repository.limit * 2).toList(),
          ),
        ],
        verify: (_) {
          verify(() => repository.showMore()).called(1);
          verify(() => repository.hasMore).called(1);
        },
      );

      blocTest<PostsCubit, PostsState>(
        'does not emit when not in PostsSuccess state',
        seed: () => const PostsLoading(),
        build: () => PostsCubit(repository: repository),
        act: (cubit) => cubit.showMore(),
        expect: () => const <PostsState>[],
        verify: (_) {
          verifyNever(() => repository.showMore());
          verifyNever(() => repository.hasMore);
        },
      );
    });
  });
}

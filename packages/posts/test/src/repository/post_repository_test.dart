import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:posts/posts.dart';

import '../mocks/mocks.dart';

void main() {
  late PostApi api;

  setUpAll(() {
    api = MockPostApi();
  });

  group('PostRepository', () {
    test('instance', () {
      final repository = PostRepositoryImpl(api);
      expect(repository, isA<PostRepository>());
    });

    group('getPosts', () {
      test('returns right with a list of posts', () async {
        when(() => api.getPosts()).thenAnswer((_) async => posts);
        final repository = PostRepositoryImpl(api);
        final result = await repository.getPosts();
        result.fold(
          (l) => fail('Expected Right, got Left($l)'),
          (r) {
            expect(r, posts.take(repository.limit));
            expect(repository.hasMore, true);
          },
        );
      });

      test('returns left with failure on dio exception', () async {
        when(() => api.getPosts()).thenThrow(error404);
        final repository = PostRepositoryImpl(api);
        final result = await repository.getPosts();
        result.fold(
          (l) => expect(l, Failure.notFound),
          (r) => fail('Expected Left, got Right($r)'),
        );
      });
    });

    group('showMore', () {
      test('returns a list of more posts', () async {
        when(() => api.getPosts()).thenAnswer((_) async => posts);
        final repository = PostRepositoryImpl(api);

        final postResult = await repository.getPosts();

        postResult.fold(
          (l) => fail('Expected Right, got Left($l)'),
          (r) {
            expect(r, posts.take(repository.limit).toList());
            expect(repository.hasMore, true);

            final showMoreResult = repository.showMore();

            expect(showMoreResult, posts.take(repository.limit * 2));
          },
        );
      });

      test('returns all posts', () async {
        when(() => api.getPosts()).thenAnswer((_) async => posts);
        final repository = PostRepositoryImpl(api);

        final postResult = await repository.getPosts();

        postResult.fold(
          (l) => fail('Expected Right, got Left($l)'),
          (r) {
            expect(r, posts.take(repository.limit).toList());
            expect(repository.hasMore, true);

            repository
              ..showMore()
              ..showMore()
              ..showMore()
              ..showMore()
              ..showMore()
              ..showMore();

            expect(repository.hasMore, false);
            expect(repository.posts, posts);
          },
        );
      });
    });

    group('getPostComments', () {
      test('returns right with a list of comments', () async {
        const postId = 1;
        when(() => api.getPostComments(postId))
            .thenAnswer((_) async => comments);
        final repository = PostRepositoryImpl(api);
        final result = await repository.getPostComments(postId);
        result.fold(
          (l) => fail('Expected Right, got Left($l)'),
          (r) => expect(r, comments),
        );
      });

      test('returns left with failure on dio exception', () async {
        const postId = 1;
        when(() => api.getPostComments(postId)).thenThrow(error404);
        final repository = PostRepositoryImpl(api);
        final result = await repository.getPostComments(postId);
        result.fold(
          (l) => expect(l, Failure.notFound),
          (r) => fail('Expected Left, got Right($r)'),
        );
      });
    });
  });
}

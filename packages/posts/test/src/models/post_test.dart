import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:posts/posts.dart';

import '../mocks/mocks.dart';

void main() {
  group('Post', () {
    test('can be created from json', () {
      final post = Post.fromJson(jsonEncode(postJson));

      expect(post.id, 1);
      expect(post.title, 'Test title');
      expect(post.body, 'Test body');
      expect(post.userId, 1);
    });

    test('can be converted to json', () {
      const post = Post(
        id: 1,
        title: 'Test title',
        body: 'Test body',
        userId: 1,
      );

      expect(post.toJson(), jsonEncode(postJson));
    });

    test('supports equality', () {
      expect(
        const Post(id: 1, title: 'title', body: 'body', userId: 1),
        equals(const Post(id: 1, title: 'title', body: 'body', userId: 1)),
      );
    });

    test('supports copyWith', () {
      const post = Post(
        id: 1,
        title: 'Original title',
        body: 'Original body',
        userId: 1,
      );

      final copiedPost = post.copyWith(
        title: 'New title',
        body: 'New body',
      );

      expect(copiedPost.id, post.id);
      expect(copiedPost.title, 'New title');
      expect(copiedPost.body, 'New body');
      expect(copiedPost.userId, post.userId);
    });
  });
}

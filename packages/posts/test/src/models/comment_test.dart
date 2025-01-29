import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:posts/posts.dart';

import '../mocks/mocks.dart';

void main() {
  group('Comment', () {
    test('can be created from json', () {
      final comment = Comment.fromJson(jsonEncode(commentJson));

      expect(comment.id, 1);
      expect(comment.name, 'Test name');
      expect(comment.email, 'test@email.com');
      expect(comment.body, 'Test body');
      expect(comment.postId, 1);
    });

    test('can be converted to json', () {
      const comment = Comment(
        id: 1,
        name: 'Test name',
        email: 'test@email.com',
        body: 'Test body',
        postId: 1,
      );

      expect(comment.toJson(), jsonEncode(commentJson));
    });

    test('supports equality', () {
      expect(
        const Comment(
          id: 1,
          name: 'name',
          email: 'email',
          body: 'body',
          postId: 1,
        ),
        equals(
          const Comment(
            id: 1,
            name: 'name',
            email: 'email',
            body: 'body',
            postId: 1,
          ),
        ),
      );
    });

    test('supports copyWith', () {
      const comment = Comment(
        id: 1,
        name: 'Original name',
        email: 'original@email.com',
        body: 'Original body',
        postId: 1,
      );

      final copiedComment = comment.copyWith(
        name: 'New name',
        email: 'new@email.com',
        body: 'New body',
      );

      expect(copiedComment.id, comment.id);
      expect(copiedComment.name, 'New name');
      expect(copiedComment.email, 'new@email.com');
      expect(copiedComment.body, 'New body');
      expect(copiedComment.postId, comment.postId);
    });
  });
}

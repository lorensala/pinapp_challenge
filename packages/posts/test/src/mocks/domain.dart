import 'package:posts/posts.dart';

final posts = List.generate(
  100,
  (index) => Post(
    userId: 1,
    id: index + 1,
    title: 'title',
    body: 'body',
  ),
);

final comments = List.generate(
  20,
  (index) => Comment(
    postId: 1,
    id: index + 1,
    name: 'name',
    email: 'email',
    body: 'body',
  ),
);

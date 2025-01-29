import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pinapp_challenge/app/app.dart';
import 'package:pinapp_challenge/posts/posts.dart';
import 'package:posts/posts.dart';

import '../../mocks/mocks.dart';

void main() {
  late PostApi postApi;
  late PostRepository postRepository;

  setUpAll(() {
    postApi = MockPostApi();
    postRepository = PostRepositoryImpl(postApi);
  });

  testWidgets('$PostDetailPage loads comments', (tester) async {
    const postId = 1;
    when(() => postApi.getPosts()).thenAnswer((_) async => posts);
    when(() => postApi.getPostComments(postId))
        .thenAnswer((_) async => comments);

    await tester.pumpWidget(App(postRepository: postRepository));

    await tester.pump();

    await tester.tap(find.byType(PostListItem).first);

    expect(find.byType(CupertinoActivityIndicator), findsOneWidget);

    await tester.pumpAndSettle();

    expect(find.byType(PostContent), findsOneWidget);
    expect(find.byType(PostComments), findsOneWidget);
    expect(find.text('name'), findsNWidgets(postRepository.limit));
  });

  testWidgets('$PostDetailPage shows error message', (tester) async {
    const postId = 1;
    when(() => postApi.getPosts()).thenAnswer((_) async => posts);
    when(() => postApi.getPostComments(postId)).thenThrow(error500);

    await tester.pumpWidget(App(postRepository: postRepository));

    await tester.pump();

    await tester.tap(find.byType(PostListItem).first);

    await tester.pumpAndSettle();

    expect(find.text(Failure.internalServerError.message), findsOneWidget);
  });
}

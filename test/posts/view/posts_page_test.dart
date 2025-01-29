import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pinapp_challenge/app/app.dart';
import 'package:pinapp_challenge/comments/comments.dart';
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

  testWidgets('$PostsPage loads posts', (tester) async {
    when(() => postApi.getPosts()).thenAnswer((_) async => posts);

    await tester.pumpWidget(App(postRepository: postRepository));

    expect(find.byType(CupertinoActivityIndicator), findsOneWidget);

    await tester.pump();

    expect(find.byType(PostList), findsOneWidget);
    expect(find.text('title'), findsNWidgets(postRepository.limit));
    expect(find.text('body'), findsNWidgets(postRepository.limit));
  });

  testWidgets('$PostList loads more posts', (tester) async {
    when(() => postApi.getPosts()).thenAnswer((_) async => posts);

    await tester.pumpWidget(App(postRepository: postRepository));

    await tester.pump();

    // Busca el widget SingleChildScrollView para obtener el controller
    final list = find.byType(SingleChildScrollView).evaluate().first.widget
        as SingleChildScrollView;
    // Salta al final de la lista para cargar más posts
    list.controller?.jumpTo(list.controller!.position.maxScrollExtent);

    await tester.pump();

    expect(find.text('title'), findsNWidgets(postRepository.limit * 2));
    expect(find.text('body'), findsNWidgets(postRepository.limit * 2));
  });

  testWidgets('$PostsPage shows error message', (tester) async {
    when(() => postApi.getPosts()).thenThrow(error500);

    await tester.pumpWidget(App(postRepository: postRepository));

    await tester.pump();

    expect(find.text(Failure.internalServerError.message), findsOneWidget);
  });

  testWidgets('$PostListItem has its own $CommentsCubit', (tester) async {
    when(() => postApi.getPosts()).thenAnswer((_) async => posts);

    await tester.pumpWidget(App(postRepository: postRepository));

    await tester.pump();

    expect(
      find.byType(BlocProvider<CommentsCubit>),
      findsNWidgets(postRepository.limit),
    );
  });

  testWidgets('$PostListItem navigates to $PostDetailPage', (tester) async {
    when(() => postApi.getPosts()).thenAnswer((_) async => posts);

    await tester.pumpWidget(App(postRepository: postRepository));

    await tester.pump();

    await tester.tap(find.text('title').first);

    await tester.pumpAndSettle();

    expect(find.byType(PostDetailPage), findsOneWidget);
  });
}

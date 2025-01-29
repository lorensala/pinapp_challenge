import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:posts/posts.dart';

import '../mocks/mocks.dart';

void main() {
  late Dio dio;
  late PostApi api;
  late MethodChannel channel;

  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    dio = MockDio();
    api = JsonPlaceholderPostApi(dio);
    channel = const MethodChannel(channelName);
  });

  group('JsonPlaceholderPostApi', () {
    test('instance', () {
      final api = JsonPlaceholderPostApi(MockDio());
      expect(api, isA<PostApi>());
    });

    group('getPosts', () {
      test('returns a list of posts', () async {
        when(
          () => dio.get<List<dynamic>>(any()),
        ).thenAnswer((_) async {
          return Response(
            data: postsJsonResponse,
            statusCode: 200,
            requestOptions: RequestOptions(),
          );
        });

        final posts = await api.getPosts();
        expect(posts, isA<List<Post>>());
      });

      test('throws an exception on error', () async {
        when(
          () => dio.get<List<dynamic>>(any()),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(),
            response: Response(
              statusCode: 404,
              requestOptions: RequestOptions(),
            ),
          ),
        );

        expect(api.getPosts(), throwsException);
      });

      test('throws an exception on invalid json', () async {
        when(
          () => dio.get<List<dynamic>>(any()),
        ).thenAnswer((_) async {
          return Response(
            data: wrongPostsJsonResponse,
            statusCode: 200,
            requestOptions: RequestOptions(),
          );
        });

        expect(api.getPosts(), throwsException);
      });
    });

    group('getPostComments', () {
      test('returns a list of comments', () async {
        const postId = 1;

        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(channel, (call) async {
          expect(call.arguments, {'postId': postId});
          expect(call.method, 'getPostComments');

          return commentsJsonResponse;
        });

        final comments = await api.getPostComments(postId);
        expect(comments, isA<List<Comment>>());
      });

      test('throws an exception on error', () async {
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(channel, (call) async {
          throw PlatformException(code: '404');
        });

        expect(api.getPostComments(1), throwsException);
      });
    });
  });
}

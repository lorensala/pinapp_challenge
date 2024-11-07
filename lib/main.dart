import 'package:dio/dio.dart';
import 'package:pinapp_challenge/app/app.dart';
import 'package:pinapp_challenge/bootstrap.dart';
import 'package:posts/posts.dart';

void main() {
  final dio = Dio();
  final postApi = JsonPlaceholderPostApi(dio);
  final postRepository = PostRepositoryImpl(postApi);

  bootstrap(
    () => App(
      postRepository: postRepository,
    ),
  );
}

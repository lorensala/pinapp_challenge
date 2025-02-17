// coverage:ignore-file

import 'package:posts/posts.dart';

String parseError(dynamic error) {
  if (error is Failure) {
    return error.message;
  } else {
    return error.toString();
  }
}

import 'package:dio/dio.dart';

final error500 = DioException(
  requestOptions: RequestOptions(),
  response: Response(
    statusCode: 500,
    requestOptions: RequestOptions(),
  ),
);

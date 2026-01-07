import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../features/tasks/domain/entities/task.dart'; // import dependencies for generated code if needed, assuming Token is somewhere or I'll use dynamic for now if Token not found. User said Future<Token> login.

part 'api_client.g.dart';


@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'http://192.168.0.106:8080',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );
  
  dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  
  return dio;
}

@riverpod
ApiClient apiClient(Ref ref) => ApiClient(ref.watch(dioProvider));

@RestApi(baseUrl: 'http://192.168.0.106:8080')
abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  @POST('/tasks')
  Future<Task> createTask(@Body() Map<String, dynamic> task);
  
  // Adding methods implied by user usage or standard patterns
}


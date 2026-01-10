import 'dart:io';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../features/tasks/domain/entities/task.dart';
import '../../features/tasks/data/models/agent_response.dart';

part 'api_client.g.dart';

@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'http://192.168.0.104:8080',
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    ),
  );

  dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));

  return dio;
}

@riverpod
ApiClient apiClient(Ref ref) => ApiClient(ref.watch(dioProvider));

@RestApi(baseUrl: 'http://192.168.0.104:8080')
abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  @POST('/tasks')
  Future<Task> createTask(@Body() Map<String, dynamic> task);

  @GET('/tasks')
  Future<List<Task>> getTasks();

  @POST('/stt/on-device')
  Future<AgentResponse> processTranscript(@Body() Map<String, dynamic> body);

  @POST('/stt/whisper')
  @MultiPart()
  Future<AgentResponse> uploadAudio(
    @Part(name: "file") File file,
    @Part(name: "user_timezone") String userTimezone,
  );
}

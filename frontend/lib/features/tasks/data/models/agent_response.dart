import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/task.dart';

part 'agent_response.freezed.dart';
part 'agent_response.g.dart';

@freezed
abstract class AgentResponse with _$AgentResponse {
  const factory AgentResponse({
    required String type,
    @Default([]) List<Task> tasks,
    @JsonKey(name: 'needs_clarification')
    @Default(false)
    bool needsClarification,
    @JsonKey(name: 'clarification_question') String? clarificationQuestion,
  }) = _AgentResponse;

  factory AgentResponse.fromJson(Map<String, dynamic> json) =>
      _$AgentResponseFromJson(json);
}

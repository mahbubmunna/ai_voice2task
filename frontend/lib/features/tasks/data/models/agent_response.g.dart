// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agent_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AgentResponse _$AgentResponseFromJson(Map<String, dynamic> json) =>
    _AgentResponse(
      type: json['type'] as String,
      tasks:
          (json['tasks'] as List<dynamic>?)
              ?.map((e) => Task.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      needsClarification: json['needs_clarification'] as bool? ?? false,
      clarificationQuestion: json['clarification_question'] as String?,
    );

Map<String, dynamic> _$AgentResponseToJson(_AgentResponse instance) =>
    <String, dynamic>{
      'type': instance.type,
      'tasks': instance.tasks,
      'needs_clarification': instance.needsClarification,
      'clarification_question': instance.clarificationQuestion,
    };

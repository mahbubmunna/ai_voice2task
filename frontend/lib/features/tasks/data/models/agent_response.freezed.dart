// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'agent_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AgentResponse {

 String get type; List<Task> get tasks;@JsonKey(name: 'needs_clarification') bool get needsClarification;@JsonKey(name: 'clarification_question') String? get clarificationQuestion;
/// Create a copy of AgentResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AgentResponseCopyWith<AgentResponse> get copyWith => _$AgentResponseCopyWithImpl<AgentResponse>(this as AgentResponse, _$identity);

  /// Serializes this AgentResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AgentResponse&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.tasks, tasks)&&(identical(other.needsClarification, needsClarification) || other.needsClarification == needsClarification)&&(identical(other.clarificationQuestion, clarificationQuestion) || other.clarificationQuestion == clarificationQuestion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,const DeepCollectionEquality().hash(tasks),needsClarification,clarificationQuestion);

@override
String toString() {
  return 'AgentResponse(type: $type, tasks: $tasks, needsClarification: $needsClarification, clarificationQuestion: $clarificationQuestion)';
}


}

/// @nodoc
abstract mixin class $AgentResponseCopyWith<$Res>  {
  factory $AgentResponseCopyWith(AgentResponse value, $Res Function(AgentResponse) _then) = _$AgentResponseCopyWithImpl;
@useResult
$Res call({
 String type, List<Task> tasks,@JsonKey(name: 'needs_clarification') bool needsClarification,@JsonKey(name: 'clarification_question') String? clarificationQuestion
});




}
/// @nodoc
class _$AgentResponseCopyWithImpl<$Res>
    implements $AgentResponseCopyWith<$Res> {
  _$AgentResponseCopyWithImpl(this._self, this._then);

  final AgentResponse _self;
  final $Res Function(AgentResponse) _then;

/// Create a copy of AgentResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? tasks = null,Object? needsClarification = null,Object? clarificationQuestion = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,tasks: null == tasks ? _self.tasks : tasks // ignore: cast_nullable_to_non_nullable
as List<Task>,needsClarification: null == needsClarification ? _self.needsClarification : needsClarification // ignore: cast_nullable_to_non_nullable
as bool,clarificationQuestion: freezed == clarificationQuestion ? _self.clarificationQuestion : clarificationQuestion // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AgentResponse].
extension AgentResponsePatterns on AgentResponse {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AgentResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AgentResponse() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AgentResponse value)  $default,){
final _that = this;
switch (_that) {
case _AgentResponse():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AgentResponse value)?  $default,){
final _that = this;
switch (_that) {
case _AgentResponse() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  List<Task> tasks, @JsonKey(name: 'needs_clarification')  bool needsClarification, @JsonKey(name: 'clarification_question')  String? clarificationQuestion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AgentResponse() when $default != null:
return $default(_that.type,_that.tasks,_that.needsClarification,_that.clarificationQuestion);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  List<Task> tasks, @JsonKey(name: 'needs_clarification')  bool needsClarification, @JsonKey(name: 'clarification_question')  String? clarificationQuestion)  $default,) {final _that = this;
switch (_that) {
case _AgentResponse():
return $default(_that.type,_that.tasks,_that.needsClarification,_that.clarificationQuestion);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  List<Task> tasks, @JsonKey(name: 'needs_clarification')  bool needsClarification, @JsonKey(name: 'clarification_question')  String? clarificationQuestion)?  $default,) {final _that = this;
switch (_that) {
case _AgentResponse() when $default != null:
return $default(_that.type,_that.tasks,_that.needsClarification,_that.clarificationQuestion);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AgentResponse implements AgentResponse {
  const _AgentResponse({required this.type, final  List<Task> tasks = const [], @JsonKey(name: 'needs_clarification') this.needsClarification = false, @JsonKey(name: 'clarification_question') this.clarificationQuestion}): _tasks = tasks;
  factory _AgentResponse.fromJson(Map<String, dynamic> json) => _$AgentResponseFromJson(json);

@override final  String type;
 final  List<Task> _tasks;
@override@JsonKey() List<Task> get tasks {
  if (_tasks is EqualUnmodifiableListView) return _tasks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tasks);
}

@override@JsonKey(name: 'needs_clarification') final  bool needsClarification;
@override@JsonKey(name: 'clarification_question') final  String? clarificationQuestion;

/// Create a copy of AgentResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AgentResponseCopyWith<_AgentResponse> get copyWith => __$AgentResponseCopyWithImpl<_AgentResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AgentResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AgentResponse&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other._tasks, _tasks)&&(identical(other.needsClarification, needsClarification) || other.needsClarification == needsClarification)&&(identical(other.clarificationQuestion, clarificationQuestion) || other.clarificationQuestion == clarificationQuestion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,const DeepCollectionEquality().hash(_tasks),needsClarification,clarificationQuestion);

@override
String toString() {
  return 'AgentResponse(type: $type, tasks: $tasks, needsClarification: $needsClarification, clarificationQuestion: $clarificationQuestion)';
}


}

/// @nodoc
abstract mixin class _$AgentResponseCopyWith<$Res> implements $AgentResponseCopyWith<$Res> {
  factory _$AgentResponseCopyWith(_AgentResponse value, $Res Function(_AgentResponse) _then) = __$AgentResponseCopyWithImpl;
@override @useResult
$Res call({
 String type, List<Task> tasks,@JsonKey(name: 'needs_clarification') bool needsClarification,@JsonKey(name: 'clarification_question') String? clarificationQuestion
});




}
/// @nodoc
class __$AgentResponseCopyWithImpl<$Res>
    implements _$AgentResponseCopyWith<$Res> {
  __$AgentResponseCopyWithImpl(this._self, this._then);

  final _AgentResponse _self;
  final $Res Function(_AgentResponse) _then;

/// Create a copy of AgentResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? tasks = null,Object? needsClarification = null,Object? clarificationQuestion = freezed,}) {
  return _then(_AgentResponse(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,tasks: null == tasks ? _self._tasks : tasks // ignore: cast_nullable_to_non_nullable
as List<Task>,needsClarification: null == needsClarification ? _self.needsClarification : needsClarification // ignore: cast_nullable_to_non_nullable
as bool,clarificationQuestion: freezed == clarificationQuestion ? _self.clarificationQuestion : clarificationQuestion // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

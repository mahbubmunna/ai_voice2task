// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Task {

@HiveField(0) String get title;@HiveField(1) String? get description;@JsonKey(name: 'due_datetime')@HiveField(2) DateTime? get dueAt;@JsonKey(name: 'reminder_datetime')@HiveField(3) DateTime? get reminderAt;@HiveField(4) double get confidence;@HiveField(5) bool get isCompleted;
/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskCopyWith<Task> get copyWith => _$TaskCopyWithImpl<Task>(this as Task, _$identity);

  /// Serializes this Task to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Task&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.dueAt, dueAt) || other.dueAt == dueAt)&&(identical(other.reminderAt, reminderAt) || other.reminderAt == reminderAt)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,description,dueAt,reminderAt,confidence,isCompleted);

@override
String toString() {
  return 'Task(title: $title, description: $description, dueAt: $dueAt, reminderAt: $reminderAt, confidence: $confidence, isCompleted: $isCompleted)';
}


}

/// @nodoc
abstract mixin class $TaskCopyWith<$Res>  {
  factory $TaskCopyWith(Task value, $Res Function(Task) _then) = _$TaskCopyWithImpl;
@useResult
$Res call({
@HiveField(0) String title,@HiveField(1) String? description,@JsonKey(name: 'due_datetime')@HiveField(2) DateTime? dueAt,@JsonKey(name: 'reminder_datetime')@HiveField(3) DateTime? reminderAt,@HiveField(4) double confidence,@HiveField(5) bool isCompleted
});




}
/// @nodoc
class _$TaskCopyWithImpl<$Res>
    implements $TaskCopyWith<$Res> {
  _$TaskCopyWithImpl(this._self, this._then);

  final Task _self;
  final $Res Function(Task) _then;

/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? description = freezed,Object? dueAt = freezed,Object? reminderAt = freezed,Object? confidence = null,Object? isCompleted = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,dueAt: freezed == dueAt ? _self.dueAt : dueAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reminderAt: freezed == reminderAt ? _self.reminderAt : reminderAt // ignore: cast_nullable_to_non_nullable
as DateTime?,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Task].
extension TaskPatterns on Task {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Task value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Task() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Task value)  $default,){
final _that = this;
switch (_that) {
case _Task():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Task value)?  $default,){
final _that = this;
switch (_that) {
case _Task() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@HiveField(0)  String title, @HiveField(1)  String? description, @JsonKey(name: 'due_datetime')@HiveField(2)  DateTime? dueAt, @JsonKey(name: 'reminder_datetime')@HiveField(3)  DateTime? reminderAt, @HiveField(4)  double confidence, @HiveField(5)  bool isCompleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Task() when $default != null:
return $default(_that.title,_that.description,_that.dueAt,_that.reminderAt,_that.confidence,_that.isCompleted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@HiveField(0)  String title, @HiveField(1)  String? description, @JsonKey(name: 'due_datetime')@HiveField(2)  DateTime? dueAt, @JsonKey(name: 'reminder_datetime')@HiveField(3)  DateTime? reminderAt, @HiveField(4)  double confidence, @HiveField(5)  bool isCompleted)  $default,) {final _that = this;
switch (_that) {
case _Task():
return $default(_that.title,_that.description,_that.dueAt,_that.reminderAt,_that.confidence,_that.isCompleted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@HiveField(0)  String title, @HiveField(1)  String? description, @JsonKey(name: 'due_datetime')@HiveField(2)  DateTime? dueAt, @JsonKey(name: 'reminder_datetime')@HiveField(3)  DateTime? reminderAt, @HiveField(4)  double confidence, @HiveField(5)  bool isCompleted)?  $default,) {final _that = this;
switch (_that) {
case _Task() when $default != null:
return $default(_that.title,_that.description,_that.dueAt,_that.reminderAt,_that.confidence,_that.isCompleted);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Task implements Task {
  const _Task({@HiveField(0) required this.title, @HiveField(1) this.description, @JsonKey(name: 'due_datetime')@HiveField(2) this.dueAt, @JsonKey(name: 'reminder_datetime')@HiveField(3) this.reminderAt, @HiveField(4) this.confidence = 0.0, @HiveField(5) this.isCompleted = false});
  factory _Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

@override@HiveField(0) final  String title;
@override@HiveField(1) final  String? description;
@override@JsonKey(name: 'due_datetime')@HiveField(2) final  DateTime? dueAt;
@override@JsonKey(name: 'reminder_datetime')@HiveField(3) final  DateTime? reminderAt;
@override@JsonKey()@HiveField(4) final  double confidence;
@override@JsonKey()@HiveField(5) final  bool isCompleted;

/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskCopyWith<_Task> get copyWith => __$TaskCopyWithImpl<_Task>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaskToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Task&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.dueAt, dueAt) || other.dueAt == dueAt)&&(identical(other.reminderAt, reminderAt) || other.reminderAt == reminderAt)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,description,dueAt,reminderAt,confidence,isCompleted);

@override
String toString() {
  return 'Task(title: $title, description: $description, dueAt: $dueAt, reminderAt: $reminderAt, confidence: $confidence, isCompleted: $isCompleted)';
}


}

/// @nodoc
abstract mixin class _$TaskCopyWith<$Res> implements $TaskCopyWith<$Res> {
  factory _$TaskCopyWith(_Task value, $Res Function(_Task) _then) = __$TaskCopyWithImpl;
@override @useResult
$Res call({
@HiveField(0) String title,@HiveField(1) String? description,@JsonKey(name: 'due_datetime')@HiveField(2) DateTime? dueAt,@JsonKey(name: 'reminder_datetime')@HiveField(3) DateTime? reminderAt,@HiveField(4) double confidence,@HiveField(5) bool isCompleted
});




}
/// @nodoc
class __$TaskCopyWithImpl<$Res>
    implements _$TaskCopyWith<$Res> {
  __$TaskCopyWithImpl(this._self, this._then);

  final _Task _self;
  final $Res Function(_Task) _then;

/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? description = freezed,Object? dueAt = freezed,Object? reminderAt = freezed,Object? confidence = null,Object? isCompleted = null,}) {
  return _then(_Task(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,dueAt: freezed == dueAt ? _self.dueAt : dueAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reminderAt: freezed == reminderAt ? _self.reminderAt : reminderAt // ignore: cast_nullable_to_non_nullable
as DateTime?,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on

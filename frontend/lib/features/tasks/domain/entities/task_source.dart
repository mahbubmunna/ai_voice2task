import 'package:hive_ce/hive.dart';

part 'task_source.g.dart';

@HiveType(typeId: 1)
enum TaskSource {
  @HiveField(0)
  voice,
  @HiveField(1)
  text,
}

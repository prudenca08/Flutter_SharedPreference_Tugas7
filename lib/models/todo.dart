import 'package:hive/hive.dart';
part 'todo.g.dart';

@HiveType(typeId: 0)
class Todo extends HiveObject{
  @HiveField(0)
  String? id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String jenis;
  @HiveField(3)
  final String imageLogo;
  Todo({
    required this.name,
    required this.jenis,
    required this.imageLogo,
  });
}
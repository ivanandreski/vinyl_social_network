
import 'package:isar/isar.dart';

part 'stylus.g.dart';

@collection
class Stylus {
  Id id = Isar.autoIncrement;

  late final int stylusId;
  late final String name;
  late final bool isRetired;
  late final int playtime;

  Stylus({required this.stylusId, required this.name, required this.isRetired, required this.playtime});
}
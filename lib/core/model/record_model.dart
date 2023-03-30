// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive_flutter/hive_flutter.dart';

import '../../product/constants/hive_constants.dart';

part 'record_model.g.dart';

@HiveType(typeId: HiveConstants.recordModelId)
class Record extends HiveObject {
  @HiveField(0)
  final double weight;
  @HiveField(1)
  final String? note;
  @HiveField(2)
  final String? image;
  @HiveField(3)
  final DateTime date;
  Record({required this.date, required this.weight, this.image, this.note});
}

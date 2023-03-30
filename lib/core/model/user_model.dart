// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive_flutter/hive_flutter.dart';

import '../../product/constants/hive_constants.dart';

part 'user_model.g.dart';

@HiveType(typeId: HiveConstants.userModelId)
class User extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  int goal;
  @HiveField(2)
  double height;
  User({
    required this.name,
    required this.goal,
    required this.height,
  });
}

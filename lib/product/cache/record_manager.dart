import '../../core/model/record_model.dart';
import '../constants/hive_constants.dart';
import 'local_manager.dart';

class RecordManager extends ILocalManager<Record> {
  RecordManager._init() : super(title: HiveConstants.recordBoxname);
  factory RecordManager.getInstance() {
    return RecordManager._init();
  }

  List<Record> get recordList => getItems();
}

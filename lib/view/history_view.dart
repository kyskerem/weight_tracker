import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../core/model/record_model.dart';
import '../product/cache/record_manager.dart';
import '../product/enums/edge_insets.dart';
import '../product/extension/text_styles.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _HistoryList());
  }
}

class _HistoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: Provider.of<RecordManager>(context).recordList.length,
      itemBuilder: (context, index) {
        final record = Provider.of<RecordManager>(context)
            .recordList
            .reversed
            .elementAt(index);
        return _ExpansionTile(
          record,
          context,
          recordImage(context, record),
          index,
        );
      },
    );
  }

  Widget recordImage(BuildContext context, Record record) {
    final imagePath = record.image;
    final image =
        imagePath == null ? const SizedBox() : Image.file(File(imagePath));
    return _ImageButton(image, context);
  }
}

class _ExpansionTile extends ExpansionTile {
  _ExpansionTile(
    Record record,
    BuildContext context,
    Widget recordImage,
    int index,
  ) : super(
          key: PageStorageKey(record.key),
          expandedAlignment: Alignment.center,
          leading: Text(
            '${Provider.of<RecordManager>(context).recordList.length - index}',
            textAlign: TextAlign.center,
          ),
          title: Center(
            child: _RecordDate(record),
          ),
          children: [
            _RecordListTile(context, record, recordImage),
          ],
        );
}

class _RecordListTile extends ListTile {
  _RecordListTile(BuildContext context, Record record, Widget recordImage)
      : super(
          contentPadding: EdgeInsetsValues.listTileContentPadding.value(),
          leading: recordImage,
          title: Center(child: _RecordWeight(record)),
          subtitle: Padding(
            padding: EdgeInsetsValues.recordNotePadding.value(),
            child: _RecordNote(record),
          ),
          trailing: _DeleteButton(record, context),
        );
}

class _ImageButton extends InkWell {
  _ImageButton(Widget image, BuildContext context)
      : super(
          onTap: () => showDialog<Dialog>(
            context: context,
            builder: (context) => Dialog(
              child: InteractiveViewer(
                child: image,
              ),
            ),
          ),
          child: image,
        );
}

class _DeleteButton extends IconButton {
  _DeleteButton(Record record, BuildContext context)
      : super(
          icon: const Icon(Icons.delete),
          onPressed: () {
            Provider.of<RecordManager>(context, listen: false)
                .removeFromBox(record.key);
          },
          color: Theme.of(context).colorScheme.secondary,
        );
}

class _RecordWeight extends Text {
  _RecordWeight(Record record)
      : super(
          '${record.weight}Kg',
          style: const TextStyle().montserratw600s20,
          textAlign: TextAlign.center,
        );
}

class _RecordDate extends Text {
  _RecordDate(Record record)
      : super(
          DateFormat('yyyy  MMM  d').format(record.date),
          style: const TextStyle().montserratw500s20,
          textAlign: TextAlign.center,
        );
}

class _RecordNote extends Text {
  _RecordNote(Record record)
      : super(
          record.note ?? '',
          style: const TextStyle().poppinsw500,
          textAlign: TextAlign.center,
        );
}

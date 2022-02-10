import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/selectedtab.dart';
import '../themes/colorformatter.dart';
import '../themes/texttheme.dart';

import '../models/tasklist.dart';

Color darkColor = Colors.black,
    mediumColor = Colors.black,
    lightColor = Colors.black;

class TaskCard extends StatelessWidget {
  TaskCard({
    Key? key,
    required this.title,
    required this.colorScheme,
    required this.date,
    required this.time,
    this.status = Status.upcoming,
    required this.index,
  }) : super(key: key);

  String title, date;
  Color colorScheme;
  String time;
  Status status;
  int index;

  @override
  Widget build(BuildContext context) {
    var editList = context.read<TaskList>();
    darkColor = ColorFormatter.darken(colorScheme);
    mediumColor = ColorFormatter.medium(colorScheme);
    lightColor = ColorFormatter.lighten(colorScheme);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        overlayColor: MaterialStateProperty.all(mediumColor),
        splashColor: darkColor,
        focusColor: mediumColor,
        highlightColor: mediumColor,
        onTap: () {
          status == Status.upcoming
              ? editList.taskChecked(index)
              : editList.taskUnchecked(index);

          log('hello');
        },
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: lightColor,
          ),
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 12),
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: typography.headline2!.copyWith(color: darkColor),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    _MetaRow(Icons.event, date),
                    const SizedBox(
                      height: 12,
                    ),
                    _MetaRow(Icons.schedule, time),
                  ],
                ),
              ),
              Positioned(
                right: 16,
                top: 12,
                child: Icon(
                  status == Status.checked
                      ? Icons.check_box
                      : Icons.check_box_outline_blank,
                  color: mediumColor,
                ),
              ),
              Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                child: Container(
                  width: 12,
                  decoration: BoxDecoration(
                      color: mediumColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MetaRow extends Row {
  _MetaRow(this.iconData, this.data)
      : super(children: [
          Icon(
            iconData,
            color: darkColor,
            size: 16,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              data,
              style: typography.bodyText2!.copyWith(
                color: darkColor,
              ),
              softWrap: true,
            ),
          ),
        ]);

  IconData iconData;
  String data;
}

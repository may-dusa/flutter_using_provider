import 'package:flutter/material.dart';

import '../themes/texttheme.dart';

import '../models/selectedtab.dart';

class AppTab extends Container {
  AppTab({
    Key? key,
    required Status label,
    required bool isSelected,
  }) : super(
            key: key,
            margin: const EdgeInsets.only(right: 16),
            child: Text(
              (label == Status.upcoming) ? "UPCOMING" : "COMPLETED",
              style: typography.overline!.copyWith(
                  color: isSelected ? Colors.black87 : Colors.black38),
            ),
            decoration: BoxDecoration(
              border: BorderDirectional(
                bottom: BorderSide(
                    width: 2,
                    color: isSelected ? Colors.black87 : Colors.transparent),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12));
}

import 'package:flutter/material.dart';

class ThinDivider extends Container {
  ThinDivider({Key? key})
      : super(
          key: key,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        );
  ThinDivider.withLine({Key? key})
      : super(
            key: key,
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: const Center(
                child: Divider(
              color: Colors.black54,
            )));
}

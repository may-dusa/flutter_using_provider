import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

enum Status { upcoming, checked }

class SelectedTab extends ChangeNotifier {
  static Status selectedStatus = Status.upcoming;

  Status get selected => selectedStatus;

  void changeState() {
    if (selectedStatus == Status.upcoming)
      selectedStatus = Status.checked;
    else
      selectedStatus = Status.upcoming;

    notifyListeners();
  }
}

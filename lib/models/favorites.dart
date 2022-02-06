import 'package:flutter/foundation.dart';
import 'image_catalog.dart';

class FavoriteModel extends ChangeNotifier {
  final List<int> _imgs = [];

  List get favUrls => _imgs;

  void add(int x) {
    _imgs.add(x);
    notifyListeners();
  }

  void remove(int x) {
    _imgs.remove(x);
    notifyListeners();
  }
}

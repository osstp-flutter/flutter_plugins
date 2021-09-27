import 'package:flutter/material.dart';

class OthersPageProvider extends ChangeNotifier {

  /// Tab的下标
  int _index = 0;
  int get index => _index;
  /// 数量
  final List<int> _countList = [0, 0, 0, 0, 0, 0,0, 0, 0,0];
  List<int> get countList => _countList;

  /// 选中分类下标
  int _sortIndex = 0;
  int get sortIndex => _sortIndex;

  void setSortIndex(int sortIndex) {
    _sortIndex = sortIndex;
    notifyListeners();
  }

  void setIndex(int index) {
    _index = index;
    notifyListeners();
  }

  void setCount(int count) {
    _countList[index] = count;
    notifyListeners();
  }
}
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class ILocalManager<T> with ChangeNotifier {
  ILocalManager({required String title}) {
    _box ??= Hive.box<T>(title);
  }
  Box<T>? _box;
  Future<void> addItem(T item) async {
    await _box?.add(item);
    notifyListeners();
  }

  T? getItem(dynamic key) {
    return _box?.get(key);
  }

  Future<void> putItem(dynamic key, T value) async {
    await _box?.put(key, value);
    notifyListeners();
  }

  Future<void> removeFromBox(dynamic key) async {
    await _box?.delete(key);
    notifyListeners();
  }

  Future<void> editItem(dynamic key, T newItem) async {
    await _box?.put(key, newItem);
    notifyListeners();
  }

  Future<void> clearBox() async {
    await _box?.clear();
    notifyListeners();
  }

  List<T> getItems() {
    return _box?.values.toList() ?? [];
  }
}

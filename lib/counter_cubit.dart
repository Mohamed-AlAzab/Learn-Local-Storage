import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0) {
    _init();
  }

  static const String _counterKey = 'counter';
  late SharedPreferences _prefs;

  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
    final savedValue = _prefs.getInt(_counterKey) ?? 0;
    emit(savedValue);
  }

  void increment() {
    emit(state + 1);
    _save();
  }

  void decrement() {
    emit(state - 1);
    _save();
  }

  void reset() {
    emit(0);
    _save();
  }

  Future<void> _save() async {
    await _prefs.setInt(_counterKey, state);
  }
}

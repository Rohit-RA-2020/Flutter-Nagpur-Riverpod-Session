// provider

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_sample/models/user.dart';

final nameProvider = Provider<String>((ref) => 'Flutter Nagpur');

// StateProvider

final counterProvider = StateProvider<int>((ref) => 0);

// StateNotifierProvider

final counterNotifierProvider = StateNotifierProvider<Counter, int>(
  (ref) => Counter(),
);

class Counter extends StateNotifier<int> {
  Counter() : super(0);

  void increment() => state++;
}

// ChangeNotifierProvider

final counterChangeNotifierProvider =
    ChangeNotifierProvider((ref) => CounterNotifier());

class CounterNotifier extends ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void incerement() {
    _count++;
    notifyListeners();
  }
}

final isDarkThemeProvider = StateProvider((ref) => true);

// Future Provider

final usersProvider = FutureProvider((ref) {
  return http
      .get(
        Uri.parse('https://jsonplaceholder.typicode.com/ereorieoeri'),
      )
      .then((value) => usersFromJson(value.body));
});

final cartProvider = StateNotifierProvider<Cart, List<int>>((ref) => Cart());

class Cart extends StateNotifier<List<int>> {
  Cart() : super([]);

  void add(int id) {
    state = [...state, id];
  }

  void remove(int id) {
    state = state.where((element) => element != id).toList();
  }
}

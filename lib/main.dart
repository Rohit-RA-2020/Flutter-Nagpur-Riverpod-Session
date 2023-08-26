import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_sample/providers/provider.dart';
import 'package:riverpod_sample/screens/grocery_screen.dart';
import 'package:riverpod_sample/screens/my_user.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarktheme = ref.watch(isDarkThemeProvider);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: isDarktheme ? Brightness.dark : Brightness.light,
        useMaterial3: true,
      ),
      home: const GroceryPage(),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterChangeNotifierProvider);
    final isDarktheme = ref.watch(isDarkThemeProvider);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You presses this button this many times',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            Text(
              counter.count.toString(),
              style: const TextStyle(
                fontSize: 24,
              ),
            ),
            Switch(
              value: isDarktheme,
              onChanged: (value) {
                ref.read(isDarkThemeProvider.notifier).state = value;
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(counterChangeNotifierProvider.notifier).incerement();
        },
        child: const Icon(Icons.add),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

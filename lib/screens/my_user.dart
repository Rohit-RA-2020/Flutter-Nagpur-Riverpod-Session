import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_sample/providers/provider.dart';

class MyUsers extends ConsumerStatefulWidget {
  const MyUsers({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyUsersState();
}

class _MyUsersState extends ConsumerState<MyUsers> {
  @override
  Widget build(BuildContext context) {
    return ref.watch(usersProvider).when(
      data: (data) {
        return Scaffold(
          body: Center(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: ((context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data[index].name,
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                      Text(
                        data[index].email,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        );
      },
      error: (error, stackTrace) {
        return const Scaffold(
          body: Center(
            child: Text('Error Loading Data'),
          ),
        );
      },
      loading: () {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

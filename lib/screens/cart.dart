import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_sample/models/grocery.dart';
import 'package:riverpod_sample/providers/provider.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartItems = ref.watch(cartProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Page'),
      ),
      body: cartItems.isEmpty
          ? const Center(
              child: Text(
                'Cart is Empty',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            )
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Image.network(
                          groceryList[cartItems[index]]['image'].toString(),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            // Other important details beautifully formated
                            Text(
                              groceryList[cartItems[index]]['name'].toString(),
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            Text(
                              '\$ ${groceryList[cartItems[index]]['price'].toString()}',
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.grey),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                ref.read(cartProvider.notifier).remove(index);
                              },
                              child: const Text('Remove Item'),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

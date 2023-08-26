import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_sample/providers/provider.dart';
import 'package:riverpod_sample/screens/cart.dart';

import '../models/grocery.dart';

class GroceryPage extends ConsumerStatefulWidget {
  const GroceryPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GroceryPageState();
}

class _GroceryPageState extends ConsumerState<GroceryPage> {

  @override
  Widget build(BuildContext context) {
    final cartItems = ref.watch(cartProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grocery'),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const CartScreen(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.shopping_cart,
                  size: 30,
                ),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: Text(
                    cartItems.length.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: ListView.builder(
          itemCount: groceryList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Image.network(
                      groceryList[index]['image'].toString(),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        // Other important details beautifully formated
                        Text(
                          groceryList[index]['name'].toString(),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Text(
                          '\$ ${groceryList[index]['price'].toString()}',
                          style:
                              const TextStyle(fontSize: 20, color: Colors.grey),
                        ),
                        cartItems.contains(index)
                            ? ElevatedButton(
                                onPressed: () {
                                  ref.read(cartProvider.notifier).remove(index);
                                },
                                child: const Text('Remove Item'),
                              )
                            : ElevatedButton(
                                onPressed: () {
                                  ref.read(cartProvider.notifier).add(index);
                                },
                                child: const Text('Add Item to cart'),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_state_management_app/cart/ui/MyCart.dart';
import 'package:my_state_management_app/catalog/view_model/CatalogViewModel.dart';

import '../../utils/state_manager.dart';
import '../model/CatalogModel.dart';

class MyCatalog extends StatefulWidget {
  const MyCatalog({super.key});

  @override
  State<MyCatalog> createState() => _MyCatalogState();
}

class _MyCatalogState extends State<MyCatalog> {
  CatalogViewModel catalogViewModel = CatalogViewModel();
  final itemColors = <int, Color>{};
  @override
  void initState() {
    super.initState();
    catalogViewModel.loadData(context).then((data) {
      context.setState('LoadDataMyCatalog', data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff235595),
        title: const Text(
          'Catalog',
          style: TextStyle(
              color: Colors.white, fontSize: 36, fontWeight: FontWeight.normal),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyCart()),
                );
              },
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.white,
                size: 40,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: StateBuilder(
          stateManager: context.stateManager,
          builder: (context, state) {
            final myData = context.state
                .getState<List<CatalogModel>>('LoadDataMyCatalog', defaultValue: null);
            if (myData != null) {
              final random = Random();
              return ListView.builder(
                  itemCount: myData.length,
                  itemBuilder: (context, index) {
                    var element = myData[index];
                    Color color;
                    if (itemColors.containsKey(index)) {
                      color = itemColors[index]!;
                    } else {
                      color = Color.fromRGBO(
                        random.nextInt(256),
                        random.nextInt(256),
                        random.nextInt(256),
                        1,
                      );
                      itemColors[index] = color;
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        children: [
                          Container(height: 50, width: 50, color: color),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Name: ${element.title}'),
                                  Text('Price: ${element.price}đ'),
                                ],
                              ),
                            ),
                          ),
                          !(element.isAddCard!)
                              ? TextButton(
                                  onPressed: () {
                                    element.isAddCard = true;
                                    context.setState('LoadDataMyCatalog', myData);
                                  },
                                  child: const Text('Add'))
                              : const Icon(Icons.check)
                        ],
                      ),
                    );
                  });
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    context.setState('LoadDataMyCatalog', null);
    super.dispose();
  }
}

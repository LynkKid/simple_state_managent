import 'dart:math';

import 'package:flutter/material.dart';

import '../../catalog/model/CatalogModel.dart';
import '../../utils/state_manager.dart';

class MyCart extends StatefulWidget {
  const MyCart({super.key});

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  final itemColors = <int, Color>{};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff235595),
        leading: const BackButton(
          color: Colors.white,
        ),
        title: const Text(
          'Cart',
          style: TextStyle(
              color: Colors.white, fontSize: 36, fontWeight: FontWeight.normal),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: StateBuilder(
                stateManager: context.stateManager,
                builder: (context, state) {
                  final myData = context.state.getState<List<CatalogModel>>(
                      'LoadDataMyCatalog',
                      defaultValue: null);
                  if (myData != null) {
                    final random = Random();
                    var myDataCart = myData
                        .where((_element) => _element.isAddCard!)
                        .toList();
                    return ListView.builder(
                        itemCount: myDataCart.length,
                        itemBuilder: (context, index) {
                          var element = myDataCart[index];
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Name: ${element.title}'),
                                        Text('Price: ${element.price}đ'),
                                      ],
                                    ),
                                  ),
                                ),
                                TextButton(
                                    onPressed: () {
                                      myData
                                          .where((_element) =>
                                              _element.id == element.id)
                                          .first
                                          .isAddCard = false;
                                      context.setState(
                                          'LoadDataMyCatalog', myData);
                                    },
                                    child: const Text('Remove'))
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
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 20),
              child: TextButton(
                  onPressed: () {},
                  child: Container(
                      height: 50,
                      width: 200,
                      color: const Color(0xff235595),
                      child: const Center(
                        child: Text(
                          'BUY',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ))),
            )
          ],
        ),
      ),
    );
  }
}

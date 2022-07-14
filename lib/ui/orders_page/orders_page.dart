import 'package:flutter/material.dart';
import 'package:grocery_store/providers/orders_provider.dart';
import 'package:grocery_store/ui/orders_page/widgets/order_item.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({Key? key}) : super(key: key);

  static String routeName = "/orders-page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Center(child: Text("Your recent orders")),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.circle,
                  color: Colors.transparent,
                )),
          )
        ],
      ),
      body: FutureBuilder(
          future:
              Provider.of<OrdersProvider>(context, listen: false).getOrders(),
          builder: (context, snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                          baseColor: Colors.white,
                          highlightColor: Colors.grey,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            height: 70,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                          ));
                    })
                : Consumer<OrdersProvider>(builder: (context, orders, _) {
                    return orders.orders.isEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/empty.png'),
                              const Text(
                                'Empty',
                                style: TextStyle(
                                  fontSize: 25,
                                ),
                              )
                            ],
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 10,
                            ),
                            itemCount: orders.orders.length,
                            itemBuilder: (context, index) {
                              final orderItem = orders.orders[index];
                              return OrderWidget(
                                  amount: orderItem.amount,
                                  dateTime: orderItem.dateTime,
                                  products: orderItem.products);
                            });
                  });
          }),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:grocery_store/app_constants/app_constants.dart';
import 'package:grocery_store/providers/favourites_provider.dart';
import 'package:grocery_store/ui/product_detail/product_detail.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({Key? key}) : super(key: key);

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final favs = Provider.of<FavouritesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Center(child: Text('Favourites')),
      ),
      body: Stack(
        children: [
          favs.list.isEmpty
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
              :ListView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 5
            ),
            physics: const BouncingScrollPhysics(),
            itemCount: favs.list.length,
              itemBuilder: (context, index){
              final item = favs.list[index];
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, ProductDetailScreen.routeName, arguments: item);
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CachedNetworkImage(
                                errorWidget: (context, url, error) => Image.asset('assets/images/holder.jpg'),
                                imageUrl: item.imageUrl,
                                height: 60,
                                width: 60,
                              ),
                            ),
                            const SizedBox(width: 15,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  "${item.measure}, Price",
                                  style: const TextStyle(color: Colors.black54),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "\$${(item.price).toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 17,
                            ),
                          ),
                          SizedBox(width: 20,),
                          GestureDetector(onTap: (){
                            favs.deleteProduct(index);
                          }, child: Icon(Icons.delete_outline,))
                        ],
                      ),
                    ],
                  ),
                  const Divider(color: Colors.grey, thickness: 1, height: 5,)
                ],
              );
              }
          ),
          const Divider(color: Colors.grey, thickness: 1, height: 5,)
        ],
      ),
    );
  }
}

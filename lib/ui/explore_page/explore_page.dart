import 'package:flutter/material.dart';
import 'package:grocery_store/models/category_model.dart';
import 'package:grocery_store/models/gridpage_model.dart';
import 'package:grocery_store/providers/category_provider.dart';
import 'package:grocery_store/ui/explore_page/widgets/category_item.dart';
import 'package:grocery_store/ui/explore_page/widgets/category_shimmer.dart';
import 'package:grocery_store/ui/gridview_page/gridview_page.dart';
import 'package:grocery_store/ui/product_detail/product_detail.dart';
import 'package:provider/provider.dart';

import '../../app_constants/app_colors.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  bool _error = false;
  bool _isLoading = true;
  bool _isTyping = false;

  TextEditingController _searchText = TextEditingController();

  @override
  void initState() {
    Future.delayed(
      Duration.zero,
    ).then((value) async {
      await Provider.of<CategoryProvider>(context, listen: false)
          .getCategories();
      setState(() {
        _isLoading = false;
      });
    }).catchError((error){
      setState(() {
        _error = true;
        _isLoading = false;
      });
    });
    _searchText.addListener(() {
      setState(() {
        _isTyping = true;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _searchText.removeListener(() {
      setState(() {
        _isTyping = false;
      });
    });
    _searchText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prod = Provider.of<CategoryProvider>(context);

    Color _borderColor(int index) {
      if (index == 1 || index % 7 == 0) {
        return AppColors.mainGreen;
      } else if (index % 6 == 0 || index % 12 == 0) {
        return AppColors.mainBlue;
      } else if (index % 5 == 0 || index % 11 == 0) {
        return AppColors.mainYellow;
      } else if (index % 4 == 0 || index % 10 == 0) {
        return AppColors.mainPink;
      } else if (index % 3 == 0 || index % 9 == 0) {
        return AppColors.mainPurple;
      } else if (index == 2 || index % 8 == 0) {
        return AppColors.mainOrange;
      } else {
        return AppColors.mainGreen;
      }
    }

    Color _boxColor(int index) {
      if (index == 1 || index % 7 == 0) {
        return AppColors.transparentGreen;
      } else if (index % 4 == 0 || index % 10 == 0) {
        return AppColors.transparentPink;
      } else if (index % 5 == 0 || index % 11 == 0) {
        return AppColors.transparentYellow;
      } else if (index % 6 == 0 || index % 12 == 0) {
        return AppColors.transparentBlue;
      } else if (index == 2 || index % 8 == 0) {
        return AppColors.transparentOrange;
      } else if (index % 3 == 0 || index % 9 == 0) {
        return AppColors.transparentPurple;
      } else {
        return AppColors.transparentGreen;
      }
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text(
            "Find Products",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: _error
          ? Center(
        child: Text('Something went wrong!'),
      )
          :Stack(
        children: [
          _isLoading
              ? GridView.builder(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 70,
                    bottom: 20,
                  ),
                  physics: const BouncingScrollPhysics(),
                  itemCount: 6,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    mainAxisExtent: 195,
                  ),
                  itemBuilder: (context, index) {
                    return CategoryShimmer(
                        backgroundColor: _boxColor(index + 1));
                  })
              : GridView.builder(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 70,
                    bottom: 20,
                  ),
                  physics: const BouncingScrollPhysics(),
                  itemCount: prod.categories.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    mainAxisExtent: 195,
                  ),
                  itemBuilder: (context, index) {
                    final CategoryModel product = prod.categories[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, GridviewPage.routeName,
                            arguments: GridPageModel(
                                title: product.title,
                                products: product.products));
                      },
                      child: CategoryItem(
                        imageUrl: product.imageUrl,
                        title: product.title,
                        borderColor: _borderColor(index + 1),
                        backgroundColor: _boxColor(index + 1),
                      ),
                    );
                  },
                ),
          if(_isTyping)
          ListView.builder(
            padding: const EdgeInsets.only(
              top: 60,
              left: 20,
              right: 20,
              // bottom: 10,
            ),
              itemCount: prod.searchedProducts.length,
              itemBuilder: (context, index) {
                final item = prod.searchedProducts[index];
                return Container(
                  padding: const EdgeInsets.only(top: 5, bottom: 5,),
                  color: Colors.white,
                  child: ListTile(
                    onTap: (){
                      Navigator.pushNamed(context, ProductDetailScreen.routeName, arguments: item);
                    },
                    leading: Image.network(item.imageUrl, height: 50, width: 50,),
                    title: Text(
                        item.title,
                        style: const TextStyle(
                      fontSize: 20,
                    )),
                    trailing: const Icon(Icons.call_made, size: 20,),
                  ),
                );
              }),
          Container(
            color: Colors.white,
            height: 60,
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
            child: TextField(
              keyboardType: TextInputType.text,
              controller: _searchText,
              onTap: () => prod.addProduct(),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none),
                filled: true,
                fillColor: AppColors.searchBarColor,
                hintText: "Search Store",
                suffixIcon: _isTyping
                    ? IconButton(
                        onPressed: () {
                          prod.emptyList();
                          _searchText.clear();
                          _isTyping = false;
                        },
                        icon: const Icon(Icons.clear))
                    : const Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
              ),
              cursorColor: Colors.black,
              // onEditingComplete: () {
              //   prod.searchProducts(_searchText.text);
              // },
              onSubmitted: (value) {
                prod.searchProducts(value);
              },
              textInputAction: TextInputAction.done,
              // onSubmitted: (){},
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:grocery_store/app_constants/app_colors.dart';
import 'package:grocery_store/providers/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class BannerItem extends StatefulWidget {
  const BannerItem({
    Key? key,
  }) : super(key: key);

  @override
  State<BannerItem> createState() => _BannerItemState();
}

class _BannerItemState extends State<BannerItem> {
  PageController pageController = PageController(viewportFraction: 1.0);
  double _pageIndex = 0;
  bool isLoading = true;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) async {
      await Provider.of<HomeProvider>(context, listen: false).fetchBanners();
      setState(() {
        isLoading = false;
      });
    }).catchError((error) => {
      setState((){
        isLoading = false;
      }),
    });
    pageController.addListener(() {
      setState(() {
        _pageIndex = pageController.page!;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final banners = Provider.of<HomeProvider>(context).banners;
    final length = banners.length;
    return isLoading
        ? Container(
            margin: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            height: 100,
            child: Shimmer.fromColors(
                baseColor: Colors.white60,
                highlightColor: AppColors.transparentGreen,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  height: 100,
                )),
          )
        : Stack(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                height: 100,
                child: PageView.builder(
                    physics: const BouncingScrollPhysics(),
                    controller: pageController,
                    itemCount: length,
                    allowImplicitScrolling: true,
                    padEnds: false,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 100,
                        width: double.maxFinite,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(
                              banners[index],
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }),
              ),
              Container(
                height: 110,
                alignment: Alignment.bottomCenter,
                child: DotsIndicator(
                  dotsCount: length,
                  position: _pageIndex,
                  decorator: DotsDecorator(
                    color: Colors.grey,
                    activeColor: AppColors.mainGreen,
                    size: const Size.square(7.0),
                    activeSize: const Size(18.0, 7.0),
                    activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                ),
              ),
            ],
          );
  }
}

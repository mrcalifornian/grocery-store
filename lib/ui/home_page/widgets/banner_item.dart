import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final home = Provider.of<HomeProvider>(context);
    final banners = home.banners;
    final length = banners.length;
    return home.isLoading
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
              CarouselSlider(
                  items: banners
                      .map((banner) => Builder(builder: (context) {
                            return Container(
                              height: 100,
                              width: double.maxFinite,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl: banner,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          }))
                      .toList(),
                  options: CarouselOptions(
                    height: 100,
                    viewportFraction: 1,
                    autoPlay: true,
                    onPageChanged: (index, A){
                      setState((){
                        _pageIndex = index;
                      });
                    }
                  ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                height: 100,
                alignment: Alignment.bottomCenter,
                child: DotsIndicator(
                  dotsCount: length,
                  position: double.parse("$_pageIndex"),
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

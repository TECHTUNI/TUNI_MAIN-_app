import 'package:flutter/material.dart';
import 'package:tuni/core/model/product_category_model.dart';
import 'package:tuni/presentation/pages/bottom_nav/pages/video_player/video_player.dart';
import 'package:tuni/presentation/pages/combo/combo_refactor.dart';
import '../home_refactor.dart';

class AndroidHome extends StatelessWidget {
  const AndroidHome(
      {super.key,
      required this.screenWidth,
      required this.screenHeight,
      required this.productList});

  final double screenWidth;
  final double screenHeight;
  final List<ProductCategory> productList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            const MainPageSliverAppBar(),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MainPageCarouselSlider(),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    mainPageHeading('Explore'),
                    const SizedBox(
                      width: 0,
                    ),
                    MainPageSeeMoreTextButton(
                      allProductList: productList,
                    )
                  ],
                ),
              ),

              ExploreItemsInHomePage(products: productList),
              const SizedBox(height: 30),
              // VideoPlayerWidget1(
              //   videoUrl:
              //       'https://firebasestorage.googleapis.com/v0/b/tunitest-e022d.appspot.com/o/Combo_videos%2F_1717588086532?alt=media&token=8dcc0bd1-ebc9-460e-a522-d882f12e7c63',
              // ),
              Center(child: mainPageHeading('Filter by CATEGORY')),
              MainPageFilterByCategory(
                  screenWidth: screenWidth, screenHeight: screenHeight),
              const Divider()
            ],
          ),
        ),
      ),
    );
  }
}

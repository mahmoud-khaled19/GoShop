import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/shared_preferences.dart';
import 'package:shop_app/style/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../login screen/shop_login.dart';

class ShopAppBoardingScreen extends StatefulWidget {
  const ShopAppBoardingScreen({Key? key}) : super(key: key);

  @override
  State<ShopAppBoardingScreen> createState() => _ShopAppBoardingScreenState();
}

class _ShopAppBoardingScreenState extends State<ShopAppBoardingScreen> {
  var boardingController = PageController();
  List<BoardingList> modelList = [
    BoardingList( ' Discover a wide range of products, great deals, and hassle-free shopping in one place. Let\'s get started!', 'assets/3.jpg'),
    BoardingList('We have designed this app to make your shopping experience seamless, fast and easy. Get started now!', 'assets/2.jpg'),
    BoardingList('With our secure checkout, tracking system, and easy returns, you can shop with confidence. Explore our store now!', 'assets/1.jpg'),
  ];
  bool isLast = false;
 void submit(){
   CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
        navigateAndFinish(context, const ShopAppLoginScreen());
        if (kDebugMode) {
          print('onBoarding saved Successfully');
        }
   });
 }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
             Row(
               children: [
                 Text('KOoOTa SHOP',style: Theme.of(context).textTheme.headline5?.copyWith(
                   color: darkPrimaryColor
                 )),
                 const Spacer(),
                 defaultTextButton(
                     function: submit, text: 'Skip'),
               ],
             ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: PageView.builder(
                  onPageChanged: (value) {
                    if (value == modelList.length - 1) {
                      isLast = true;
                    } else {
                      isLast = false;
                    }
                  },
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) =>
                      pageViewItem(modelList[index]),
                  controller: boardingController,
                  itemCount: modelList.length,
                ),
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                      effect:  ExpandingDotsEffect(
                        activeDotColor: darkPrimaryColor,
                        dotWidth: 26.0,
                        dotHeight: 15.0,
                      ),
                      controller: boardingController,
                      count: modelList.length),
                  const Spacer(),
                  FloatingActionButton(
                    backgroundColor: darkPrimaryColor,
                    onPressed: () {
                      if (isLast) {
                        submit();
                      } else {
                        boardingController.nextPage(
                            duration: const Duration(milliseconds: 2000),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
                    child: const Icon(Icons.arrow_forward),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget pageViewItem(BoardingList model) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Image(image: AssetImage(model.image))),
        const SizedBox(
          height: 20,
        ),

        Text(model.body),
        const SizedBox(
          height: 50,
        ),
      ],
    );

class BoardingList {
  late final String body;
  late final String image;

  BoardingList( this.body, this.image);
}

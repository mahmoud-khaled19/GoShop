import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/shared_preferences.dart';
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
    BoardingList('First Screen', 'First Body', 'assets/img.png'),
    BoardingList('Second Screen', 'Second Body', 'assets/img.png'),
    BoardingList('Third Screen', 'Third Body', 'assets/img.png'),
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
                   color: Colors.blue,fontWeight: FontWeight.w700
                 )),
                 const Spacer(),
                 defaultTextButton(
                     function: submit, text: 'Skip'),
               ],
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
                      effect: const ExpandingDotsEffect(
                        activeDotColor: Colors.blue,
                        dotWidth: 26.0,
                        dotHeight: 15.0,
                      ),
                      controller: boardingController,
                      count: modelList.length),
                  const Spacer(),
                  FloatingActionButton(
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
        Text(model.title),
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
  late final String title;
  late final String body;
  late final String image;

  BoardingList(this.title, this.body, this.image);
}

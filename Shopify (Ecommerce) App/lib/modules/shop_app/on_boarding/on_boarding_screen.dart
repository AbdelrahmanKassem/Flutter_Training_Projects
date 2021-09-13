import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/modules/shop_app/login/shop_login_screen.dart';
import 'package:my_first_app/shared/components/components.dart';
import 'package:my_first_app/shared/network/local/cache_helper.dart';
import 'package:my_first_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel
{
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
});
}

class OnBoardingScreen extends StatefulWidget {

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding =[
    BoardingModel(
        image: 'assets/images/on_board_1.jpg',
        title: 'Screen Title 1',
        body: 'Screen Body 1',
    ),
    BoardingModel(
      image: 'assets/images/on_board_1.jpg',
      title: 'Screen Title 2',
      body: 'Screen Body 2',
    ),
    BoardingModel(
      image: 'assets/images/on_board_1.jpg',
      title: 'Screen Title 3',
      body: 'Screen Body 3',
    ),
  ];

  var boardController = PageController();

  bool isLastBoardingPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: (){
                navigateAndFinish(context, ShopLoginScreen());
              },
              child: Text(
                'SKIP',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  fontSize: 18,
                ),
              ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (index){
                  if(index == boarding.length-1)
                    {
                      setState(() {
                        isLastBoardingPage = true;
                      });
                    }
                  else
                    {
                      setState(() {
                        isLastBoardingPage = false;
                      });
                    }
                },
                physics: BouncingScrollPhysics(),
                controller: boardController,
                itemBuilder: (context,index) => buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  effect: ExpandingDotsEffect(
                    activeDotColor: defaultColor,
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    dotWidth: 10,
                    expansionFactor: 4,
                    spacing: 5,
                  ),
                  controller: boardController,
                  count: boarding.length,
                ),
                Spacer(),
                FloatingActionButton(
                    onPressed: (){
                      if(isLastBoardingPage)
                        {
                          navigateAndFinish(context, ShopLoginScreen());
                        }
                      else
                        {
                          boardController.nextPage(
                            duration: Duration(
                              milliseconds: 750,
                            ),
                            curve: Curves.fastLinearToSlowEaseIn,
                          );
                        }
                    },
                    child: Icon(
                      isLastBoardingPage ? Icons.done : Icons.arrow_forward_ios,
                    ),
                    ),
              ],
            ),
          ],
        ),
      ),


    );
  }

  void submit()
  {
    CacheHelper.setData(key: 'BoardingDoneFlag', value: true,);
    navigateAndFinish(context, ShopLoginScreen());
  }

  Widget buildBoardingItem(BoardingModel boarding) => Column(
    children: [
      Expanded(
        child: Image(
          image: AssetImage('${boarding.image}'),
        ),
      ),
      SizedBox(
        height: 20,
      ),
      Text(
        '${boarding.title}',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
        ),
      ),
      SizedBox(
        height: 15,
      ),
      Text(
        '${boarding.body}',
        style: TextStyle(
          fontSize: 15,
        ),
      ),
    ],
  );
}

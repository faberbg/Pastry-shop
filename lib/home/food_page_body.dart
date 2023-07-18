import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poslasticarnica/utils/dimensions.dart';
import 'package:poslasticarnica/widgets/big_text.dart';
import 'package:poslasticarnica/widgets/small_text.dart';

import '../widgets/icon_and_text_widget.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  _FoodPageBodyState createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue=0.0;
  double _scaleFactor=0.8; //procent of original size, when container is on the side of main container
  double _height=Dimensions.pageViewContainer;
  @override
  void initState(){
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue=pageController.page!;
        //print("Current value is: "+_currPageValue.toString()); //checking page number
      });
    });
  }
  @override
  void dispose(){
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //slider section
        Container(
            height: Dimensions.pageView,
            //  color: Color(0xFFFF0000),  // test background color so i can see the surface of Container
            child: PageView.builder(
                controller: pageController,
                itemCount: 5,
                itemBuilder: (context, position){
                  return _buildPageItem(position);
                })
        ),
        //dots
        new DotsIndicator(
          dotsCount: 5,
          position: _currPageValue,
          decorator: DotsDecorator(
          size: const Size.square(9.0),
          activeSize: const Size(18.0, 9.0),
          activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          ),
        ),
        //Popular text
        SizedBox(height: Dimensions.height30,),
        Container(
          margin: EdgeInsets.only(left: Dimensions.height30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Popular"),
              SizedBox(width: Dimensions.height10,),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(text: ".", color:Colors.black26),
              ),
              SizedBox(width: Dimensions.height10,),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
               child: SmallText(text: "Food pairing",) ,
              )
            ],
          ),
        ),
        //List of food and images

        ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder:(context,index){
                return Container(
                  margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20,bottom: Dimensions.height10),
                  child: Row(
                    children: [
                    //image section
                      Container(
                        width:Dimensions.listViewImgSize,
                        height: Dimensions.listViewImgSize,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.radius20),
                            color: Colors.white38,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                                image: AssetImage(
                                    "assets/image/food1.jpg"
                                )
                            )
                        ),
                      ),
                      //text container
                      Expanded(
                        child: Container(
                          height:Dimensions.listViewTextContSize,
                          
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(Dimensions.radius20),
                              bottomRight: Radius.circular(Dimensions.radius20)
                            ),
                            color: Colors.white,

                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                BigText(text: "Nutritious fruit meal in China"),
                                SizedBox(height: Dimensions.height10,),
                                SmallText(text: "With chanese characteristics"),
                                SizedBox(height: Dimensions.height10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconAndTextWidget(icon: Icons.circle_sharp,text: "Normal",iconColor: Color(0xFFFFA500),),
                                    IconAndTextWidget(icon: Icons.location_on,text: "1.7km",iconColor: Colors.blue,),
                                    IconAndTextWidget(icon: Icons.access_time_rounded,text: "32min",iconColor: Colors.red,)
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              } ),

      ],
    );
  }
  Widget _buildPageItem(int index){
    Matrix4 matrix = new Matrix4.identity();
    if(index==_currPageValue.floor()){ //center
      var currScale = 1-(_currPageValue-index)*(1-_scaleFactor);
      var currTrans =_height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);

    }else if(index == _currPageValue.floor()+1){//right
      var currScale = _scaleFactor+(_currPageValue-index+1)*(1-_scaleFactor);
      var currTrans =_height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }else if(index == _currPageValue.floor()-1){//left
      var currScale = 1-(_currPageValue-index)*(1-_scaleFactor);
      var currTrans =_height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }else{//third one
      var currScale=0.8;
      var currTrans =_height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          Container(
            height: Dimensions.pageViewContainer,
            margin: EdgeInsets.only(left:Dimensions.width10,right: Dimensions.width10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color:  index.isEven?Color(0xFF69c5df):Color(0xFF9294cc),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                        "assets/image/food1.jpg"
                    )
                )
            ),
          ),
          Align(//with what ever we use Align it will place that container inside of parent one in the middle
              alignment: Alignment.bottomCenter,
              child: Container(
                  height: Dimensions.pageViewTextContainer,
                  margin: EdgeInsets.only(left:Dimensions.width30,right: Dimensions.width30, bottom: Dimensions.height30),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color:  Color(0xFFFFFFFF),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5.0,
                          offset: Offset(0,5)
                        ),
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(-5,0)
                        ),
                        BoxShadow(
                            color: Colors.white,
                            offset: Offset(5,0)
                        )
                      ]

                  ),
                child: Container(
                  padding: EdgeInsets.only(top:Dimensions.height15,left: Dimensions.width15,right: Dimensions.width15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(text: "Chinese Side"),
                      SizedBox(height: Dimensions.height10,),
                      Row(
                        children: [
                          Wrap(
                            children: List.generate(5, (index) {
                              return Icon(Icons.star, color: Color(0xFFFFD700), size: 15,);
                            }),
                          ),
                          SizedBox(width: 10,),
                          SmallText(text: "4.5"),
                          SizedBox(width: 10,),
                          SmallText(text: "1287"),
                          SizedBox(width: 10,),
                          SmallText(text: "comments")
                        ],
                      ),
                      SizedBox(height: Dimensions.height20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconAndTextWidget(icon: Icons.circle_sharp,text: "Normal",iconColor: Color(0xFFFFA500),),
                          IconAndTextWidget(icon: Icons.location_on,text: "1.7km",iconColor: Colors.blue,),
                          IconAndTextWidget(icon: Icons.access_time_rounded,text: "32min",iconColor: Colors.red,)
                        ],
                      )
                    ],
                  ),
                ),
                )
          )
        ],
      ),
    );
  }
}

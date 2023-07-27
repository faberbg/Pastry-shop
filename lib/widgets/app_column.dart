import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poslasticarnica/utils/dimensions.dart';
import 'package:poslasticarnica/widgets/big_text.dart';
import 'package:poslasticarnica/widgets/icon_and_text_widget.dart';
import 'package:poslasticarnica/widgets/small_text.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top:Dimensions.height15,left: Dimensions.width15,right: Dimensions.width15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BigText(text: text,size: Dimensions.font26),
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
    );
  }
}

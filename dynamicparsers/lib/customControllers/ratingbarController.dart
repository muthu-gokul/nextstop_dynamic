import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'callBack/myCallback.dart';

class RatingBarController extends StatelessWidget implements MyCallback2{
  Map map;
  MyCallback myCallback;
  RatingBarController({required this.map, required this.myCallback});

  var ratingOutput=(3.0).obs;

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating:map.containsKey("initialRating")?map['initialRating']: 3,
      minRating: map.containsKey("minRating")?map['minRating']: 1,
      direction: Axis.horizontal,
      allowHalfRating: map.containsKey("allowHalfRating")?map['allowHalfRating']:false,
      itemCount: 5,
      updateOnDrag: map.containsKey("updateOnDrag")?map['updateOnDrag']:false,
      tapOnlyMode: map.containsKey("tapOnlyMode")?map['tapOnlyMode']:false,
      glow: map.containsKey("glow")?map['glow']:false,

      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        print(rating);
        ratingOutput.value=rating;
      },
    );
  }


  @override
  validate(){
    return true;
  }

  @override
  getValue(){
    return ratingOutput.value;
  }

  @override
  getType() {
    return map['type'];
  }
}

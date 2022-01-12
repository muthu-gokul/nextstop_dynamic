import 'package:flutter/material.dart';

class NavIcon extends StatelessWidget {
  VoidCallback ontap;
  NavIcon({required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 50,
        width: 40,
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 1.8,
              width: 26,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white
              ),
            ),
            SizedBox(height: 4,),
            Container(
              height: 1.7,
              width: 15,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white
              ),
            ),
            SizedBox(height: 4,),
            Container(
              height: 1.8,
              width: 15,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white
              ),
            ),
          ],
        ),
      ),
    );
  }
}

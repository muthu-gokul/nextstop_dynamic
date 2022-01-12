import 'package:flutter/material.dart';
import 'package:nextstop_dynamic/styles/style.dart';


import 'gridContents.dart';

class GridWithWidgetParam2 extends StatefulWidget {
  double headerHeight;
  double headerWidth;
  Widget headerWidget;
  double bodyHeight;
  double bodyWidth;
  Widget bodyWidget;
/*  bool showDeleteAll;
  VoidCallback addBtnTap;
  Function(String) searchFunc;
  Function(int) filterOnTap;*/
 // List<GridHeaderModel> gridHeaderList;
/*  bool showAdd;
  bool showFilter;
  bool showExport;
  bool showSearchAll;
  Color searchBg;*/

  GridWithWidgetParam2({required this.headerHeight,required this.headerWidth,required this.headerWidget,
    required this.bodyHeight,required this.bodyWidth,required this.bodyWidget,
    //required this.gridHeaderList,
   /* required this.addBtnTap,required this.searchFunc,this.showDeleteAll=false,required this.filterOnTap,
    this.showAdd=false,this.searchBg=Colors.white,this.showExport=true,this.showFilter=true,this.showSearchAll=true*/
  });

  @override
  _GridWithWidgetParam2State createState() => _GridWithWidgetParam2State();
}

class _GridWithWidgetParam2State extends State<GridWithWidgetParam2> {

  ScrollController header=new ScrollController();
  ScrollController body=new ScrollController();

  bool showPopUp=false;

  @override
  void initState() {
    header.addListener(() {
      if(body.offset!=header.offset){
        body.jumpTo(header.offset);
      }
    });
    body.addListener(() {
      if(header.offset!=body.offset){
        header.jumpTo(body.offset);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        Container(
          height: widget.headerHeight,
          width: widget.headerWidth,
         /// margin: EdgeInsets.only(top: widget.showSearchAll?widget.headerHeight:0),
          margin: EdgeInsets.only(top: 0),
          alignment: Alignment.topCenter,
          child:Theme(
            data: glowFunTransparent(context),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: header,
              child: widget.headerWidget,
            ),
          ),
        ),
        Container(
          height: widget.bodyHeight,
          width: widget.bodyWidth,
         // margin: EdgeInsets.only(top: widget.showSearchAll?widget.headerHeight*2.0:widget.headerHeight),
          margin: EdgeInsets.only(top: widget.headerHeight),
          alignment: Alignment.topCenter,
          child: Theme(
            data: glowFunTransparent(context),
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: body,
                child: Theme(
                  data: glowFunTransparent(context),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: widget.bodyWidget,
                  ),
                )
            ),
          ),
        ),

/*        AnimatedPositioned(
          duration: animeDuration,
          curve: animeCurve,
          right: widget.showDeleteAll?0:-100,
          top: (widget.bodyHeight*0.5).toDouble(),
          child: Container(
            height: 50,
            width: 100,
            decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(25),bottomLeft: Radius.circular(25))
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset('assets/icons/delete.svg',height: 25,color: Colors.white,),
          ),
        ),
        GestureDetector(
          onTap: (){
            setState(() {
              showPopUp=false;
            });
          },
          child: Container(
              height:showPopUp? widget.bodyHeight+(widget.headerHeight*2.0):0,
              width: widget.bodyWidth,
              color: Colors.transparent
          ),
        )*/
      ],
    );
  }
}


//Grid Constants
double headerHeight=50;
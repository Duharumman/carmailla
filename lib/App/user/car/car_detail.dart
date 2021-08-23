import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yellow_carmailla/App/Home/pages.dart/nav_drawer.dart';
import 'package:yellow_carmailla/App/models/animation_item.dart';
import 'package:yellow_carmailla/App/user/widgets/fade_slide.dart';
import 'package:yellow_carmailla/App/user/widgets/scale_animation.dart';

bool toggleValue = false;
bool toggleValue1 = false;
bool toggleValue2 = false;
bool toggleValue3 = false;
bool toggleValue4 = false;
bool toggleValue5 = false;

class CarDetail extends StatefulWidget {
  @override
  _CarDetailState createState() => _CarDetailState();
}

List<Map> colors = [
  {
    "name": "black",
    "color": Colors.black,
    "asset": "assets/carbig-black.png",
  },
  {
    "name": "green",
    "color": Colors.green,
    "asset": "assets/carbig-green.png",
  },
  {
    "name": "grey",
    "color": Colors.grey,
    "asset": "assets/carbig-grey.png",
  },
  {
    "name": "purple",
    "color": Colors.purple,
    "asset": "assets/carbig-purple.png",
  },
  {
    "name": "red",
    "color": Colors.red,
    "asset": "assets/carbig.png",
  },
];

class _CarDetailState extends State<CarDetail>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;
  List<AnimationItem> animationItems = [];

  int selectedIndex = 0;
  // setup animations
  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 700));
    for (int i = 0; i < 10; i++) {
      animationItems.add(
        AnimationItem(
          id: "slide-${i + 1}",
          entry: 30 * (i + 1),
          entryDuration: 250,
          visible: false,
        ),
      );
    }
    animation = Tween<double>(begin: 0, end: 300).animate(animationController)
      ..addListener(() {
        setState(() {
          animationItems = updateVisibleState(
            animationItems,
            animation.value,
          );
        });
      });

    animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        brightness: Brightness.light,
        title: Text(
          "CARMIALLA",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        centerTitle: true,
        // actions: [
        //   Padding(
        //     padding: EdgeInsets.only(right: 16),
        //     child: IconButton(
        //       icon: Icon(Icons.menu),
        //       color: Colors.black,
        //       onPressed: () {},
        //     ),
        //   )
        // ],
      ),
      drawer: NavDrawer(),
      backgroundColor: Color(
        0XFFF4F4FF,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: kToolbarHeight,
                      ),
                      FadeSlide(
                        direction: getItemVisibility("slide-2", animationItems),
                        duration: getSlideDuration("slide-2", animationItems),
                        offsetY: 60.0,
                        offsetX: 0.0,
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "BMW 8 Series Coupe\n",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22.0,
                                  color: Color(0xFF333333),
                                ),
                              ),
                              TextSpan(
                                text: "Starts from \$201,967",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  height: 1.7,
                                  fontSize: 20.0,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   height: 30.0,
                      // ),
                      Expanded(
                        // Lets create a list of all car image colors
                        child: AnimatedSwitcher(
                          // This switcher doesnt work, flutter cant
                          // understand the child change without a key property here
                          // I will include a link to a video talking more about keys
                          duration: Duration(milliseconds: 500),
                          child: ScaleAnimation(
                            key: ValueKey(colors[selectedIndex]["asset"]),
                            duration:
                                getSlideDuration("slide-3", animationItems),
                            child: Align(
                              alignment: Alignment.center,
                              child: Image.asset(
                                colors[selectedIndex]["asset"],
                              ),
                            ),
                            direction:
                                getItemVisibility("slide-3", animationItems),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: FadeSlide(
                  duration: getSlideDuration("slide-4", animationItems),
                  direction: getItemVisibility("slide-4", animationItems),
                  offsetX: 0.0,
                  offsetY: 60.0,
                  child: Container(
                    height: 360.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50.0),
                        topRight: Radius.circular(50.0),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 32.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            // _getTabItem("Inspire", true),
                            // SizedBox(
                            //   width: 15.0,
                            // ),
                            _getTabItem("Inform", true),
                            SizedBox(
                              width: 15.0,
                            ),
                            _getTabItem("Additional Data", true),
                          ],
                        ),
                        SizedBox(
                          height: 11.0,
                        ),
                        Text(
                          "Hello there, thank you for coming here, please dont forget to subscribe and like this video if you learnt something from it",
                          style: TextStyle(
                            height: 1.5,
                            fontSize: 16.0,
                            color: Colors.black.withOpacity(.5),
                          ),
                        ),
                        SizedBox(height: 15.0),
                        Divider(),
                        SizedBox(height: 15.0),
                        new Column(
                          children: [
                            new Row(
                              children: [
                                Container(
                                  child: new Text('GPS 12\$'),
                                )
                              ],
                            ),
                            new Row(children: [
                              Container(
                                child: AnimatedContainer(
                                  duration: Duration(microseconds: 100),
                                  height: 30.0,
                                  width: 100.0,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      color: toggleValue1
                                          ? Colors.greenAccent[100]
                                          : Colors.redAccent[100]
                                              .withOpacity(0.5)),
                                  child: Stack(
                                    children: <Widget>[
                                      AnimatedPositioned(
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.easeIn,
                                        top: 3.0,
                                        left: toggleValue1 ? 60.0 : 0.0,
                                        right: toggleValue1 ? 0.0 : 60.0,
                                        child: InkWell(
                                          onTap: toggleButton1,
                                          child: AnimatedSwitcher(
                                            duration:
                                                Duration(milliseconds: 1000),
                                            transitionBuilder: (Widget child,
                                                Animation<double> animation) {
                                              return RotationTransition(
                                                child: child,
                                                turns: animation,
                                              );
                                            },
                                            child: toggleValue1
                                                ? Icon(Icons.check_circle,
                                                    color: Colors.green,
                                                    size: 25.0,
                                                    key: UniqueKey())
                                                : Icon(
                                                    Icons.remove_circle_outline,
                                                    color: Colors.red,
                                                    size: 25.0,
                                                    key: UniqueKey()),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ])
                          ],
                        ),
                        new Column(
                          children: [
                            new Row(
                              children: [
                                Container(
                                  child: new Text('Child seat 12\$'),
                                )
                              ],
                            ),
                            new Row(children: [
                              Container(
                                child: AnimatedContainer(
                                  duration: Duration(microseconds: 100),
                                  height: 30.0,
                                  width: 100.0,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      color: toggleValue2
                                          ? Colors.greenAccent[100]
                                          : Colors.redAccent[100]
                                              .withOpacity(0.5)),
                                  child: Stack(
                                    children: <Widget>[
                                      AnimatedPositioned(
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.easeIn,
                                        top: 3.0,
                                        left: toggleValue2 ? 60.0 : 0.0,
                                        right: toggleValue2 ? 0.0 : 60.0,
                                        child: InkWell(
                                          onTap: toggleButton2,
                                          child: AnimatedSwitcher(
                                            duration:
                                                Duration(milliseconds: 1000),
                                            transitionBuilder: (Widget child,
                                                Animation<double> animation) {
                                              return RotationTransition(
                                                child: child,
                                                turns: animation,
                                              );
                                            },
                                            child: toggleValue2
                                                ? Icon(Icons.check_circle,
                                                    color: Colors.green,
                                                    size: 25.0,
                                                    key: UniqueKey())
                                                : Icon(
                                                    Icons.remove_circle_outline,
                                                    color: Colors.red,
                                                    size: 25.0,
                                                    key: UniqueKey()),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ])
                          ],
                        ),
                        new Column(
                          children: [
                            new Row(
                              children: [
                                Container(
                                  child: new Text('Children seat 12\$'),
                                )
                              ],
                            ),
                            new Row(children: [
                              Container(
                                child: AnimatedContainer(
                                  duration: Duration(microseconds: 100),
                                  height: 30.0,
                                  width: 100.0,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      color: toggleValue3
                                          ? Colors.greenAccent[100]
                                          : Colors.redAccent[100]
                                              .withOpacity(0.5)),
                                  child: Stack(
                                    children: <Widget>[
                                      AnimatedPositioned(
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.easeIn,
                                        top: 3.0,
                                        left: toggleValue3 ? 60.0 : 0.0,
                                        right: toggleValue3 ? 0.0 : 60.0,
                                        child: InkWell(
                                          onTap: toggleButton3,
                                          child: AnimatedSwitcher(
                                            duration:
                                                Duration(milliseconds: 1000),
                                            transitionBuilder: (Widget child,
                                                Animation<double> animation) {
                                              return RotationTransition(
                                                child: child,
                                                turns: animation,
                                              );
                                            },
                                            child: toggleValue3
                                                ? Icon(Icons.check_circle,
                                                    color: Colors.green,
                                                    size: 25.0,
                                                    key: UniqueKey())
                                                : Icon(
                                                    Icons.remove_circle_outline,
                                                    color: Colors.red,
                                                    size: 25.0,
                                                    key: UniqueKey()),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ])
                          ],
                        ),
                        new Column(
                          children: [
                            new Row(
                              children: [
                                Container(
                                  child: new Text('Flower design 40\$'),
                                )
                              ],
                            ),
                            new Row(children: [
                              Container(
                                child: AnimatedContainer(
                                  duration: Duration(microseconds: 100),
                                  height: 30.0,
                                  width: 100.0,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      color: toggleValue4
                                          ? Colors.greenAccent[100]
                                          : Colors.redAccent[100]
                                              .withOpacity(0.5)),
                                  child: Stack(
                                    children: <Widget>[
                                      AnimatedPositioned(
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.easeIn,
                                        top: 3.0,
                                        left: toggleValue4 ? 60.0 : 0.0,
                                        right: toggleValue4 ? 0.0 : 60.0,
                                        child: InkWell(
                                          onTap: toggleButton4,
                                          child: AnimatedSwitcher(
                                            duration:
                                                Duration(milliseconds: 1000),
                                            transitionBuilder: (Widget child,
                                                Animation<double> animation) {
                                              return RotationTransition(
                                                child: child,
                                                turns: animation,
                                              );
                                            },
                                            child: toggleValue4
                                                ? Icon(Icons.check_circle,
                                                    color: Colors.green,
                                                    size: 25.0,
                                                    key: UniqueKey())
                                                : Icon(
                                                    Icons.remove_circle_outline,
                                                    color: Colors.red,
                                                    size: 25.0,
                                                    key: UniqueKey()),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ])
                          ],
                        ),
                        new Column(
                          children: [
                            new Row(
                              children: [
                                Container(
                                  child: new Text('Driver 20\$ per day '),
                                )
                              ],
                            ),
                            new Row(children: [
                              Container(
                                child: AnimatedContainer(
                                  duration: Duration(microseconds: 100),
                                  height: 30.0,
                                  width: 100.0,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      color: toggleValue
                                          ? Colors.greenAccent[100]
                                          : Colors.redAccent[100]
                                              .withOpacity(0.5)),
                                  child: Stack(
                                    children: <Widget>[
                                      AnimatedPositioned(
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.easeIn,
                                        top: 3.0,
                                        left: toggleValue ? 60.0 : 0.0,
                                        right: toggleValue ? 0.0 : 60.0,
                                        child: InkWell(
                                          onTap: toggleButton,
                                          child: AnimatedSwitcher(
                                            duration:
                                                Duration(milliseconds: 1000),
                                            transitionBuilder: (Widget child,
                                                Animation<double> animation) {
                                              return RotationTransition(
                                                child: child,
                                                turns: animation,
                                              );
                                            },
                                            child: toggleValue
                                                ? Icon(Icons.check_circle,
                                                    color: Colors.green,
                                                    size: 25.0,
                                                    key: UniqueKey())
                                                : Icon(
                                                    Icons.remove_circle_outline,
                                                    color: Colors.red,
                                                    size: 25.0,
                                                    key: UniqueKey()),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ])
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void toggleButton() {
    setState(() {
      toggleValue = !toggleValue;
    });
  }

  void toggleButton1() {
    setState(() {
      toggleValue1 = !toggleValue1;
    });
  }

  void toggleButton2() {
    setState(() {
      toggleValue2 = !toggleValue2;
    });
  }

  void toggleButton3() {
    setState(() {
      toggleValue3 = !toggleValue3;
    });
  }

  void toggleButton4() {
    setState(() {
      toggleValue4 = !toggleValue4;
    });
  }

  void toggleButton5() {
    setState(() {
      toggleValue5 = !toggleValue5;
    });
  }
}

Widget _getTabItem(String text, bool isActive) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        text,
        style: TextStyle(
          color: isActive ? Color(0xFF333333) : Colors.black.withOpacity(.5),
          fontSize: isActive ? 18.0 : 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      isActive
          ? Container(
              margin: EdgeInsets.only(top: 5.0),
              height: 4.0,
              width: 40.0,
              decoration: BoxDecoration(
                color: isActive ? Colors.transparent : Colors.transparent,
                borderRadius: BorderRadius.circular(10.0),
              ),
            )
          : SizedBox.shrink()
    ],
  );
}

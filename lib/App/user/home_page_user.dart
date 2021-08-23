import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yellow_carmailla/App/Home/pages.dart/nav_drawer.dart';
import 'package:yellow_carmailla/App/models/animation_item.dart';
import 'package:yellow_carmailla/App/sign_in/sign_in_button.dart';
import 'package:yellow_carmailla/App/user/models/car.dart';
import 'package:yellow_carmailla/App/user/widgets/car_modal.dart';
import 'package:yellow_carmailla/App/user/widgets/fade_slide.dart';
import 'package:yellow_carmailla/App/user/widgets/scale_animation.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

const Y_OFFSET = 60.0;

class _Home extends State<Home> with SingleTickerProviderStateMixin {
  NavigationItem selectedItem;

  PageController pageController;
  double pageScrollValue = 4.0;
  int activePage = 4;

  AnimationController animationController;
  Animation animation;
  List<AnimationItem> animationItems = [
    // First text
    AnimationItem(
      id: "slide-1",
      entry: 100,
      entryDuration: 400,
      visible: false,
    ),
    AnimationItem(
      id: "slide-2",
      entry: 150,
      entryDuration: 400,
      visible: false,
    ),
    AnimationItem(
      id: "slide-3",
      entry: 160,
      entryDuration: 400,
      visible: false,
    ),
    AnimationItem(
      id: "slide-4",
      entry: 180,
      entryDuration: 400,
      visible: false,
    ),
    AnimationItem(
      id: "slide-5",
      entry: 200,
      entryDuration: 400,
      visible: false,
    ),
    AnimationItem(
      id: "slide-6",
      entry: 190,
      entryDuration: 400,
      visible: false,
    ),
    AnimationItem(
      id: "slide-7",
      entry: 210,
      entryDuration: 400,
      visible: false,
    ),
  ];
  @override
  void initState() {
    pageController = PageController(
      initialPage: 4,
      // wont take up whole page
      viewportFraction: .55,
    )..addListener(() {
        // Forgot to update state
        setState(() {
          activePage = pageController.page.round();
          pageScrollValue = pageController.page;
        });
      });

    animationController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );

    animation = Tween<double>(begin: 0, end: 210).animate(animationController)
      ..addListener(() {
        // We cant see anything because we are not updating UI
        // and animation state
        setState(() {
          animationItems = updateVisibleState(animationItems, animation.value);
        });
      });
    animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    // clear animations
    animationController.dispose();
    // clear page controller
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        brightness: Brightness.light,
        centerTitle: true,
        title: Text(
          "CARMIALLA",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
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
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 24.0,
          ),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 50.0,
              ),
              FadeSlide(
                direction: getItemVisibility("slide-2", animationItems),
                offsetX: 0.0,
                offsetY: Y_OFFSET,
                duration: getSlideDuration("slide-2", animationItems),
                child: Text(
                  "CHOOSE\nFAVORITE\nBRANDS",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                    height: 1.5,
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              FadeSlide(
                direction: getItemVisibility("slide-3", animationItems),
                offsetX: 0.0,
                offsetY: Y_OFFSET,
                duration: getSlideDuration("slide-3", animationItems),
                child: Text(
                  "Get your best deals",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey[600],
                    height: 1.5,
                  ),
                ),
              ),
              Flexible(
                child: PageView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  controller: pageController,
                  itemBuilder: (BuildContext context, int index) {
                    return Align(
                      alignment: Alignment.center,
                      child: Stack(
                        // We need to animate sizes on scroll here
                        // #1 Entry animation
                        alignment: Alignment.topRight,
                        children: [
                          ScaleAnimation(
                            direction:
                                getItemVisibility("slide-4", animationItems),
                            duration:
                                getSlideDuration("slide-4", animationItems),
                            // Lets now animate scrolling

                            child: AnimatedContainer(
                              padding: EdgeInsets.all(20.0),
                              duration: Duration(milliseconds: 300),
                              height: activePage == index ? 180.0 : 120.0,
                              width: activePage == index ? 180.0 : 120.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).primaryColor,
                              ),
                              child: Transform.scale(
                                scale: max(
                                  .5,
                                  1.0 - (pageScrollValue - index).abs(),
                                ),
                                child: Image.asset(
                                  carLogos[index],
                                ),
                              ),
                            ),
                          ),
                          // Lets delay this
                          Positioned(
                            top: 10.0,
                            right: 10.0,
                            child: ScaleAnimation(
                              duration:
                                  getSlideDuration("slide-6", animationItems),
                              direction:
                                  getItemVisibility("slide-6", animationItems),
                              child: AnimatedSwitcher(
                                duration: Duration(
                                  milliseconds: 150,
                                ),
                                child: index.toDouble() == pageScrollValue
                                    ? Container(
                                        width: 30.0,
                                        height: 30.0,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.green,
                                        ),
                                      )
                                    : SizedBox.shrink(),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: carLogos.length,
                ),
              ),
              FadeSlide(
                direction: getItemVisibility("slide-5", animationItems),
                offsetX: 0.0,
                offsetY: Y_OFFSET,
                duration: getSlideDuration("slide-5", animationItems),
                child: Text(
                  "Swipe left or right to see more",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.grey[600],
                    height: 1.5,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              FadeSlide(
                offsetX: 0.0,
                offsetY: Y_OFFSET,
                duration: getSlideDuration("slide-7", animationItems),
                direction: getItemVisibility("slide-7", animationItems),
                child: Container(
                  width: MediaQuery.of(context).size.width * .7,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  child: SignInButton(
                    onPressed: () {
                      // Show bottom sheet on click
                      showModalBottomSheet(
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50.0),
                            topRight: Radius.circular(50.0),
                          ),
                        ),
                        barrierColor: Colors.black.withOpacity(.8),
                        context: context,
                        builder: (_) {
                          return CarModal();
                        },
                      );
                    },
                    // padding: EdgeInsets.symmetric(vertical: 22.0),
                    color: Theme.of(context).primaryColor,
                    text: 'Continue',
                    textColor: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

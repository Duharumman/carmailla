import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yellow_carmailla/App/Home/pages.dart/nav_drawer.dart';
import 'package:yellow_carmailla/App/user/car/car_detail.dart';
import 'package:yellow_carmailla/App/user/models/animation_item.dart';
import 'package:yellow_carmailla/App/user/widgets/car_modal.dart';
import 'package:yellow_carmailla/App/user/widgets/fade_slide.dart';
import 'package:yellow_carmailla/utils/animation_transition.dart';

class CarsList extends StatefulWidget {
  @override
  _CarsListState createState() => _CarsListState();
}

class _CarsListState extends State<CarsList>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;
  List<AnimationItem> animationItems = [];
  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    // Loop through and create animations

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
          animationItems = updateVisibleState(animationItems, animation.value);
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
        //     child: Icon(
        //       Icons.menu,
        //       color: Colors.black,
        //       size: 28,
        //     ),
        //   )
        // ],
      ),
      drawer: NavDrawer(),
      backgroundColor: Color(0xFFF0EEF6),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SafeArea(
                child: SizedBox.shrink(),
              ),
              SizedBox(
                height: 25.0,
              ),
              FadeSlide(
                offsetX: 0.0,
                offsetY: 60.0,
                duration: getSlideDuration("slide-2", animationItems),
                child: Text(
                  "Choose your CAR!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32.0,
                    color: Theme.of(context).primaryColor,
                    height: 1.3,
                  ),
                ),
                direction: getItemVisibility(
                  "slide-2",
                  animationItems,
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return FadeSlide(
                    offsetX: 0.0,
                    offsetY: 60.0,
                    duration:
                        getSlideDuration("slide-${index + 3}", animationItems),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 20.0,
                      ),
                      height: 190.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          animateTransition(context, CarDetail());
                        },
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                child: cars[index].image,
                              ),
                            ),
                            Text(
                              cars[index].name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                              ),
                            ),
                            SizedBox(
                              height: 2.0,
                            ),
                            Text(
                              "${cars[index].price} Cars",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    direction:
                        getItemVisibility("slide-${index + 3}", animationItems),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 10.0,
                  );
                },
                // referencing the cars from car_modal.dart
                itemCount: cars.length,
              )
            ],
          ),
        ),
      ),
    );
  }
}

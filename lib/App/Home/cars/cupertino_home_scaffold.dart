import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yellow_carmailla/App/Home/cars/cars.dart';
import 'package:yellow_carmailla/App/Home/pages.dart/profile.dart';
import 'package:yellow_carmailla/App/Home/cars/tab_item.dart';

class CupertinoHomeScaffold extends StatelessWidget {
  const CupertinoHomeScaffold(
      {Key key, @required this.currentTab, @required this.onSelectTab})
      : super(key: key);

  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;

  Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {
      TabItem.cars: (_) => Cars(),
      //  TabItem.post: (_) => AddCarPage( database: databas),
      TabItem.account: (_) => Profile(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          _buildItem(TabItem.cars),
          // _buildItem(TabItem.post),
          _buildItem(TabItem.account),
        ],
        onTap: (index) => onSelectTab(TabItem.values[index]),
      ),
      tabBuilder: (context, index) {
        final item = TabItem.values[index];
        return CupertinoTabView(
          builder: (context) => widgetBuilders[item](context),
        );
      },
    );
  }

  BottomNavigationBarItem _buildItem(TabItem tabItem) {
    final itemData = TabItemData.allTabs[tabItem];
    final color = currentTab == tabItem ? Colors.amberAccent : Colors.grey;

    return BottomNavigationBarItem(
      icon: Icon(
        itemData.icon,
        color: color,
      ),
      title: Text(
        itemData.title,
        style: TextStyle(color: color),
      ),
    );
  }
}

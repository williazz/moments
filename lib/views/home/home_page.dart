import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moments/components/appbar.dart';
import 'package:moments/router/router.gr.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
        appBarBuilder: ((context, tabsRouter) => const CustomAppBar()),
        routes: const [
          FeedRouter(),
          YouRouter(),
        ],
        bottomNavigationBuilder: (context, tabsRouter) {
          return BottomNavigationBar(
              currentIndex: tabsRouter.activeIndex,
              onTap: (int index) {
                if (index == tabsRouter.activeIndex) {
                  final replaceAll = AutoRouter.of(context).replaceAll;
                  if (index == 0) {
                    replaceAll([const FeedRoute()]);
                  } else {
                    replaceAll([const YouRoute()]);
                  }
                } else {
                  tabsRouter.setActiveIndex(index);
                }
              },
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: const [
                BottomNavigationBarItem(
                  label: 'Feed',
                  icon: Icon(CupertinoIcons.home),
                ),
                BottomNavigationBarItem(
                  label: 'You',
                  icon: Icon(CupertinoIcons.person),
                ),
              ]);
        });
  }
}

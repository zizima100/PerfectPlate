import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PerfectPlateTabBar extends StatelessWidget {
  final Function(Tabs tab) onSelectTab;
  final Tabs currentTab;

  const PerfectPlateTabBar({ 
    Key? key,
    required this.onSelectTab,
    required this.currentTab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8.h,
      width: double.infinity,
      margin: EdgeInsets.all(2.h),
      decoration: BoxDecoration(
        color: Colors.green.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () => onSelectTab(Tabs.insertion),
            child: _TabBarItem(
              icon: Icons.food_bank,
              isSelected: currentTab == Tabs.insertion,
            ),
          ),
          GestureDetector(
            onTap: () => onSelectTab(Tabs.search),
            child: _TabBarItem(
              icon: Icons.search,
              isSelected: currentTab == Tabs.search,
            ),
          ),
          GestureDetector(
            onTap: () => onSelectTab(Tabs.profile),
            child: _TabBarItem(
              icon: Icons.person,
              isSelected: currentTab == Tabs.profile,
            ),
          ),
        ],
      ),
    );
  }
}

class _TabBarItem extends StatefulWidget {
  final IconData icon;
  final bool isSelected;

  const _TabBarItem({ 
    Key? key,
    required this.icon,
    required this.isSelected,
  }) : super(key: key);

  @override
  _TabBarItemState createState() => _TabBarItemState();
}

class _TabBarItemState extends State<_TabBarItem> {
  @override
  Widget build(BuildContext context) {
    return Icon(
      widget.icon,
      size: widget.isSelected ? 9.5.w : 8.w,
      color: widget.isSelected ? Colors.green.shade900 : Colors.white,
    );
  }
}

enum Tabs {
  insertion,
  search, 
  profile
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perfectplate/logic/bloc/auth_user/auth_user_bloc.dart';
import 'package:perfectplate/presentation/screens/home/tabs/plate_creation/widgets/plate_insertion.dart';
import 'package:perfectplate/presentation/screens/home/tabs/profile/profile.dart';
import 'package:perfectplate/presentation/screens/home/tabs/search/search_screen.dart';
import 'package:perfectplate/presentation/screens/home/tabs/widgets/tab_bar.dart';
import 'package:perfectplate/presentation/utils/router/route_helper.dart';
import 'package:perfectplate/presentation/utils/router/routes.dart';

class PlatesMainScreen extends StatefulWidget {
  const PlatesMainScreen({Key? key}) : super(key: key);

  @override
  State<PlatesMainScreen> createState() => _PlatesMainScreenState();
}

class _PlatesMainScreenState extends State<PlatesMainScreen> {
  late Tabs _tabSelected;

  @override
  void initState() {
    _tabSelected = Tabs.search;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void _onSelectTab(Tabs tab) {
      setState(() {
        _tabSelected = tab;
      });
    }

    Widget _renderTab() {
      switch (_tabSelected) {
        case Tabs.insertion:
          return const PlateInsertionWidget();
        case Tabs.search:
          return const SearchScreen();
        case Tabs.profile:
          return Profile();
      }
    }

    return BlocListener<AuthUserBloc, AuthUserState>(
        listenWhen: (previous, current) => previous != current,
        listener: (_, state) {
          if (state is UserLogout) {
            RouteHelper.removeAllAndPushTo(context, Routes.auth);
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 7,
                  child: _renderTab(),
                ),
                PerfectPlateTabBar(
                  onSelectTab: _onSelectTab,
                  currentTab: _tabSelected,
                ),
              ],
            ),
          ),
        ));
  }
}

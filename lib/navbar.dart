import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:unikart/Main/main_screen.dart';
import 'package:unikart/Profile/profile.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int index = 0;
  static final List<Widget> destinations = <Widget>[
    const Main(),
    const Profile(),
  ];
  void onTapped(int newIndex) {
    setState(
      () {
        index = newIndex;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: destinations[index],
      bottomNavigationBar: Builder(
        builder: (context) {
          return NavigationBar(
            selectedIndex: index,
            onDestinationSelected: onTapped,
            destinations: const [
              NavigationDestination(
                icon: Icon(FluentIcons.home_24_regular),
                selectedIcon: Icon(FluentIcons.home_24_filled),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(FluentIcons.person_24_regular),
                selectedIcon: Icon(FluentIcons.person_24_filled),
                label: 'Profile',
              ),
            ],
          );
        },
      ),
    );
  }
}

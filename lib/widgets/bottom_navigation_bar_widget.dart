import '../ui/bottom_navigation_bar_item.dart';
import 'package:flutter/material.dart';

class BottomNavBarWidget extends StatefulWidget {
  Function navigateTo;
  Map<String, dynamic> routes;
  BottomNavBarWidget(
      {super.key, required this.navigateTo, required this.routes});
  @override
  State<BottomNavBarWidget> createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
  Map<String, dynamic>? _tabs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabs = widget.routes;
  }

  /// It changes the active tab.
  ///
  /// Args:
  ///   label (String): The label of the tab.
  void _changeTab(String label) {
    if (_tabs == null) {
      return;
    }
    setState(() {
      /// Setting all the values of the `active` in the map to false.
      _tabs!.forEach((key, value) {
        value['active'] = false;
      });
      _tabs![label]!['active'] = true;
    });

    widget.navigateTo(label);
  }

  /// The function takes a `BuildContext` and returns a `Widget`
  ///
  /// Args:
  ///   context (BuildContext): The BuildContext of the widget that is invoking this method.
  ///
  /// Returns:
  ///   A Padding widget with a Row widget as its child.
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _tabs!.entries
            .map(
              (e) => BottomNavBarItemWidget(
                label: e.key,
                icon: e.value['icon']!,
                changeTab: () => _changeTab(e.key),
                active: e.value['active'],
              ),
            )
            .toList(),
      ),
    );
  }
}

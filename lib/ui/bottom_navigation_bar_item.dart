import 'package:ebra_w_5et/color_schemes.g.dart';
import 'package:flutter/material.dart';

class BottomNavBarItemWidget extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback changeTab;
  final bool active;
  const BottomNavBarItemWidget({
    Key? key,
    required this.label,
    required this.icon,
    required this.changeTab,
    required this.active,
  }) : super(key: key);

  @override
  State<BottomNavBarItemWidget> createState() => _BottomNavBarItemWidgetState();
}

class _BottomNavBarItemWidgetState extends State<BottomNavBarItemWidget> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: widget.active ? 120 : 50,
      height: 50,
      duration: const Duration(
        milliseconds: 800,
      ),
      curve: Curves.fastOutSlowIn,
      child: Center(
        child: TextButton.icon(
          style: TextButton.styleFrom(
            foregroundColor: widget.active
                ? lightColorScheme.onPrimary
                : lightColorScheme.onTertiaryContainer,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            backgroundColor:
                widget.active ? lightColorScheme.primary : Colors.transparent,
          ),
          onPressed: widget.changeTab,
          icon: Icon(widget.icon, size: 20),
          label: FittedBox(
            child: Text(
              widget.label,
              softWrap: true,
            ),
          ),
        ),
      ),
    );
  }
}

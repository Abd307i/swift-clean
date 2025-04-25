import 'package:flutter/material.dart';
import '../../core/constants/PickColorHelper.dart';

class BuildTabBar extends StatelessWidget {
  final Function(int) onTabChanged;
  final int currentTab;

  const BuildTabBar({
    Key? key,
    required this.onTabChanged,
    required this.currentTab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> tabs = ['All', 'In Progress', 'Delivered', 'Canceled'];

    return Container(
      height: 48,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: List.generate(tabs.length, (index) {
          final isSelected = currentTab == index;
          return Expanded(
            child: GestureDetector(
              onTap: () => onTabChanged(index),
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected ? Colors.indigo.shade500 : Colors.transparent,
                  borderRadius: BorderRadius.circular(24),
                ),
                alignment: Alignment.center,
                child: Text(
                  tabs[index],
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey,
                    fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
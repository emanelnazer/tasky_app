import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_assets.dart';

class PriorityDialogWidget extends StatefulWidget {
  const PriorityDialogWidget({super.key, required this.ontap});
  final void Function(int) ontap;

  @override
  State<PriorityDialogWidget> createState() => _PriorityDialogWidgetState();
}

class _PriorityDialogWidgetState extends State<PriorityDialogWidget> {
  final List<int> priorityList = List.generate(10, (index) => index + 1);
  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Column(
        children: [
          Text("Task Priority"),
          Divider(),
        ],
      ),
      content: Wrap(
        children: priorityList
            .map(
              (index) => PriorityItemWidget(
            index: index,
            isSelected: selectedIndex == index,
            onTap: () {
              widget.ontap(index);
              setState(() {
                selectedIndex = index;
              });
            },
          ),
        )
            .toList(),
      ),
    );
  }
}

class PriorityItemWidget extends StatelessWidget {
  const PriorityItemWidget({
    super.key,
    required this.index,
    required this.onTap,
    required this.isSelected,
  });

  final int index;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border:
          !isSelected ? Border.all(color: const Color(0xff27282F)) : null,
          color: isSelected ? const Color(0xff5F33E1) : null,
        ),
        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
        margin: const EdgeInsets.only(left: 16, bottom: 12),
        child: Column(
          children: [
            Image.asset(
              AppAssets.flag,
              width: 24,
              height: 24,
              color: isSelected ? Colors.white : Color(0xff000000),
            ),
            const SizedBox(height: 5),
            Text(
              index.toString(),
              style: TextStyle(
                color: isSelected ? Colors.white : Color(0xff000000),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

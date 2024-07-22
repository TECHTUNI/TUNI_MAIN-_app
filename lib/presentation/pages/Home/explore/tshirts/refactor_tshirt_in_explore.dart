import 'package:flutter/cupertino.dart';

class ItemTypeContainer extends StatelessWidget {
  final String text;
  final bool isSelected;
  final Function() onTap;

  const ItemTypeContainer({
    required this.onTap,
    required this.text,
    required this.isSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: isSelected ? CupertinoColors.black : CupertinoColors.white,
          border: Border.all(color: CupertinoColors.systemGrey2),
          borderRadius: BorderRadius.circular(12)
        ),
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            color: isSelected ? CupertinoColors.white : CupertinoColors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            letterSpacing: 1,
            fontSize: isSelected ? 15 : 13,
          ),
        ),
      ),
    );
  }
}



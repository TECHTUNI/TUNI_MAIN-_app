import 'package:flutter/material.dart';

class ProfilePageLists extends StatelessWidget {
  final Widget className;
  final IconData icon;
  final String text;

  const ProfilePageLists({
    super.key,
    required this.className,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => className));
      },
      leading: Container(
        padding: const EdgeInsets.all(6), // Adding padding to center the icon
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(6)),
        child: Icon(
          icon,
          size: 25,
          color: Colors.black,
        ),
      ),
      title: Text(
        text,
        style: const TextStyle(fontSize: 19),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        size: 12,
        color: Colors.grey,
      ),
    );
  }
}

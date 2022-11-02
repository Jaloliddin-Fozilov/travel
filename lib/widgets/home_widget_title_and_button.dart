import 'package:flutter/material.dart';

class HomeWidgetTiitleAndButton extends StatelessWidget {
  final String title;
  final Function() function;
  final Widget child;
  const HomeWidgetTiitleAndButton({
    required this.title,
    required this.function,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              TextButton(
                onPressed: function,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('See all'),
                    Icon(Icons.arrow_forward_ios, size: 16)
                  ],
                ),
              ),
            ],
          ),
          child,
        ],
      ),
    );
  }
}

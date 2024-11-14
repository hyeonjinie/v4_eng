import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onMenuPressed;
  final Function(String) onLanguageChanged;
  final VoidCallback onProfilePressed;
  final Color color1;
  final Color color2;

  const CustomAppBar({
    super.key,
    required this.onMenuPressed,
    required this.onLanguageChanged,
    required this.onProfilePressed,
    this.color1 = const Color(0xFF43A470),
    this.color2 = const Color(0xFF43A470),
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: const Color(0xFFF8F8F8),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1200),
            height: kToolbarHeight,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color1, color2],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.menu, color: Colors.white),
                    onPressed: onMenuPressed,
                  ),
                  const Spacer(),
                  Image.asset(
                    'assets/png/bgood_bi_w.png',
                    height: 40,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      PopupMenuButton<String>(
                        icon: const Icon(Icons.language, color: Colors.white),
                        onSelected: onLanguageChanged,
                        itemBuilder: (BuildContext context) {
                          return ['한국어', 'English'].map((String choice) {
                            return PopupMenuItem<String>(
                              value: choice,
                              child: Text(choice),
                            );
                          }).toList();
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.person, color: Colors.white),
                        onPressed: onProfilePressed,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

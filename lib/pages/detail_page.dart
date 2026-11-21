import 'package:flutter/material.dart';

import '../widgets/app_navigation_bar.dart';
import 'home_page.dart' show AntivirusItem;

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.item});

  final AntivirusItem item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.name, style: const TextStyle(fontFamily: 'RussoOne')),
        centerTitle: true,
        backgroundColor: Colors.lightGreenAccent,
      ),
      bottomNavigationBar: const AppNavigationBar(currentIndex: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: ColoredBox(
                    color: Colors.grey.shade100,
                    child: Image.asset(
                      item.image,
                      width: 200,
                      height: 150,
                      fit: BoxFit.contain,
                      semanticLabel: item.name,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Text(item.description, style: const TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
    );
  }
}

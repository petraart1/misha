import 'package:flutter/foundation.dart'
    show kIsWeb, defaultTargetPlatform, TargetPlatform;
import 'package:flutter/material.dart';

import '../routes.dart';
import '../widgets/app_navigation_bar.dart';

class AntivirusItem {
  const AntivirusItem(this.name, this.image, this.description);

  final String name;
  final String image;
  final String description;
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const _items = [
    AntivirusItem(
      'Kaspersky',
      'assets/images/kaspersky.png',
      'Защита от вирусов, фишинга и сетевых угроз.',
    ),
    AntivirusItem(
      'Dr.Web',
      'assets/images/drweb.png',
      'Проверка файлов и обнаружение вредоносных программ.',
    ),
    AntivirusItem(
      'ESET NOD32',
      'assets/images/eset.png',
      'Антивирусная защита с контролем сетевых угроз.',
    ),
    AntivirusItem(
      'Avast',
      'assets/images/avast.png',
      'Сканирование устройства и защита в реальном времени.',
    ),
    AntivirusItem(
      'Norton',
      'assets/images/norton.png',
      'Защита устройства, личных данных и интернет-соединения.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDesktopOrWeb =
        kIsWeb ||
        defaultTargetPlatform == TargetPlatform.windows ||
        defaultTargetPlatform == TargetPlatform.macOS ||
        defaultTargetPlatform == TargetPlatform.linux;
    final verticalSpacing = isDesktopOrWeb ? 32.0 : 16.0;
    final columns = MediaQuery.sizeOf(context).width > 600 ? 2 : 1;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Антивирусы',
          style: TextStyle(fontFamily: 'RussoOne'),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightGreenAccent,
      ),
      bottomNavigationBar: const AppNavigationBar(currentIndex: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(border: Border.all()),
                child: const Text(
                  'Антивирусы',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 26, fontFamily: 'RussoOne'),
                ),
              ),
              SizedBox(height: verticalSpacing),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(border: Border.all()),
                child: const Text(
                  'Антивирус — это программа для обнаружения и удаления '
                  'вредоносного программного обеспечения (вирусов, троянов, '
                  'червей и т.д.), а также для защиты компьютера от заражения.',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: verticalSpacing),
              SizedBox(
                height: 136,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _items.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final item = _items[index];
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: ColoredBox(
                        color: Colors.grey.shade100,
                        child: Image.asset(
                          item.image,
                          width: 142,
                          fit: BoxFit.contain,
                          semanticLabel: item.name,
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: verticalSpacing),
              const Text(
                'Популярные антивирусы',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              GridView.builder(
                primary: false,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _items.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  mainAxisExtent: 90,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  final item = _items[index];
                  return Card(
                    margin: EdgeInsets.zero,
                    child: Center(
                      child: ListTile(
                        leading: const Icon(
                          Icons.shield_outlined,
                          color: Colors.green,
                        ),
                        title: Text(item.name),
                        subtitle: Text(item.description),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => Navigator.pushNamed(
                          context,
                          Routes.detail,
                          arguments: item,
                        ),
                      ),
                    ),
                  );
                },
              ),
              const Divider(),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Icon(Icons.person, size: 30),
                    SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        'Носков М.С., ИКБО-61-23',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

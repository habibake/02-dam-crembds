import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Acerca de')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          Text('Proyecto Gastronómico Ancestral'),
          Divider(),
          Text('1. Nombre Dev 1'),
          Text('2. Nombre Dev 2'),
          Text('3. Nombre Dev 3'),
          Text('4. Nombre Dev 4'),
          Text('5. Nombre Dev 5'),
          Text('6. Nombre Dev 6'),
          Text('7. Nombre Dev 7'),
          Text('8. Nombre Dev 8'),
        ],
      ),
    );
  }
}
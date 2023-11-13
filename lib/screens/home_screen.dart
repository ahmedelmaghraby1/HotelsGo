import 'package:flutter/material.dart';

import '../custom_widgets/custom_components.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: HomeScreenContainer()),
    );
  }
}

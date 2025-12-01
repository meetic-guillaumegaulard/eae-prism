import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';
import 'screens/home_page.dart';

void main() {
  // You can change the brand here to test different themes
  const brand = Brand.match; // Try: match, meetic, okc, pof

  runApp(const MyApp(brand: brand));
}

class MyApp extends StatelessWidget {
  final Brand brand;

  const MyApp({super.key, required this.brand});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: BrandTheme.getBrandName(brand),
      theme: BrandTheme.getTheme(brand),
      home: HomePage(brand: brand),
      debugShowCheckedModeBanner: false,
    );
  }
}

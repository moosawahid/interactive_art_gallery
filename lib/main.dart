import 'package:flutter/material.dart';
import 'screens/art_gallery_screen.dart';

void main() {
  runApp(const InteractiveArtGalleryApp());
}

class InteractiveArtGalleryApp extends StatelessWidget {
  const InteractiveArtGalleryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Interactive Art Gallery',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
      ),
      home: const ArtGalleryScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
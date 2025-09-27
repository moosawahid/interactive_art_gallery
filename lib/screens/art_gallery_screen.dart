import 'package:flutter/material.dart';
import '../widgets/painting_canvas.dart';
import '../widgets/color_palette.dart';
import '../widgets/brush_controls.dart';
import '../widgets/particle_system.dart';

class ArtGalleryScreen extends StatefulWidget {
  const ArtGalleryScreen({super.key});

  @override
  State<ArtGalleryScreen> createState() => _ArtGalleryScreenState();
}

class _ArtGalleryScreenState extends State<ArtGalleryScreen>
    with TickerProviderStateMixin {
  Color _selectedColor = Colors.blue;
  double _brushSize = 5.0;
  bool _showParticles = false;
  late AnimationController _backgroundController;
  late Animation<double> _backgroundAnimation;

  @override
  void initState() {
    super.initState();
    _backgroundController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
    
    _backgroundAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _backgroundController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _backgroundController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.deepPurple.withOpacity(0.1),
              Colors.blue.withOpacity(0.1),
              Colors.pink.withOpacity(0.1),
            ],
            stops: [
              0.0,
              0.5 + 0.3 * _backgroundAnimation.value,
              1.0,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: Stack(
                  children: [
                    _buildPaintingCanvas(),
                    if (_showParticles) _buildParticleSystem(),
                    _buildControls(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            '🎨 Interactive Art Gallery',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    _showParticles = !_showParticles;
                  });
                },
                icon: Icon(
                  _showParticles ? Icons.auto_awesome : Icons.auto_awesome_outlined,
                  color: _showParticles ? Colors.amber : Colors.grey,
                ),
                tooltip: 'Toggle Particle Effects',
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    // TODO: Implement clear canvas functionality
                  });
                },
                icon: const Icon(Icons.clear_all, color: Colors.red),
                tooltip: 'Clear Canvas',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaintingCanvas() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: PaintingCanvas(
          selectedColor: _selectedColor,
          brushSize: _brushSize,
        ),
      ),
    );
  }

  Widget _buildParticleSystem() {
    return Positioned.fill(
      child: IgnorePointer(
        child: ParticleSystem(
          animationController: _backgroundController,
        ),
      ),
    );
  }

  Widget _buildControls() {
    return Positioned(
      bottom: 20,
      left: 20,
      right: 20,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ColorPalette(
              selectedColor: _selectedColor,
              onColorSelected: (color) {
                setState(() {
                  _selectedColor = color;
                });
              },
            ),
            const SizedBox(height: 16),
            BrushControls(
              brushSize: _brushSize,
              onBrushSizeChanged: (size) {
                setState(() {
                  _brushSize = size;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

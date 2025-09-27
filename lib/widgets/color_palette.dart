import 'package:flutter/material.dart';

class ColorPalette extends StatefulWidget {
  final Color selectedColor;
  final Function(Color) onColorSelected;

  const ColorPalette({
    super.key,
    required this.selectedColor,
    required this.onColorSelected,
  });

  @override
  State<ColorPalette> createState() => _ColorPaletteState();
}

class _ColorPaletteState extends State<ColorPalette>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  final List<Color> _colors = [
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
    Colors.grey,
    Colors.blueGrey,
    Colors.black,
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '🎨 Color Palette',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _colors.length,
            itemBuilder: (context, index) {
              final color = _colors[index];
              final isSelected = color == widget.selectedColor;
              
              return GestureDetector(
                onTap: () {
                  widget.onColorSelected(color);
                  if (isSelected) {
                    _animationController.forward().then((_) {
                      _animationController.reverse();
                    });
                  }
                },
                child: AnimatedBuilder(
                  animation: _scaleAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: isSelected ? _scaleAnimation.value : 1.0,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected ? Colors.white : Colors.grey.shade300,
                            width: isSelected ? 3 : 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: color.withOpacity(0.3),
                              blurRadius: isSelected ? 8 : 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: isSelected
                            ? const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 20,
                              )
                            : null,
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        _buildColorMixer(),
      ],
    );
  }

  Widget _buildColorMixer() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Color Mixer',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _buildColorSlider('Red', widget.selectedColor.red, (value) {
                  _updateColor(red: (value * 255).round());
                }),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildColorSlider('Green', widget.selectedColor.green, (value) {
                  _updateColor(green: (value * 255).round());
                }),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildColorSlider('Blue', widget.selectedColor.blue, (value) {
                  _updateColor(blue: (value * 255).round());
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildColorSlider(String label, int colorValue, Function(double) onChanged) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 4),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: _getSliderColor(label),
            inactiveTrackColor: _getSliderColor(label).withOpacity(0.3),
            thumbColor: _getSliderColor(label),
            overlayColor: _getSliderColor(label).withOpacity(0.2),
          ),
          child: Slider(
            value: colorValue / 255.0,
            onChanged: onChanged,
            min: 0.0,
            max: 1.0,
          ),
        ),
      ],
    );
  }

  Color _getSliderColor(String label) {
    switch (label) {
      case 'Red':
        return Colors.red;
      case 'Green':
        return Colors.green;
      case 'Blue':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  void _updateColor({int? red, int? green, int? blue}) {
    final currentColor = widget.selectedColor;
    final newColor = Color.fromRGBO(
      red ?? currentColor.red,
      green ?? currentColor.green,
      blue ?? currentColor.blue,
      1.0,
    );
    widget.onColorSelected(newColor);
  }
}

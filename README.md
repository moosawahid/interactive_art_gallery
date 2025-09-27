# 🎨 Interactive Art Gallery

A Flutter app that demonstrates custom painting capabilities, interactive animations, and advanced UI/UX design. Built to showcase Flutter development skills including custom painters, gesture handling, and visual effects.

## ✨ Features

### 🖌️ **Custom Painting Canvas**
- **Smooth brush strokes** with cubic bezier curves
- **Real-time drawing** with touch interactions
- **Brush texture effects** for realistic painting feel
- **Custom painting algorithms** for smooth lines

### 🎨 **Advanced Color System**
- **20+ predefined colors** with beautiful animations
- **Custom color mixer** with RGB sliders
- **Real-time color preview** with selection feedback
- **Smooth color transitions** and visual effects

### 🖌️ **Brush Controls**
- **Variable brush sizes** from 1px to 50px
- **Quick size selection** buttons
- **Animated brush preview** with pulsing effects
- **Real-time size feedback**

### ✨ **Particle System**
- **50+ animated particles** with physics simulation
- **Dynamic connections** between nearby particles
- **Glow effects** and smooth animations
- **Toggle-able particle effects**

### 🎭 **UI/UX Design**
- **Material Design 3** theming
- **Smooth animations** and transitions
- **Gradient backgrounds** with dynamic colors
- **Responsive design** for different screen sizes

## 🛠️ Technical Implementation

### **Custom Painting Engine**
- Custom `CustomPainter` implementation
- Cubic bezier curve smoothing for natural brush strokes
- Real-time stroke rendering with texture effects
- Efficient canvas management and memory optimization

### **Advanced Animations**
- Multiple `AnimationController` instances
- Complex animation sequences with `Tween` and `CurvedAnimation`
- Physics-based particle system with collision detection
- Smooth gesture handling with `GestureDetector`

### **State Management**
- Efficient state management with `setState`
- Optimized widget rebuilds
- Memory-conscious particle system
- Clean separation of concerns

### **Performance Optimizations**
- Custom painting optimizations
- Efficient particle system updates
- Minimal widget rebuilds
- Smooth 60fps animations

## 🛠️ Technologies Used

- **Flutter SDK** - Cross-platform mobile development
- **Dart** - Programming language
- **Custom Painters** - Advanced canvas rendering
- **Animation Controllers** - Smooth animations
- **Gesture Detection** - Touch interactions
- **Material Design 3** - Modern UI components

## 📱 Screenshots

*Screenshots will be added after running the app*

## 🎯 What This Project Demonstrates

1. **Flutter Development Skills**
   - Custom painting and canvas manipulation
   - Animation systems and controllers
   - Gesture handling and touch interactions

2. **UI/UX Design**
   - Modern interface design
   - Smooth animations and transitions
   - User interaction patterns

3. **Performance Considerations**
   - Efficient rendering techniques
   - Memory management
   - Animation optimization

4. **Problem Solving**
   - Custom brush stroke algorithms
   - Particle system implementation
   - Color mixing functionality

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Dart SDK
- Android Studio / VS Code
- Android/iOS emulator or device

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd interactive_art_gallery
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

## 🎨 How to Use

1. **Select Colors**: Tap any color from the palette or use the RGB mixer
2. **Adjust Brush Size**: Use the slider or quick size buttons
3. **Start Painting**: Touch and drag on the canvas to draw
4. **Toggle Effects**: Tap the sparkle icon to enable/disable particle effects
5. **Clear Canvas**: Tap the clear button to start over

## 🔧 Customization

### Adding New Colors
Edit the `_colors` list in `color_palette.dart`:
```dart
final List<Color> _colors = [
  Colors.red,
  Colors.blue,
  // Add your custom colors here
];
```

### Adjusting Particle Count
Modify the particle count in `particle_system.dart`:
```dart
_particles = List.generate(50, (index) { // Change 50 to desired count
```

### Customizing Brush Effects
Edit the `_drawBrushTexture` method in `painting_canvas.dart` for different brush effects.

## 📈 Future Enhancements

- [ ] Save and load artwork
- [ ] Multiple brush types (spray, marker, etc.)
- [ ] Undo/redo functionality
- [ ] Export to image
- [ ] Social sharing features
- [ ] Custom brush creation
- [ ] Layer support
- [ ] Text tools

## 🤝 Contributing

This is a portfolio project. Feel free to fork and experiment with the code!

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 👨‍💻 Author

**Moosa Wahid**
- GitHub: [@moosawahid](https://github.com/moosawahid)
- Portfolio: [Your Portfolio URL]

---

*Built with Flutter*
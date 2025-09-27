import 'package:flutter/material.dart';
import 'dart:math' as math;

class ParticleSystem extends StatefulWidget {
  final AnimationController animationController;

  const ParticleSystem({
    super.key,
    required this.animationController,
  });

  @override
  State<ParticleSystem> createState() => _ParticleSystemState();
}

class _ParticleSystemState extends State<ParticleSystem>
    with TickerProviderStateMixin {
  late List<Particle> _particles;
  late AnimationController _particleController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _particleController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
    
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _particleController,
      curve: Curves.easeInOut,
    ));

    _initializeParticles();
  }

  @override
  void dispose() {
    _particleController.dispose();
    super.dispose();
  }

  void _initializeParticles() {
    _particles = List.generate(50, (index) {
      final random = math.Random();
      return Particle(
        x: random.nextDouble(),
        y: random.nextDouble(),
        vx: (random.nextDouble() - 0.5) * 0.02,
        vy: (random.nextDouble() - 0.5) * 0.02,
        size: random.nextDouble() * 3 + 1,
        color: _getRandomColor(),
        life: random.nextDouble(),
        maxLife: random.nextDouble() * 2 + 1,
      );
    });
  }

  Color _getRandomColor() {
    final colors = [
      Colors.red.withOpacity(0.6),
      Colors.blue.withOpacity(0.6),
      Colors.green.withOpacity(0.6),
      Colors.purple.withOpacity(0.6),
      Colors.orange.withOpacity(0.6),
      Colors.pink.withOpacity(0.6),
    ];
    return colors[math.Random().nextInt(colors.length)];
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        _updateParticles();
        return CustomPaint(
          painter: ParticlePainter(_particles, _animation.value),
          size: Size.infinite,
        );
      },
    );
  }

  void _updateParticles() {
    for (final particle in _particles) {
      particle.x += particle.vx;
      particle.y += particle.vy;
      particle.life += 0.01;

      if (particle.life > particle.maxLife) {
        particle.life = 0;
        particle.x = math.Random().nextDouble();
        particle.y = math.Random().nextDouble();
        particle.color = _getRandomColor();
      }

      if (particle.x < 0 || particle.x > 1) particle.vx *= -1;
      if (particle.y < 0 || particle.y > 1) particle.vy *= -1;
    }
  }
}

class Particle {
  double x;
  double y;
  double vx;
  double vy;
  double size;
  Color color;
  double life;
  double maxLife;

  Particle({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.size,
    required this.color,
    required this.life,
    required this.maxLife,
  });
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final double animationValue;

  ParticlePainter(this.particles, this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    for (final particle in particles) {
      final alpha = (1 - particle.life / particle.maxLife) * 0.8;
      final paint = Paint()
        ..color = particle.color.withOpacity(alpha)
        ..style = PaintingStyle.fill;

      final x = particle.x * size.width;
      final y = particle.y * size.height;
      final radius = particle.size * (1 + math.sin(animationValue * math.pi * 2) * 0.3);

      canvas.drawCircle(Offset(x, y), radius, paint);

      // Add glow effect
      final glowPaint = Paint()
        ..color = particle.color.withOpacity(alpha * 0.3)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);

      canvas.drawCircle(Offset(x, y), radius * 2, glowPaint);
    }

    // Draw connecting lines between nearby particles
    _drawConnections(canvas, size);
  }

  void _drawConnections(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..strokeWidth = 1;

    for (int i = 0; i < particles.length; i++) {
      for (int j = i + 1; j < particles.length; j++) {
        final p1 = particles[i];
        final p2 = particles[j];
        
        final distance = math.sqrt(
          math.pow(p1.x - p2.x, 2) + math.pow(p1.y - p2.y, 2)
        );

        if (distance < 0.2) {
          final x1 = p1.x * size.width;
          final y1 = p1.y * size.height;
          final x2 = p2.x * size.width;
          final y2 = p2.y * size.height;

          final alpha = (1 - distance / 0.2) * 0.3;
          paint.color = Colors.white.withOpacity(alpha);
          
          canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

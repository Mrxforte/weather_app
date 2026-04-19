import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../core/theme/app_colors.dart';

// Gradient background wrapper that changes based on weather conditions
class WeatherBackground extends StatefulWidget {
  final List<Color>? colors;
  final int? conditionCode;
  final bool isNight;
  final bool enableWeatherAnimation;
  final Widget child;

  const WeatherBackground({
    super.key,
    this.colors,
    this.conditionCode,
    this.isNight = false,
    this.enableWeatherAnimation = true,
    required this.child,
  });

  @override
  State<WeatherBackground> createState() => _WeatherBackgroundState();
}

class _WeatherBackgroundState extends State<WeatherBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  static const _snowCodes = {
    1066,
    1069,
    1072,
    1114,
    1117,
    1204,
    1207,
    1210,
    1213,
    1216,
    1219,
    1222,
    1225,
    1237,
    1249,
    1252,
    1255,
    1258,
    1261,
    1264,
  };

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 14),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _WeatherEffect _resolveEffect() {
    final code = widget.conditionCode;
    if (code == null || widget.isNight) return _WeatherEffect.none;
    if (code == 1000) return _WeatherEffect.sunny;
    if (_snowCodes.contains(code)) return _WeatherEffect.snow;
    if (code <= 1009 || code == 1030 || code == 1135 || code == 1147) {
      return _WeatherEffect.cloudy;
    }
    return _WeatherEffect.rain;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final gradient =
        widget.colors ??
        (isDark ? AppColors.nightGradient : AppColors.sunnyGradient);
    final effect = _resolveEffect();

    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: gradient,
            ),
          ),
        ),
        if (widget.enableWeatherAnimation && effect != _WeatherEffect.none)
          Positioned.fill(
            child: IgnorePointer(
              child: RepaintBoundary(
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, _) {
                    final t = _controller.value;
                    return switch (effect) {
                      _WeatherEffect.rain => CustomPaint(
                        painter: _RainPainter(progress: t),
                      ),
                      _WeatherEffect.snow => CustomPaint(
                        painter: _SnowPainter(progress: t),
                      ),
                      _WeatherEffect.sunny => _SunnyOverlay(progress: t),
                      _WeatherEffect.cloudy => _CloudOverlay(progress: t),
                      _WeatherEffect.none => const SizedBox.shrink(),
                    };
                  },
                ),
              ),
            ),
          ),
        widget.child,
      ],
    );
  }
}

enum _WeatherEffect { none, rain, snow, sunny, cloudy }

class _SunnyOverlay extends StatelessWidget {
  final double progress;

  const _SunnyOverlay({required this.progress});

  @override
  Widget build(BuildContext context) {
    final pulse = 0.75 + (0.25 * (0.5 + (progress * 6.28318).sin() * 0.5));
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          top: -90,
          right: -70,
          child: Container(
            width: 280,
            height: 280,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Colors.white.withValues(alpha: 0.2 * pulse),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 60,
          left: -70,
          child: Container(
            width: 220,
            height: 220,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Colors.amberAccent.withValues(alpha: 0.08 * pulse),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CloudOverlay extends StatelessWidget {
  final double progress;

  const _CloudOverlay({required this.progress});

  @override
  Widget build(BuildContext context) {
    final shift = (progress * 320) - 160;
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(top: 70, left: shift, child: _cloudBlob(220, 70, 0.09)),
        Positioned(top: 170, right: shift, child: _cloudBlob(180, 56, 0.08)),
        Positioned(
          top: 260,
          left: shift * 0.7,
          child: _cloudBlob(260, 84, 0.06),
        ),
      ],
    );
  }

  Widget _cloudBlob(double width, double height, double alpha) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(height),
        color: Colors.white.withValues(alpha: alpha),
      ),
    );
  }
}

class _RainPainter extends CustomPainter {
  final double progress;

  const _RainPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.2)
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round;

    for (var i = 0; i < 95; i++) {
      final x = (i * 41.0) % size.width;
      final phase = (i * 0.073) % 1.0;
      final y = ((progress + phase) % 1.0) * (size.height + 40) - 40;
      canvas.drawLine(Offset(x, y), Offset(x - 6, y + 14), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _RainPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

class _SnowPainter extends CustomPainter {
  final double progress;

  const _SnowPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withValues(alpha: 0.45);

    for (var i = 0; i < 70; i++) {
      final baseX = (i * 53.0) % size.width;
      final phase = (i * 0.037) % 1.0;
      final y = ((progress + phase) % 1.0) * (size.height + 24) - 24;
      final wobble = 10 * ((progress * 6.28318) + i).sin();
      final radius = 1.4 + (i % 3) * 0.6;
      canvas.drawCircle(Offset(baseX + wobble, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _SnowPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

extension on double {
  double sin() => math.sin(this);
}

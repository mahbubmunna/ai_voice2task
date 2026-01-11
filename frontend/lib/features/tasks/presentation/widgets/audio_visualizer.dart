import 'package:flutter/material.dart';

class AudioVisualizer extends StatelessWidget {
  final List<double> amplitudes;
  final bool isProcessing;

  const AudioVisualizer({
    super.key,
    required this.amplitudes,
    required this.isProcessing,
  });

  @override
  Widget build(BuildContext context) {
    if (isProcessing) return const SizedBox.shrink();

    // Symmetrical visualization: Center is high index, edges are low.
    // Actually simpler: just duplicate the list mirrored.
    // Normalized amplitudes expected 0.0 to 1.0.

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: amplitudes.map((amp) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 50),
          margin: const EdgeInsets.symmetric(horizontal: 2),
          width: 8,
          height: 40 + (amp * 100), // Base height 40, max +100
          decoration: BoxDecoration(
            color: _getColor(amp),
            borderRadius: BorderRadius.circular(50),
          ),
        );
      }).toList(),
    );
  }

  Color _getColor(double amp) {
    // Gradient logic simulation
    if (amp > 0.8) return const Color(0xFFF472B6); // Pinkish
    if (amp > 0.5) return const Color(0xFFA78BFA); // Purple
    if (amp > 0.3) return const Color(0xFF60A5FA); // Blue
    return const Color(0xFF2DD4BF); // Example Teal/Cyan
  }
}

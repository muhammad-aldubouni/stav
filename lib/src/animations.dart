export 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_animate/flutter_animate.dart';

extension ConditionalAnimation on Animate {
  Animate animateWhere({
    required bool condition,
    required Animate Function(Animate animate) animation,
  }) {
    return condition ? animation(this) : this;
  }
}

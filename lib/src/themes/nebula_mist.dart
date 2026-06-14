import 'package:material_ui/material_ui.dart';

class GradientHomeTheme {
  GradientHomeTheme._();

  // Signature Cosmic Blue-to-Purple Gradients for Dark Mode
  static const List<Color> primaryGradientDark = [
    Color(0xFF1D4ED8), // Deep Electric Blue
    Color(0xFF364FDE), // Smooth Indigo midtone for better diagonal blending
    Color.fromARGB(255, 91, 58, 237), // Royal Purple / Violet
  ];

  // Refined Luminous Blue-to-Purple Gradients for Light Mode
  // Uses a beautiful periwinkle to bright lavender-violet palette that feels clean, airy, and high-end
  static const List<Color> primaryGradientLight = [
    Color(0xFF4F46E5), // Indigo Periwinkle
    Color.fromARGB(255, 105, 70, 229),
    Color.fromARGB(255, 110, 66, 214), // Bright Soft Violet
  ];

  // Secondary highlights (Cyan to Blue)
  static const List<Color> secondaryGradientDark = [
    Color(0xFF06B6D4), // Cyber Cyan
    Color(0xFF2563EB), // Sky Blue
  ];

  static const List<Color> secondaryGradientLight = [
    Color(0xFF0891B2), // Rich Cyan
    Color(0xFF3B82F6), // Ocean Blue
  ];

  // Soft Active Card Glow Gradients
  static const List<Color> activeGlowGradientDark = [
    Color.fromARGB(58, 37, 100, 235),
    // Translucent Blue
    Color(0x1F8B5CF6), // Translucent Violet
  ];

  static const List<Color> activeGlowGradientLight = [
    Color.fromARGB(255, 168, 186, 242), // Soft Periwinkle Ice
    Color.fromARGB(255, 225, 220, 247), // Soft Lavender Mist
  ];

  // Dark Theme Tokens (Cosmic Obsidian)
  static const Color darkBg = Color(0xFF090A15);
  static const Color darkCard = Color(0xFF131726);
  static const Color darkBorder = Color(0xFF20263F);
  static const Color darkTextPrimary = Color(0xFFF8FAFC);
  static const Color darkTextSecondary = Color(0xFF94A3B8);
  static const Color darkTextMuted = Color(0xFF475569);

  // Light Theme Tokens (Frosted Platinum & Lavender)
  static const Color lightBg = Color(
    0xFFF5F7FB,
  ); // Clean platinum white with a touch of blue

  static const Color lightCard = Color(0xFFFFFFFF); // Pure paper white cards
  static const Color lightBorder = Color(0xFFE2E8F0); // Subtle layout grid line
  static const Color lightTextPrimary = Color(0xFF0F172A); // Dark slate navy
  static const Color lightTextSecondary = Color(0xFF475569); // Muted slate gray
  static const Color lightTextMuted = Color(
    0xFF8E9AA8,
  ); // Lavender gray placeholder

  static bool isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  // Dynamic color getters to switch smoothly between dark and light modes
  static Color getBg(BuildContext context) =>
      isDark(context) ? darkBg : lightBg;
  static Color getCard(BuildContext context) =>
      isDark(context) ? darkCard : lightCard;
  static Color getBorder(BuildContext context) =>
      isDark(context) ? darkBorder : lightBorder;
  static Color getTextPrimary(BuildContext context) =>
      isDark(context) ? darkTextPrimary : lightTextPrimary;
  static Color getTextSecondary(BuildContext context) =>
      isDark(context) ? darkTextSecondary : lightTextSecondary;
  static Color getTextMuted(BuildContext context) =>
      isDark(context) ? darkTextMuted : lightTextMuted;

  // Dynamic gradient getters for unified branding
  static List<Color> getPrimaryGradient(BuildContext context) =>
      isDark(context) ? primaryGradientDark : primaryGradientLight;

  static List<Color> getSecondaryGradient(BuildContext context) =>
      isDark(context) ? secondaryGradientDark : secondaryGradientLight;

  static List<Color> getActiveGlowGradient(BuildContext context) =>
      isDark(context) ? activeGlowGradientDark : activeGlowGradientLight;

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBg,
      primaryColor: const Color(0xFF8B5CF6),
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF2563EB),
        secondary: Color(0xFF8B5CF6),
        surface: darkCard,
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: lightBg,
      primaryColor: const Color(0xFF2563EB),
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF2563EB),
        secondary: Color(0xFF8B5CF6),
        surface: lightCard,
      ),
    );
  }
}

/// A premium layout card supporting responsive lavender/indigo shadows and vibrant gradient background variants.
class GradientHomeCard extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final List<Color>? gradientColors;

  const GradientHomeCard({
    super.key,
    required this.child,
    this.borderRadius = 24.0,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = GradientHomeTheme.isDark(context);

    return Container(
      margin: margin,
      padding: padding ?? const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: gradientColors == null
            ? (backgroundColor ?? GradientHomeTheme.getCard(context))
            : null,
        gradient: gradientColors != null
            ? RadialGradient(
                center: AlignmentGeometry.topLeft,
                radius: 1.6,
                colors: gradientColors!,
                tileMode: .clamp,
              )
            : null,

        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: GradientHomeTheme.getBorder(context),
          width: 1.2,
        ),
        boxShadow: isDark
            ? [
                BoxShadow(
                  color: GradientHomeTheme.getSecondaryGradient(
                    context,
                  )[1].withValues(alpha: 0.06),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]
            : [
                BoxShadow(
                  color: const Color(0xFF8B5CF6).withValues(
                    alpha: 0.25,
                  ), // Beautiful lavender shadow for light mode depth
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: child,
    );
  }
}

/// The master System Overview Panel displaying current status summary of all active systems.

class SystemOverviewCard extends StatelessWidget {
  final int activeCount;
  final int totalCount;
  final double loadFactor;

  const SystemOverviewCard({
    super.key,
    required this.activeCount,
    required this.totalCount,
    required this.loadFactor,
  });
  @override
  Widget build(BuildContext context) {
    return GradientHomeCard(
      gradientColors: GradientHomeTheme.getPrimaryGradient(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "SYSTEM OVERVIEW",
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  "SECURE",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$activeCount / $totalCount Active",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight
                            .w900, // Replaced FontWeight.black with FontWeight.w900
                        color: Colors.white,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "All automation layers responsive",
                      style: TextStyle(fontSize: 11, color: Colors.white70),
                    ),
                  ],
                ),
              ),
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.wb_sunny_outlined,
                  color: Colors.white,
                  size: 26,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// An interactive smart utility card matching Tuya controls with custom blue-purple glow effects.
class ToggleSmartDeviceCard extends StatelessWidget {
  final String name;
  final String status;
  final IconData icon;
  final bool isSwitchedOn;
  final ValueChanged<bool> onToggle;

  const ToggleSmartDeviceCard({
    super.key,
    required this.name,
    required this.status,
    required this.icon,
    required this.isSwitchedOn,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final textSecondary = GradientHomeTheme.getTextSecondary(context);
    final isDark = GradientHomeTheme.isDark(context);

    // Dynamic glow background and switch theme adaptation
    final activeBgColors = GradientHomeTheme.getActiveGlowGradient(context);
    final primaryGradient = GradientHomeTheme.getPrimaryGradient(context);

    return GradientHomeCard(
      gradientColors: isSwitchedOn ? activeBgColors : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isSwitchedOn
                      ? (isDark
                            ? const Color.fromARGB(255, 190, 202, 251)
                            : const Color.fromARGB(255, 255, 255, 255))
                      : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: isSwitchedOn
                        ? primaryGradient
                        : [textSecondary, textSecondary],
                  ).createShader(bounds),
                  child: Icon(icon, size: 26, color: Colors.white),
                ),
              ),
              Switch(
                value: isSwitchedOn,
                activeTrackColor: const Color.fromARGB(
                  255,
                  74,
                  67,
                  94,
                ).withValues(alpha: isDark ? 0.4 : 0.25),

                activeThumbColor: isDark
                    ? const Color.fromARGB(255, 96, 107, 255)
                    : const Color(0xFF4F46E5),

                onChanged: onToggle,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: GradientHomeTheme.getTextPrimary(context),
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                isSwitchedOn ? status : "Inactive",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isSwitchedOn
                      ? FontWeight.w600
                      : FontWeight.normal,
                  color: isSwitchedOn ? const Color(0xFF8B5CF6) : textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SliderSmartDeviceCard extends StatelessWidget {
  final String name;
  final String status;
  final double max;
  final double min;
  final IconData icon;
  final double value;
  final bool isConnected;
  final ValueChanged<double> onToggle;

  const SliderSmartDeviceCard({
    super.key,
    required this.name,
    required this.status,
    required this.icon,
    required this.value,
    required this.max,
    required this.min,
    required this.isConnected,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final textSecondary = GradientHomeTheme.getTextSecondary(context);
    final isDark = GradientHomeTheme.isDark(context);

    // Dynamic glow background and switch theme adaptation
    final activeBgColors = GradientHomeTheme.getActiveGlowGradient(context);
    final primaryGradient = GradientHomeTheme.getPrimaryGradient(context);

    return GradientHomeCard(
      gradientColors: isConnected ? activeBgColors : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isConnected
                      ? (isDark
                            ? const Color.fromARGB(255, 190, 202, 251)
                            : const Color.fromARGB(255, 255, 255, 255))
                      : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: isConnected
                        ? primaryGradient
                        : [textSecondary, textSecondary],
                  ).createShader(bounds),
                  child: Icon(icon, size: 26, color: Colors.white),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),

          Slider(
            inactiveColor: const Color.fromARGB(
              255,
              74,
              67,
              94,
            ).withValues(alpha: isDark ? 0.4 : 0.25),
            label: value.toString(),
            showValueIndicator: .onDrag,
            activeColor: isDark
                ? const Color.fromARGB(255, 96, 107, 255)
                : const Color(0xFF4F46E5),
            thumbColor: isDark
                ? const Color.fromARGB(255, 96, 107, 255)
                : const Color(0xFF4F46E5),
            divisions: max.toInt(),
            max: max,
            min: min,
            value: value,

            onChanged: onToggle,
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: GradientHomeTheme.getTextPrimary(context),
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                isConnected ? status : "Disconnected",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isConnected ? FontWeight.w600 : FontWeight.normal,
                  color: isConnected ? const Color(0xFF8B5CF6) : textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Realtime power visualization card styled with beautiful cyan-purple tracking paths.
class EnergyManagementCard extends StatelessWidget {
  final String totalPower;
  final double loadFactor;

  const EnergyManagementCard({
    super.key,
    required this.totalPower,
    required this.loadFactor,
  });

  @override
  Widget build(BuildContext context) {
    final gradient = GradientHomeTheme.getPrimaryGradient(context);
    final textPrimary = GradientHomeTheme.getTextPrimary(context);

    return GradientHomeCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "ENERGY CONSUMPTION TRACKER",
                style: TextStyle(
                  fontSize: 11,
                  color: GradientHomeTheme.getTextSecondary(context),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.6,
                ),
              ),
              Icon(
                Icons.bolt,
                color: GradientHomeTheme.isDark(context)
                    ? const Color(0xFF2563EB)
                    : const Color(0xFF4F46E5),
                size: 20,
              ),
            ],
          ),
          const SizedBox(height: 6),
          ShaderMask(
            shaderCallback: (bounds) =>
                LinearGradient(colors: gradient).createShader(bounds),
            child: Text(
              totalPower,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight
                    .w900, // Replaced FontWeight.black with FontWeight.w900
                color: textPrimary,
                letterSpacing: -0.5,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Loading track progress indicators
          Container(
            height: 12,
            width: double.infinity,
            decoration: BoxDecoration(
              color: GradientHomeTheme.getBorder(context),
              borderRadius: BorderRadius.circular(6),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: loadFactor,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: gradient),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Power Buffer Load Capacity",
                style: TextStyle(
                  fontSize: 11,
                  color: GradientHomeTheme.getTextSecondary(context),
                ),
              ),
              Text(
                "${(loadFactor * 100).round()}% Capacity",
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: GradientHomeTheme.getTextSecondary(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Horizon Room Chips for seamless filtering.
class TabsSelector extends StatelessWidget {
  final List<String> rooms;
  final int selectedIndex;
  final ValueChanged<int> onRoomSelected;

  const TabsSelector({
    super.key,
    required this.rooms,
    required this.selectedIndex,
    required this.onRoomSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: rooms.length,
        itemBuilder: (context, index) {
          final isSelected = index == selectedIndex;

          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () => onRoomSelected(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 0),
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? LinearGradient(
                          colors: GradientHomeTheme.getPrimaryGradient(context),
                        )
                      : null,
                  color: isSelected ? null : GradientHomeTheme.getCard(context),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: isSelected
                        ? Colors.transparent
                        : GradientHomeTheme.getBorder(context),
                    width: 1.2,
                  ),
                  boxShadow: isSelected && !GradientHomeTheme.isDark(context)
                      ? [
                          BoxShadow(
                            color: const Color(
                              0xFF4F46E5,
                            ).withValues(alpha: 0.15),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : null,
                ),
                child: Center(
                  child: Text(
                    rooms[index],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: isSelected
                          ? Colors.white
                          : GradientHomeTheme.getTextSecondary(context),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Instant-activation scene triggers showcasing active blue-purple transitions.
class SceneShortcutWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  const SceneShortcutWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          gradient: isActive
              ? LinearGradient(
                  colors: GradientHomeTheme.getPrimaryGradient(context),
                )
              : null,
          color: isActive ? null : GradientHomeTheme.getCard(context),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isActive
                ? Colors.transparent
                : GradientHomeTheme.getBorder(context),
            width: 1.2,
          ),
          boxShadow: isActive && !GradientHomeTheme.isDark(context)
              ? [
                  BoxShadow(
                    color: const Color(0xFF4F46E5).withValues(alpha: 0.12),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isActive ? Colors.white : const Color(0xFF8B5CF6),
              size: 22,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: isActive
                      ? Colors.white
                      : GradientHomeTheme.getTextPrimary(context),
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: isActive
                  ? Colors.white70
                  : GradientHomeTheme.getTextSecondary(context),
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}

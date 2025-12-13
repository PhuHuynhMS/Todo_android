import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  final String label;
  final Color color;
  final IconData? icon;
  final VoidCallback? onTap;
  final bool showIcon;

  const CustomChip({
    super.key,
    required this.label,
    required this.color,
    this.icon,
    this.onTap,
    this.showIcon = true,
  });

  // Factory constructor cho chip không thể tap
  factory CustomChip.display({
    required String label,
    required Color color,
    IconData? icon,
    bool showIcon = true,
  }) {
    return CustomChip(
      label: label,
      color: color,
      icon: icon,
      showIcon: showIcon,
      onTap: null,
    );
  }

  // Factory constructor cho chip có thể tap
  factory CustomChip.interactive({
    required String label,
    required Color color,
    required VoidCallback onTap,
    IconData? icon,
    bool showIcon = true,
  }) {
    return CustomChip(
      label: label,
      color: color,
      icon: icon,
      showIcon: showIcon,
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    final chipContent = Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showIcon && icon != null) ...[
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );

    // Nếu có onTap, wrap với InkWell
    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: chipContent,
      );
    }

    // Nếu không có onTap, return trực tiếp
    return chipContent;
  }
}

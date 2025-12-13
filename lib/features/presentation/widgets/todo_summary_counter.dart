import 'package:flutter/material.dart';

class TodoSummaryCounter extends StatelessWidget {
  final int activeCount;
  final int completedCount;

  const TodoSummaryCounter({
    super.key,
    required this.activeCount,
    required this.completedCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "$activeCount active task${activeCount != 1 ? 's' : ''}",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(width: 16),
        Icon(
          Icons.circle,
          size: 6,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(width: 16),
        Text(
          "$completedCount completed",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}

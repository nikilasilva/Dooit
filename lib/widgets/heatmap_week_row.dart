import 'package:flutter/material.dart';

class HeatmapWeekRow extends StatelessWidget {
  final int weekIndex;

  const HeatmapWeekRow({super.key, required this.weekIndex});

  Color _getHeatmapColor(int week, int day) {
    // Simulate different productivity levels
    List<List<int>> data = [
      [2, 5, 7, 9, 6, 3, 8], // Week 1
      [4, 8, 6, 10, 7, 5, 9], // Week 2
      [6, 9, 8, 7, 10, 6, 8], // Week 3
      [5, 7, 9, 8, 6, 7, 10], // Week 4
    ];

    int tasks = data[week][day];

    if (tasks <= 2) return Color(0xFFFFE0D6);
    if (tasks <= 4) return Color(0xFFFFB899);
    if (tasks <= 6) return Color(0xFFFF9066);
    if (tasks <= 8) return Color(0xFFFF6B35);
    if (tasks <= 10) return Color(0xFFE55A2B);
    return Color(0xFFCC4A21);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          SizedBox(
            width: 60,
            child: Text(
              "Week ${weekIndex < 9 ? '0${weekIndex + 1}' : weekIndex + 1}",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          // January days
          Expanded(
            child: Row(
              children: List.generate(7, (dayIndex) {
                return Expanded(
                  child: Container(
                    height: 16,
                    margin: EdgeInsets.only(right: 2),
                    decoration: BoxDecoration(
                      color: _getHeatmapColor(weekIndex, dayIndex),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                );
              }),
            ),
          ),
          SizedBox(width: 8),
          // February days
          Expanded(
            child: Row(
              children: List.generate(7, (dayIndex) {
                return Expanded(
                  child: Container(
                    height: 16,
                    margin: EdgeInsets.only(right: 2),
                    decoration: BoxDecoration(
                      color: _getHeatmapColor(weekIndex, dayIndex),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                );
              }),
            ),
          ),
          SizedBox(width: 8),
          // March days
          Expanded(
            child: Row(
              children: List.generate(7, (dayIndex) {
                return Expanded(
                  child: Container(
                    height: 16,
                    margin: EdgeInsets.only(right: 2),
                    decoration: BoxDecoration(
                      color: _getHeatmapColor(weekIndex, dayIndex),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

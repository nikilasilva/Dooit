import 'package:flutter/material.dart';

class HeatmapLegend extends StatelessWidget {
  const HeatmapLegend({super.key});

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 9, color: Colors.grey[600])),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Text(
            "Tasks Completed:",
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: 12),
          _buildLegendItem("1-2", Color(0xFFFFE0D6)),
          SizedBox(width: 8),
          _buildLegendItem("3-4", Color(0xFFFFB899)),
          SizedBox(width: 8),
          _buildLegendItem("5-6", Color(0xFFFF9066)),
          SizedBox(width: 8),
          _buildLegendItem("7-8", Color(0xFFFF6B35)),
          SizedBox(width: 8),
          _buildLegendItem("9-10", Color(0xFFE55A2B)),
          SizedBox(width: 8),
          _buildLegendItem("10+", Color(0xFFCC4A21)),
        ],
      ),
    );
  }
}

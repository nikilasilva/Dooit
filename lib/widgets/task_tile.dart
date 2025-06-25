import 'package:DooIt/utils/app_styles.dart';
import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final String title;
  final String time;
  final String category; // Add this
  final bool done;

  const TaskTile({
    super.key, 
    required this.title, 
    required this.time, 
    required this.category, // Add this
    this.done = false
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: done ? Border.all(color: Colors.grey.shade300) : Border.all(color: AppColors.primary),
      ),
      child: Row(
        children: [
          Icon(done ? Icons.radio_button_checked : Icons.radio_button_off, 
               color: done ? AppColors.grey1 : AppColors.primary),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                decoration: done ? TextDecoration.lineThrough : TextDecoration.none,
                color: done ? Colors.grey : Colors.black,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(time, style: TextStyle(color: Colors.grey)),
              SizedBox(height: 4),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  category,
                  style: TextStyle(
                    fontSize: 10,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),              
            ],
          ),
        ],
      ),
    );
  }
}
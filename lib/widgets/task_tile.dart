import 'package:dooit/utils/app_styles.dart';
import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final String title;
  final String time;
  final bool done;

  const TaskTile({super.key, required this.title, required this.time, this.done = false});

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
          Icon(done ? Icons.radio_button_checked : Icons.radio_button_off, color: done ? AppColors.grey1 : AppColors.primary),
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
          Text(time, style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}

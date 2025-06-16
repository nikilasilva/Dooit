import 'package:dooit/utils/app_styles.dart';
import 'package:dooit/widgets/bottom_navbar.dart';
import 'package:dooit/widgets/custom_header.dart';
import 'package:flutter/material.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      bottomNavigationBar: BottomNavbar(currentIndex: 1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [CustomHeader(title: "Calendar"), SizedBox(height: 30)],
          ),
        ),
      ),
    );
  }
}

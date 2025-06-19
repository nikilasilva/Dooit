import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String id;
  final String title;
  final String note;
  final String category;
  final String time;
  final bool isCompleted;
  final DateTime createdAt;
  final DateTime? dueDate;

  Task({
    required this.id,
    required this.title,
    required this.note,
    this.category = "",
    this.time = "",
    this.isCompleted = false,
    required this.createdAt,
    this.dueDate,
  });

  // Convert from Firestore document
  factory Task.fromFireStore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Task(
      id: doc.id,
      title: data['title'] ?? '',
      note: data['note'] ?? '',
      category: data['category'] ?? '',
      time: data['time'] ?? '',
      isCompleted: data['isCompleted'] ?? false,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      dueDate:
          data['dueDate'] != null
              ? (data['dueDate'] as Timestamp).toDate()
              : null,
    );
  }

  // Convert to Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'note': note,
      'category': category,
      'time': time,
      'isCompleted': isCompleted,
      'createdAt': Timestamp.fromDate(createdAt),
      'dueDate': dueDate != null ? Timestamp.fromDate(dueDate!) : null,
    };
  }

  // Create a copy with updated fields
  Task copyWith({
    String? id,
    String? title,
    String? note,
    String? category,
    String? time,
    bool? isCompleted,
    DateTime? createdAt,
    DateTime? dueDate,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      note: note ?? this.note,
      category: category ?? this.category,
      time: time ?? this.time,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: this.createdAt,
      dueDate: this.dueDate,
    );
  }
}

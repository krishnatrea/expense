// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ExpenseModel extends Equatable {
  final String title;
  final int amount;
  final String category;
  final DateTime timestamp;
  ExpenseModel({
    required this.title,
    required this.amount,
    required this.category,
  }) : timestamp = DateTime.now();

  @override
  List<Object?> get props => [title, amount, category, timestamp];

  ExpenseModel copyWith({
    String? title,
    int? amount,
    String? category,
  }) {
    return ExpenseModel(
      title: title ?? this.title,
      amount: amount ?? this.amount,
      category: category ?? this.category,
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_expense_bloc.dart';

class AddExpenseEvent extends Equatable {
  final String? title;
  final String? category;
  final int? amount;
  final DateTime timestamp;
  AddExpenseEvent({
    this.title,
    this.category,
    this.amount,
  }) : timestamp = DateTime.now();

  @override
  List<Object> get props =>
      [title ?? "", category ?? "", amount ?? "", timestamp];
}

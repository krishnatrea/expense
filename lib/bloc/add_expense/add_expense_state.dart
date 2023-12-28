// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_expense_bloc.dart';

enum AddExpenseStatus { initial, success, failure }

class AddExpenseState extends Equatable {
  final AddExpenseStatus status;
  final String description;
  final DateTime timestamp;
  AddExpenseState({
    required this.status,
    required this.description,
  }) : timestamp = DateTime.now();

  @override
  List<Object> get props => [status, description, timestamp];

  AddExpenseState copyWith({
    AddExpenseStatus? status,
    String? description,
  }) {
    return AddExpenseState(
      status: status ?? this.status,
      description: description ?? this.description,
    );
  }
}

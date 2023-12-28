// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'expense_bloc.dart';

@immutable
class ExpenseState extends Equatable {
  final List<ExpenseModel> expense;
  const ExpenseState({
    required this.expense,
  });

  @override
  List<Object?> get props => [expense];

  ExpenseState copyWith({
    List<ExpenseModel>? expense,
  }) {
    return ExpenseState(
      expense: expense ?? this.expense,
    );
  }
}

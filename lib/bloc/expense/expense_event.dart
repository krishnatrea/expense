part of 'expense_bloc.dart';

@immutable
abstract class ExpenseEvent {}

class InitialExpenseEvent extends ExpenseEvent {}

class UpdateExpenseListEvent extends ExpenseEvent {}

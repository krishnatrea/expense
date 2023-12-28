import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense/model/expense_model.dart';
import 'package:expense/repository/expense_repository.dart';

part 'add_expense_event.dart';
part 'add_expense_state.dart';

class AddExpenseBloc extends Bloc<AddExpenseEvent, AddExpenseState> {
  AddExpenseBloc()
      : super(AddExpenseState(
            status: AddExpenseStatus.initial, description: "initial")) {
    on<AddExpenseEvent>((event, emit) {
      if (event.amount! == 0) {
        emit(state.copyWith(
            status: AddExpenseStatus.failure,
            description: "Please provide amount of expense."));
      } else if (event.title == null) {
        emit(state.copyWith(
            status: AddExpenseStatus.failure,
            description: "Please provide title to the expense."));
      } else if (event.category == null) {
        emit(state.copyWith(
            status: AddExpenseStatus.failure,
            description: "Please provide category to the expense."));
      } else {
        ExpenseRepository.instance.addExpense(ExpenseModel(
            title: event.title!,
            amount: event.amount!,
            category: event.category!));
        emit(state.copyWith(
            status: AddExpenseStatus.success,
            description: "Expense is successfully added!!!"));
      }
    });
  }
}

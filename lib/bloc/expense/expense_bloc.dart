import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense/model/expense_model.dart';
import 'package:expense/repository/expense_repository.dart';
import 'package:flutter/material.dart';

part 'expense_event.dart';
part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  ExpenseBloc() : super(const ExpenseState(expense: [])) {
    on<ExpenseEvent>((event, emit) {
      if (event is InitialExpenseEvent) {
        emit(state.copyWith(expense: ExpenseRepository.instance.expenses));
      } else if (event is UpdateExpenseListEvent) {
        emit(state.copyWith(expense: ExpenseRepository.instance.expenses));
      }
    });
  }
}

import 'package:expense/model/expense_model.dart';

class ExpenseRepository {
  ExpenseRepository._();
  static ExpenseRepository instance = ExpenseRepository._();
  List<ExpenseModel> expenses = [];
  List<String> categories = [
    "Travel",
    "Medical",
    "Food",
    "Groceries",
    "Rent",
    "Subscription",
    "Education"
  ];

  // add expense
  void addExpense(ExpenseModel model) {
    expenses.add(model);
  }

  // add categories
  void addCategory(String category) {
    categories.add(category);
  }

  // update expenses
  ExpenseModel updateExpense(ExpenseModel updatedModel, int index) {
    expenses.removeAt(index);
    expenses.insert(index, updatedModel);
    return updatedModel;
  }

  // get expenses
  List<ExpenseModel> getAllExpenses() {
    return expenses;
  }

  List<String> getCategories() {
    return categories;
  }

  // delete expenses
  void deleteExpense(int index) {
    expenses.removeAt(index);
  }
}

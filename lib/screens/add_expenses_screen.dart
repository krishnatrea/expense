import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:decimal/decimal.dart';
import 'package:expense/bloc/add_expense/add_expense_bloc.dart';
import 'package:expense/repository/expense_repository.dart';
import 'package:expense/utils/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddExpensesScreen extends StatelessWidget {
  const AddExpensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddExpenseBloc(),
      child: AddExpenseHelper(),
    );
  }
}

class AddExpenseHelper extends StatelessWidget {
  AddExpenseHelper({
    super.key,
  });

  final amountController = TextEditingController()
    ..text = CurrencyFormatter(symbol: "₹", decimalDigits: 0)
        .stringFromDecimal(Decimal.zero);
  final titleController = TextEditingController();
  final categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Add Your Expense",
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ),
      body: BlocListener<AddExpenseBloc, AddExpenseState>(
        listenWhen: (previous, current) => true,
        listener: (context, state) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: state.status == AddExpenseStatus.failure
                  ? Colors.red
                  : Colors.green,
              content: Text(
                state.description,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
              )));
          if (state.status == AddExpenseStatus.success) {
            Navigator.pop(context);
          }
        },
        child: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 100,
            ),
            AutoSizeTextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                controller: amountController,
                cursorColor: Colors.white,
                style: const TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
                inputFormatters: [
                  CurrencyTextInputFormatter(
                      currency: "INR", symbol: "₹", decimalDigits: 0)
                ],
                decoration: const InputDecoration(
                  border: InputBorder.none,
                )),
            SizedBox(
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Provide a title",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    constraints: const BoxConstraints(
                        maxHeight: 100, maxWidth: 300, minWidth: 100),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 2, color: Colors.grey),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: AutoSizeTextField(
                        textCapitalization: TextCapitalization.sentences,
                        keyboardType: TextInputType.name,
                        controller: titleController,
                        cursorColor: Colors.white,
                        decoration: const InputDecoration(
                            hintStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey),
                            hintText: "Rent",
                            border: InputBorder.none),
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Choose a category",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomDropdown<String>(
                    hintText: 'Select category',
                    closedFillColor: Colors.white,
                    items: ExpenseRepository.instance.getCategories(),
                    initialItem: categoryController.text.isEmpty
                        ? null
                        : categoryController.text,
                    onChanged: (value) {
                      categoryController.text = value;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: const ButtonStyle(
                    minimumSize: MaterialStatePropertyAll<Size>(Size(300, 60))),
                onPressed: () {
                  var amount = CurrencyFormatter(symbol: "₹", decimalDigits: 0)
                      .decimalFromString(amountController.text);
                  BlocProvider.of<AddExpenseBloc>(context).add(AddExpenseEvent(
                      amount: amount.signum,
                      title: titleController.text.isEmpty
                          ? null
                          : titleController.text,
                      category: categoryController.text.isEmpty
                          ? null
                          : categoryController.text));
                },
                child: const Text(
                  "Add Expenses",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ))
          ],
        )),
      ),
    );
  }
}

import 'package:decimal/decimal.dart';
import 'package:expense/bloc/expense/expense_bloc.dart';
import 'package:expense/screens/add_expenses_screen.dart';
import 'package:expense/utils/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        splashColor: Colors.black12,
        elevation: 2,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddExpensesScreen(),
              )).then((value) {
            BlocProvider.of<ExpenseBloc>(context).add(UpdateExpenseListEvent());
          });
        },
        child: const Icon(
          Icons.add,
          size: 38,
          color: Colors.black,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Center(
          child: Text(
            "Track Your Expenses",
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<ExpenseBloc, ExpenseState>(
          builder: (context, state) {
            return state.expense.isEmpty
                ? const Center(
                    child: Text(
                      "Add Expenses to show by clicking the + button below.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.expense.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              title: Text(state.expense[index].title,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600)),
                              subtitle: Text(state.expense[index].category,
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400)),
                              trailing: Text(
                                  CurrencyFormatter(
                                          currency: "INR", symbol: "₹")
                                      .stringFromDecimal(Decimal.fromInt(
                                          state.expense[index].amount)),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600)),
                            );
                          },
                        ),
                      )
                    ],
                  );
          },
        ),
      ),
    );
  }
}

import 'package:expenses_app/models/expense_model.dart';
import 'package:expenses_app/screens/new_expense.dart';
import 'package:expenses_app/screens/widgets/e_list.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({Key? key}) : super(key: key);

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  List registeredExpenses = [
    ExpenseModel(
      amount: 5,
      title: 'Tea',
      date: DateTime.now(),
      category: Category.food,
    ),
    ExpenseModel(
      amount: 20,
      title: 'Breakfast',
      date: DateTime.now(),
      category: Category.food,
    ),
    ExpenseModel(
      amount: 25,
      title: 'Mowasalat',
      date: DateTime.now(),
      category: Category.travel,
    ),
    ExpenseModel(
      amount: 90,
      title: 'Cinema',
      date: DateTime.now(),
      category: Category.fun,
    ),
  ];

  void addExpense(expense) {
    setState(() {
      registeredExpenses.add(expense);
    });
  }

  void removeExpense(expense) {
    setState(() {
      registeredExpenses.remove(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expenses'),
        centerTitle: true,
        // backgroundColor: Colors.cyan[800],
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (_) => NewExpense(onAdd: addExpense),
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: ExpensesList(
        expenses: registeredExpenses,
        onRemove: removeExpense,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (_) => NewExpense(onAdd: addExpense),
            );
          },
          child: Icon(Icons.add)),
    );
  }
}

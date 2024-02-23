import 'package:expenses_app/models/expense_model.dart';
import 'package:expenses_app/screens/widgets/e_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemove,
  });

  final List expenses;
  final void Function(ExpenseModel expense) onRemove;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (context, index) => Dismissible(
              key: ValueKey(expenses[index]),
              onDismissed: (direction) => onRemove(expenses[index]),
              child: ExpensesItem(
                expense: expenses[index],
              ),
            ),
        itemCount: expenses.length);
  }
}

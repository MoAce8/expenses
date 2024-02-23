import 'package:expenses_app/models/expense_model.dart';
import 'package:flutter/material.dart';

class ExpensesItem extends StatelessWidget {
  final ExpenseModel expense;

  const ExpensesItem({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 10),
        child: Column(
            children: [
            Text(expense.title),
        SizedBox(height: 4,),
        Row(
            children: [
        Text('\$${expense.amount}'),
        Spacer(),
        Row(
            children: [
            Icon(categoryIcons[expense.category]),
        SizedBox(width: 4,),
        Text(expense.formattedDate),
        ],
          // mainAxisAlignment: MainAxisAlignment.end,
    )],
    ),
    ],
    ),
      ),
    );
    }
}

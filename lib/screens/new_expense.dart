import 'package:expenses_app/models/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({Key? key, required this.onAdd});

  final void Function(ExpenseModel expense) onAdd;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final title_controller = TextEditingController();
  final amount_controller = TextEditingController();
  DateTime? picked_date;
  final formatter = DateFormat.yMd();
  Category pickedCategory = Category.food;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    title_controller.dispose();
    amount_controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              label: Text('Title'),
            ),
            maxLength: 50,
            controller: title_controller,
          ),
          SizedBox(
            height: 4,
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text('Amount'),
                    prefixText: '\$',
                  ),
                  controller: amount_controller,
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () async {
                        final now = DateTime.now();
                        final pickedDate = await showDatePicker(
                          context: context,
                          initialDate: now,
                          firstDate: DateTime(now.year - 1, now.month, now.day),
                          lastDate: now,
                        );
                        setState(() {
                          picked_date = pickedDate;
                        });
                      },
                      child: Row(
                        children: [
                          Text(picked_date == null
                              ? 'Pick Date'
                              : formatter.format(picked_date!)),
                          SizedBox(
                            width: 3,
                          ),
                          Icon(Icons.date_range),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 4,
          ),
          Row(
            children: [
              DropdownButton(
                value: pickedCategory,
                items: Category.values
                    .map((e) => DropdownMenuItem(
                          child: Text(e.name),
                          value: e,
                        ))
                    .toList(),
                onChanged: (val) {
                  if (val == null) return;
                  setState(() {
                    pickedCategory = val;
                  });
                },
              ),
              Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  final enteredAmount = double.tryParse(amount_controller.text);
                  final invalidAmount =
                      enteredAmount == null || enteredAmount < 0;

                  if (invalidAmount ||
                      title_controller.text.trim().isEmpty ||
                      picked_date == null) {
                    showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                              title: const Text('Error'),
                              content: const Text(
                                  'Check the title, amount and date it can\'t be empty'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(ctx);
                                  },
                                  child: const Text('Okay'),
                                )
                              ],
                            ));
                  } else {
                    widget.onAdd(
                      ExpenseModel(
                        amount: enteredAmount,
                        title: title_controller.text,
                        date: picked_date!,
                        category: pickedCategory,
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text('Save'),
              )
            ],
          ),
        ],
      ),
    );
  }
}

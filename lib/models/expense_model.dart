import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';


const uuid = Uuid();
final dateTime = DateFormat.yMd();

enum Category {food, travel, work, fun}
const categoryIcons ={
  Category.food: Icons.lunch_dining,
  Category.fun: Icons.games_outlined,
  Category.travel: Icons.flight_takeoff,
  Category.work: Icons.work,
};

class ExpenseModel {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;
  get formattedDate{
   return dateTime.format(date);
  }

  ExpenseModel({
      required this.amount,
      required this.title,
      required this.date,
      required this.category
  }) : id = uuid.v4();
}

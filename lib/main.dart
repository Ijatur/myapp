import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(MoneyExpensesApp());
}

class MoneyExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Money Expenses App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginScreen(),
    );
  }
}


// import 'package:flutter/material.dart';

// void main() {
//   runApp(MoneyExpensesApp());
// }

// class MoneyExpensesApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Money Expenses App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: ExpensesScreen(),
//     );
//   }
// }

// class ExpensesScreen extends StatefulWidget {
//   @override
//   _ExpensesScreenState createState() => _ExpensesScreenState();
// }

// class _ExpensesScreenState extends State<ExpensesScreen> {
//   List<Transaction> transactions = [];
//   double totalSpent = 0.0;
//   final TextEditingController amountController = TextEditingController();
//   final TextEditingController descriptionController = TextEditingController();
//   DateTime? selectedDate;

//   @override
//   void initState() {
//     super.initState();
//     addTransaction(100.0, "Initial Balance", DateTime.now());
//   }

//   void addTransaction(double amount, String description, DateTime date) {
//     setState(() {
//       transactions.add(Transaction(amount, description, date));
//       totalSpent += amount;
//     });
//   }

//   void _pickDate(BuildContext context) async {
//     DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2100),
//     );

//     if (pickedDate != null) {
//       setState(() {
//         selectedDate = pickedDate;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Money Expenses App'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildTransactionInput(),
//             SizedBox(height: 20),
//             Text('Total Spent: \$${totalSpent.toStringAsFixed(2)}',
//                 style: TextStyle(fontSize: 18)),
//             SizedBox(height: 20),
//             Expanded(child: _buildTransactionList()),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTransactionInput() {
//     return Column(
//       children: [
//         TextField(
//           controller: amountController,
//           keyboardType: TextInputType.number,
//           decoration: InputDecoration(
//             labelText: 'Amount',
//             hintText: 'Enter the amount',
//             border: OutlineInputBorder(),
//           ),
//         ),
//         SizedBox(height: 20),
//         TextField(
//           controller: descriptionController,
//           decoration: InputDecoration(
//             labelText: 'Description',
//             hintText: 'Enter the description',
//             border: OutlineInputBorder(),
//           ),
//         ),
//         SizedBox(height: 20),
//         Row(
//           children: [
//             Expanded(
//               child: Text(
//                 selectedDate == null
//                     ? 'No Date Selected'
//                     : 'Selected Date: ${selectedDate!.toLocal().toString().split(' ')[0]}',
//                 style: TextStyle(fontSize: 16),
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () => _pickDate(context),
//               child: Text('Pick Date'),
//             ),
//           ],
//         ),
//         SizedBox(height: 20),
//         ElevatedButton(
//           onPressed: () {
//             double amount = double.tryParse(amountController.text) ?? 0.0;
//             String description = descriptionController.text;
//             DateTime date = selectedDate ?? DateTime.now();
//             addTransaction(amount, description, date);
//             amountController.clear();
//             descriptionController.clear();
//             setState(() {
//               selectedDate = null;
//             });
//           },
//           child: Text('Add Transaction'),
//         ),
//       ],
//     );
//   }

//   Widget _buildTransactionList() {
//     return ListView.builder(
//       itemCount: transactions.length,
//       itemBuilder: (context, index) {
//         final transaction = transactions[index];
//         return ListTile(
//           title: Text('Amount: \$${transaction.amount.toStringAsFixed(2)}'),
//           subtitle: Text(
//               'Description: ${transaction.description}\nDate: ${transaction.date.toLocal().toString().split(' ')[0]}'),
//         );
//       },
//     );
//   }
// }

// class Transaction {
//   double amount;
//   String description;
//   DateTime date;

//   Transaction(this.amount, this.description, this.date);
// }

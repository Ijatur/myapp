import 'package:flutter/material.dart';

void main() {
  runApp(MoneyExpensesApp());
}

class MoneyExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Money Expenses App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ExpensesScreen(),
    );
  }
}

class ExpensesScreen extends StatefulWidget {
  @override
  _ExpensesScreenState createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  List<Transaction> transactions = [];
  double totalSpent = 0.0;
  double monthlyLimit = 500.0; // Default limit
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController limitController = TextEditingController();
  String selectedCategory = "Food & Drinks"; // Default category
  DateTime? selectedDate;

  final List<String> categories = [
    "Food & Drinks",
    "Vehicle & Transport",
    "Shopping",
    "Entertainment",
  ];

  @override
  void initState() {
    super.initState();
    addTransaction(100.0, "Initial Balance", DateTime.now(), "Initial");
  }

  void addTransaction(double amount, String description, DateTime date, String category) {
    setState(() {
      transactions.add(Transaction(amount, description, date, category));
      totalSpent += amount;
    });
    _checkMonthlyLimit();
  }

  void _checkMonthlyLimit() {
    double monthlySpent = transactions
        .where((transaction) => transaction.date.month == DateTime.now().month)
        .fold(0.0, (sum, transaction) => sum + transaction.amount);

    if (monthlySpent >= monthlyLimit) {
      _showLimitAlert();
    }
  }

  void _showLimitAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Limit Reached'),
          content: Text(
              'You have reached your monthly limit of \$${monthlyLimit.toStringAsFixed(2)}.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Money Expenses App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTransactionInput(),
            SizedBox(height: 20),
            _buildLimitInput(),
            SizedBox(height: 20),
            Text('Total Spent: \$${totalSpent.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Monthly Limit: \$${monthlyLimit.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18, color: Colors.redAccent)),
            SizedBox(height: 20),
            Expanded(child: _buildTransactionList()),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionInput() {
    return Column(
      children: [
        TextField(
          controller: amountController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Amount',
            hintText: 'Enter the amount',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 20),
        TextField(
          controller: descriptionController,
          decoration: InputDecoration(
            labelText: 'Description',
            hintText: 'Enter the description',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 20),
        DropdownButtonFormField<String>(
          value: selectedCategory,
          items: categories.map((String category) {
            return DropdownMenuItem<String>(
              value: category,
              child: Text(category),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              selectedCategory = newValue!;
            });
          },
          decoration: InputDecoration(
            labelText: 'Category',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: Text(
                selectedDate == null
                    ? 'No Date Selected'
                    : 'Selected Date: ${selectedDate!.toLocal().toString().split(' ')[0]}',
                style: TextStyle(fontSize: 16),
              ),
            ),
            ElevatedButton(
              onPressed: () => _pickDate(context),
              child: Text('Pick Date'),
            ),
          ],
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            double amount = double.tryParse(amountController.text) ?? 0.0;
            String description = descriptionController.text;
            DateTime date = selectedDate ?? DateTime.now();
            addTransaction(amount, description, date, selectedCategory);
            amountController.clear();
            descriptionController.clear();
            setState(() {
              selectedDate = null;
            });
          },
          child: Text('Add Transaction'),
        ),
      ],
    );
  }

  Widget _buildLimitInput() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: limitController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Monthly Limit',
              hintText: 'Enter the monthly limit',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            double newLimit = double.tryParse(limitController.text) ?? monthlyLimit;
            setState(() {
              monthlyLimit = newLimit;
            });
            limitController.clear();
          },
          child: Text('Set Limit'),
        ),
      ],
    );
  }

  Widget _buildTransactionList() {
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return ListTile(
          title: Text('Amount: \$${transaction.amount.toStringAsFixed(2)}'),
          subtitle: Text(
              'Description: ${transaction.description}\nDate: ${transaction.date.toLocal().toString().split(' ')[0]}\nCategory: ${transaction.category}'),
        );
      },
    );
  }
}

class Transaction {
  double amount;
  String description;
  DateTime date;
  String category;

  Transaction(this.amount, this.description, this.date, this.category);
}

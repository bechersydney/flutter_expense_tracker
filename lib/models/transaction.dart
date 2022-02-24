class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime transactionDate;

  const Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.transactionDate
  });
}
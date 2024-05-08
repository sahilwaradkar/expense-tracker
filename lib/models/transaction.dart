class TransactionModel {
  final int? id;
  final double amount;
  final String category;
  final String desc;
  final String date;
  final String type;

  TransactionModel({this.id, required this.amount, required this.category, required this.desc, required this.date, required this.type});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'category': category,
      'desc' : desc,
      'date': date,
      'type': type,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'],
      amount: map['amount'],
      category: map['category'],
      desc: map['desc'],
      date: map['date'],
      type: map['type'],
    );
  }
}
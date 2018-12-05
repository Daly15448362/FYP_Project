const String columnId = "_id";
const String columnValue = "_value";
const String columnDate = "_date";

class Transaction {
  int id;
  double value;
  DateTime dateTime;

  Transaction(this.value, this.dateTime);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      columnValue: value,
      columnDate: dateTime.millisecondsSinceEpoch,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  Transaction.fromMap(Map map)
      : id = map[columnId],
        value = map[columnValue],
        dateTime = new DateTime.fromMillisecondsSinceEpoch(map[columnDate]);
}
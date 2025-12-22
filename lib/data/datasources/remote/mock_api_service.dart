class MockApiService {
  // Simulate network delay
  Future<void> _delay() => Future.delayed(const Duration(milliseconds: 800));

  Future<List<Map<String, dynamic>>> getTransactions() async {
    await _delay();
    // Use the comprehensive sample data provided in the prompt or simple one first
    return [
      {"id":"t1","amount":-199.0,"category":"Food","ts":"2025-09-10T19:10:00Z","note":"Idli"},
      {"id":"t2","amount":5000.0,"category":"Salary","ts":"2025-09-01T09:00:00Z"}
    ];
  }

  Future<List<String>> getCategories() async {
    await _delay();
    return ["Food","Travel","Bills","Shopping","Salary","Other"];
  }

  Future<void> syncTransaction(Map<String, dynamic> transactionJson) async {
    await _delay();
    // Simulate successful sync
    return;
  }
}

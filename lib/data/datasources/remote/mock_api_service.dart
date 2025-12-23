import 'aa_parser_service.dart';
import 'aa_json_data.dart';

// Mock REST API simulating a remote server
class MockApiService {
  // Simple in-memory storage for the demo
  final List<Map<String, dynamic>> _serverTransactions = [
    ...AaParserService.parseAaJson(sampleBankStatementJson),
  ];

  final List<Map<String, dynamic>> _serverCategories = [
    {
      "id": "food",
      "name": "Food",
      "icon": "fastfood",
      "isCustom": false,
      "lastModified": "2025-01-01T00:00:00Z"
    },
    {
      "id": "travel",
      "name": "Travel",
      "icon": "flight",
      "isCustom": false,
      "lastModified": "2025-01-01T00:00:00Z"
    },
    {
      "id": "bills",
      "name": "Bills",
      "icon": "receipt_long",
      "isCustom": false,
      "lastModified": "2025-01-01T00:00:00Z"
    },
    {
      "id": "shopping",
      "name": "Shopping",
      "icon": "shopping_cart",
      "isCustom": false,
      "lastModified": "2025-01-01T00:00:00Z"
    },
    {
      "id": "salary",
      "name": "Salary",
      "icon": "payments",
      "isCustom": false,
      "lastModified": "2025-01-01T00:00:00Z"
    },
    {
      "id": "other",
      "name": "Other",
      "icon": "category",
      "isCustom": false,
      "lastModified": "2025-01-01T00:00:00Z"
    },
  ];

  // Simulate network delay - reduced for snappier demo feel
  Future<void> _delay() => Future.delayed(const Duration(milliseconds: 300));

  /// GET /transactions - Fetch all transactions from server
  Future<List<Map<String, dynamic>>> getTransactions() async {
    await _delay();
    return List.from(_serverTransactions);
  }

  /// GET /categories - Fetch all categories from server
  Future<List<Map<String, dynamic>>> getCategories() async {
    await _delay();
    return List.from(_serverCategories);
  }

  /// POST/PUT /transactions/:id - Sync a single transaction to server
  Future<void> syncTransaction(Map<String, dynamic> transactionJson) async {
    await _delay();
    
    final id = transactionJson['id'];
    final existingIndex = _serverTransactions.indexWhere((t) => t['id'] == id);
    
    if (existingIndex >= 0) {
      // Update existing
      _serverTransactions[existingIndex] = transactionJson;
    } else {
      // Add new
      _serverTransactions.add(transactionJson);
    }
    
    // Simulate successful response
    return;
  }

  /// POST/PUT /categories/:id - Sync a single category to server
  Future<void> syncCategory(Map<String, dynamic> categoryJson) async {
    await _delay();
    
    final id = categoryJson['id'];
    final existingIndex = _serverCategories.indexWhere((c) => c['id'] == id);
    
    if (existingIndex >= 0) {
      // Update existing
      _serverCategories[existingIndex] = categoryJson;
    } else {
      // Add new
      _serverCategories.add(categoryJson);
    }
    
    // Simulate successful response
    return;
  }

  /// DELETE /transactions/:id - Delete a transaction (optional)
  Future<void> deleteTransaction(String id) async {
    await _delay();
    _serverTransactions.removeWhere((t) => t['id'] == id);
  }

  /// DELETE /categories/:id - Delete a category (optional)
  Future<void> deleteCategory(String id) async {
    await _delay();
    _serverCategories.removeWhere((c) => c['id'] == id);
  }
}

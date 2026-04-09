import 'package:flutter/foundation.dart';
import 'package:flutter_book_reader/models/book.dart';
import 'package:flutter_book_reader/network/network.dart';

class HomeScreenProvider extends ChangeNotifier {
	final Network _network = Network();

	final List<Docs> _booksList = [];
	bool _isLoading = false;

	List<Docs> get booksList => List.unmodifiable(_booksList);
	bool get isLoading => _isLoading;

	Future<void> serachBooks(String query) async {
		_isLoading = true;
		notifyListeners();

		try {
			final books = await _network.searchBooks(query);
			_booksList
				..clear()
				..addAll(books);
		} catch (e) {
			debugPrint('Error occurred while searching books: $e');
		} finally {
			_isLoading = false;
			notifyListeners();
		}
	}
}

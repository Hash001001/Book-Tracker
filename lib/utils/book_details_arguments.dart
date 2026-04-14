import 'package:flutter_book_reader/models/book.dart';

class BookDetailArguments {
  final Docs bookData;
  final bool isFromSavedscreen; 
  BookDetailArguments({required this.bookData, required this.isFromSavedscreen});
}
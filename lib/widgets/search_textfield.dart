
import 'package:flutter/material.dart';
import 'package:flutter_book_reader/providers/home_provider.dart';
import 'package:provider/provider.dart';

class SerachTextField extends StatelessWidget {
  const SerachTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        label: Text("Search book here"),
        suffixIcon: Icon(Icons.search),
      ),
      onSubmitted: (value) {
        context.read<HomeScreenProvider>().serachBooks(value);
      },
    );
  }
}
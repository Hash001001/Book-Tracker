import 'package:flutter/material.dart';
import 'package:flutter_book_reader/providers/home_provider.dart';
import 'package:flutter_book_reader/widgets/grid_view_widget.dart';
import 'package:flutter_book_reader/widgets/search_textfield.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = context.watch<HomeScreenProvider>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                child: SerachTextField(),
              ),

              SizedBox(height: 20),
              Expanded(
                child: homeProvider.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : GridViewWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


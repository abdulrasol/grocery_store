import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:get/get.dart';
import 'package:grocery_store/layouts/home/pages/item.dart';
import 'package:grocery_store/services/database_dontroller.dart';

class Search extends SearchDelegate {
  final _controller = Get.put(DatabaseController());

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Boxicons.bx_x),
        color: Colors.white,
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(CupertinoIcons.back),
      color: Colors.white,
      onPressed: () => Get.back(),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView.builder(
      itemCount: _controller.query.value.getSearchedItems(query).length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Get.to(
              () => Item(
                  item: _controller.query.value.getSearchedItems(query)[index]),
            );
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(
                width: 1,
                color: Colors.grey[300]!,
              ),
            ),
            elevation: 0,
            margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 2.5),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  SizedBox(
                    width: 50,
                    child: Image.asset(
                      _controller.query.value
                          .getSearchedItems(query)[index]
                          .image,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _controller.query.value
                            .getSearchedItems(query)[index]
                            .name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        '${_controller.query.value.getSearchedItems(query)[index].price}\$ for ${_controller.query.value.getSearchedItems(query)[index].sellUnit}',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.builder(
      itemCount: _controller.query.value.getSearchedItems(query).length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Get.to(
              () => Item(
                  item: _controller.query.value.getSearchedItems(query)[index]),
            );
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(
                width: 1,
                color: Colors.grey[300]!,
              ),
            ),
            elevation: 0,
            margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 2.5),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  SizedBox(
                    width: 50,
                    child: Image.asset(
                      _controller.query.value
                          .getSearchedItems(query)[index]
                          .image,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _controller.query.value
                            .getSearchedItems(query)[index]
                            .name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        '${_controller.query.value.getSearchedItems(query)[index].price}\$ for ${_controller.query.value.getSearchedItems(query)[index].sellUnit}',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return theme.copyWith(
      appBarTheme: const AppBarTheme(
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.black87,
      ),
      hintColor: Colors.white,
      inputDecorationTheme: searchFieldDecorationTheme ??
          InputDecorationTheme(
            hintStyle: searchFieldStyle ?? theme.inputDecorationTheme.hintStyle,
            border: InputBorder.none,
            counterStyle: const TextStyle(color: Colors.white),
          ),
      textTheme: const TextTheme(
        headline5: TextStyle(color: Colors.white),
      ),
    );
  }
}

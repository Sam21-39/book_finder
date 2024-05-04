import 'dart:developer';

import 'package:book_finder/core/services/db/local_db.dart';
import 'package:book_finder/features/home/model/book_list_model.dart';
import 'package:book_finder/features/home/model/book_search_model.dart';
import 'package:get/get.dart';

class HomeDataCtrl extends GetxController {
  final connect = GetConnect();
  final bookList = <ReadingLogEntry>[].obs;
  final readlist = <String>[].obs;

  void init() async {
    final List<String>? list = await LocalDB.getReadList();
    if (list != null && list.isNotEmpty) {
      readlist.value = list.map((e) => e).toList();
    }
  }

  Future getBookList() async {
    try {
      final books = await connect.get(
          "https://openlibrary.org/people/mekBot/books/already-read.json",
          query: {"limit": "20"});
      log(books.body.toString());
      final resp = BookListModel.fromJson(books.body);

      bookList.value = resp.readingLogEntries ?? [];
    } catch (e) {
      log(e.toString());
    }
  }

  Future search(String param) async {
    bookList.clear();
    try {
      final books = await connect.get("https://openlibrary.org/search.json",
          query: {"title": param, "limit": "20"});
      log(books.body.toString());
      final resp = BookSearchModel.fromJson(books.body);
      if (resp.docs != null && resp.docs!.isNotEmpty) {
        bookList.value = resp.docs!
            .map((e) => ReadingLogEntry(
                    work: Work(
                  firstPublishYear: e.firstPublishYear,
                  authorNames: e.authorName,
                  coverId: e.coverI,
                  title: e.title,
                  key: e.key,
                )))
            .toList()
            .cast();
      } else {
        bookList.value = [
          ReadingLogEntry(
              work: Work(
            firstPublishYear: null,
            authorNames: [],
            coverId: null,
            title: 'No books found',
            key: 'NA',
          ))
        ];
      }
    } catch (e) {
      log(e.toString());
    }
  }
}

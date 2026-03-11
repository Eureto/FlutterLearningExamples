import 'dart:io';
import 'package:http/http.dart' as http;

const version = "1.1.1";
void main(List<String> arguments) {
  if (arguments.isEmpty || arguments.first == "help") {
    printUserInformation();
  } else if (arguments.first == "--version" || arguments.first == "-V") {
    print("Version: $version");
  } else if (arguments.first == "search") {
    final inputList = arguments.length > 1 ? arguments.sublist(1) : null;
    searchWikipedia(inputList);
  } else {
    printUserInformation();
  }
}

void printUserInformation() {
  print(
    "The following commands are valid: 'help', 'version', 'search <ARTICLE-TITLE>'",
  );
}

void searchWikipedia(List<String>? arguments) async {
  final String articleTitle;

  if (arguments == null || arguments.isEmpty) {
    print("Please provide titles:");
    articleTitle = stdin.readLineSync() ?? "";
    if (articleTitle == null || articleTitle.isEmpty) {
      print("You must provide article title, exiting funciton");
      return;
    }
  } else {
    articleTitle = arguments.join(" ");
  }

  print('Looking up articles about "$articleTitle". Please wait.');

  var articleContent = await getWikipediaArticle(articleTitle);
  print(articleContent);
}

Future<String> getWikipediaArticle(String articleTitle) async {
  final url = Uri.https(
    'en.wikipedia.org',
    '/api/rest_v1/page/summary/$articleTitle',
  );

  final response = await http.get(url);
  if (response.statusCode == 200) {
    return response.body;
  }
  return 'Error: Failed to fetch article, Status code: ${response.statusCode}';
}

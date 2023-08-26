import 'package:flutter/material.dart';
import 'package:foodex_app/widgets/export_widgets.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.green,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const AppIcon(
                icon: Icons.arrow_back_ios,
                iconSize: 25,
                backgroundColor: Colors.green,
                iconColor: Colors.white,
              ),
              BigText(
                text: 'Back',
                color: Colors.black,
              ),
              IconButton(
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: CustomSearchBarDelegate(),
                  );
                },
                icon: const Icon(Icons.search),
                // size: Dimensions.iconSize20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomSearchBarDelegate extends SearchDelegate {
  List<String> searchTerms = [
    "karma",
    "apple",
    "banana",
    "karma",
    "apple",
    "banana"
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          print("The query: --.$query");
          query = "";
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
        print("the text is:-->$matchQuery");
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(matchQuery[index]),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(matchQuery[index]),
        );
      },
    );
  }
}

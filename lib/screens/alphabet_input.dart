import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wordgridapp/screens/home_screen.dart';

class AlphabetInputPage extends StatefulWidget {
  final int rows;
  final int columns;

  const AlphabetInputPage({Key? key, required this.rows, required this.columns}) : super(key: key);

  @override
  State<AlphabetInputPage> createState() => _AlphabetInputPageState();
}

class _AlphabetInputPageState extends State<AlphabetInputPage> {
  List<String> _alphabets = List.filled(0, '', growable: true);

  @override
  void initState() {
    super.initState();
    _alphabets = List.filled(widget.rows * widget.columns, '', growable: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alphabet Input'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              if (!_alphabets.contains("")) {
                showSearch(
                    context: context,
                    delegate: MySearchDelegate(
                        _alphabets, widget.columns, widget.rows));
              } else {
                Fluttertoast.showToast(
                  msg: 'Please fill the grid values before searching',
                  backgroundColor: Colors.grey,
                );
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: widget.columns * 50.0,
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.rows * widget.columns,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: widget.columns,
                ),
                itemBuilder: (context, index) {
                  return TextFormField(
                    maxLength: 1,
                    maxLines: 1,
                    onChanged: (value) {
                      _alphabets[index] = value;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      counter: Offstage(),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.pop(context);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
                (route) => false,
          );
        },
        child: const Icon(Icons.restart_alt_sharp),
      ),
    );
  }
}

class MySearchDelegate extends SearchDelegate {
  final List<String> alphabets;
  final int rows;
  final int columns;

  MySearchDelegate(this.alphabets, this.columns, this.rows);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget> [IconButton(
      icon: const Icon(Icons.clear),
      onPressed: () {
        (query.isEmpty) ? close(context, null) : query = "";
      },
    )];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return output(query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestionsList = alphabets.where((searchResult) {
      final result = searchResult.toLowerCase();
      final input = query.toLowerCase();
      return result.contains(input);
    }).toList();
    return ListView.builder(
      itemCount: suggestionsList.length,
      itemBuilder: (context, index) {
        final suggestions = suggestionsList[index];
        return ListTile(
          title: Text(suggestions),
          onTap: () {
            query = suggestions;
            showResults(context);
          },
        );
      },
    );
  }

  Widget output(String query) {
    List<int> searchedChar = [];
    bool queryFound = false;

    // Find the searched characters
    for (int i = 0; i < rows; i++) {
      //to iterate every row
      for (int j = 0; j < columns; j++) {
        //to iterate every column
        int index = i * columns + j; //current index
        String character = alphabets[index]; //current char at index

        if (character.toLowerCase() == query[0].toLowerCase()) {
          //if current char matches first char of searched query == enter if
          // Check diagonal sequence
          if (i <= rows - query.length && j <= columns - query.length) {
            //check whether the query char's is within grid length
            bool isDiagonalSeq = true;
            for (int k = 1; k < query.length; k++) {
              String diagonalCharacter = alphabets[(i + k) * columns + (j + k)];
              if (diagonalCharacter.toLowerCase() != query[k].toLowerCase()) {
                isDiagonalSeq = false;
                break;
              }
            }
            if (isDiagonalSeq) {
              for (int k = 0; k < query.length; k++) {
                searchedChar.add((i + k) * columns + (j + k));
              }
              queryFound = true;
            }
          }
          // Check horizontal sequence
          if (j <= columns - query.length) {
            bool isHorizontalSeq = true;
            for (int k = 1; k < query.length; k++) {
              String horizontalCharacter = alphabets[i * columns + (j + k)];
              if (horizontalCharacter.toLowerCase() != query[k].toLowerCase()) {
                isHorizontalSeq = false;
                break;
              }
            }
            if (isHorizontalSeq) {
              for (int k = 0; k < query.length; k++) {
                searchedChar.add(i * columns + (j + k));
              }
              queryFound = true;
            }
          }
          // Check vertical sequence
          if (i <= rows - query.length) {
            bool isVerticalSeq = true;
            for (int k = 1; k < query.length; k++) {
              String verticalCharacter = alphabets[(i + k) * columns + j];
              if (verticalCharacter.toLowerCase() != query[k].toLowerCase()) {
                isVerticalSeq = false;
                break;
              }
            }
            if (isVerticalSeq) {
              for (int k = 0; k < query.length; k++) {
                searchedChar.add((i + k) * columns + j);
              }
              queryFound = true;
            }
          }
        }
      }
    }

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: columns * 50.0,
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: rows * columns,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
              ),
              itemBuilder: (context, index) {
                return Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border.all(),
                      color: searchedChar.contains(index)
                          ? Colors.red
                          : Colors.green),
                  child: Text(
                    alphabets[index],
                    style: const TextStyle(fontSize: 20),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

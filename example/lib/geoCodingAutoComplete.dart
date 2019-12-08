import 'package:flutter/material.dart';
import 'package:here_maps_webservice/here_maps.dart';
import 'package:flutter/services.dart';

class GeoCodingAutoComplete extends StatefulWidget {
  @override
  _GeoCodingAutoCompleteState createState() => _GeoCodingAutoCompleteState();
}

class _GeoCodingAutoCompleteState extends State<GeoCodingAutoComplete> {
  List<dynamic> _suggestion = [];
  var currentLocation;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    _searchController.addListener(() {
      final text = _searchController.text;
      _searchController.value = _searchController.value.copyWith(
        text: text,
        selection:
            TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Auto GeoCoding Example"),
      ),
      body: Column(
        children: <Widget>[
          getSearchBar(),
          Expanded(
            child: _suggestion.isEmpty
                ? Container(
                    alignment: Alignment.center,
                    child: Text("No Results Found"),
                  )
                : ListView.builder(
                    itemCount: _suggestion.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(_suggestion[index]['label']),
                        ),
                      );
                    }),
          ),
        ],
      ),
    );
  }

  getSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.all(Radius.circular(32)),
        child: TextField(
          controller: _searchController,
          onChanged: ((value) {
            setState(() {
              _searchController.text = value;
              _suggestion.clear();
              HereMaps(appId: "yourAppId", appCode: "youAppCode")
                  .geoCodingAutoComplete(query: _searchController.text)
                  .then((response) {
                print(response);
                setState(() {
                  _suggestion.addAll(response['suggestions']);
                });
              });
            });
            print(_searchController.text);
          }),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: Colors.blue,
            ),
            hintText: "Search by Area",
            hintStyle: TextStyle(color: Colors.grey),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 0.0),
                borderRadius: BorderRadius.all(Radius.circular(0))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 0.0),
                borderRadius: BorderRadius.all(Radius.circular(0))),
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}

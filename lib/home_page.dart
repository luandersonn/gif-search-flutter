import 'package:flutter/material.dart';
import 'package:gif_search/gif_item_view.dart';
import 'package:gif_search/giphy_lib.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Gifs> gifs;
  int page;
  bool error;

  @override
  void initState() {
    super.initState();
    gifs = [];
    page = 0;
    error = false;
    loadMoreItems(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trending"),
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    if (error == true) return getErrorMessage();

    if (gifs.isEmpty) return getEmptyMessage();

    return Container(
      child: GridView.builder(
        itemCount: gifs.length + 1,
        itemBuilder: (context, index) {
          if (index == gifs.length)
            return ElevatedButton(
              child: Text("Load more items"),
              onPressed: () {
                page++;
                loadMoreItems(page);
              },
            );
          return GifItemView(gif: gifs[index]);
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
        ),
        padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
      ),
    );
  }

  Widget getErrorMessage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            "Error",
            style: TextStyle(
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                gifs = [];
                page = 0;
                error = false;
              });
              loadMoreItems(page);
            },
            child: Text("Try again"),
          ),
          margin: EdgeInsets.all(10),
        ),
      ],
    );
  }

  Widget getEmptyMessage() {
    return Center(child: CircularProgressIndicator());
  }

  void loadMoreItems(int page) async {
    try {
      GiphyLibrary lib = GiphyLibrary(apiKey: 'api_key');
      final pageSize = 20;
      final offset = pageSize * page;
      final response =
          await lib.fetchTrendingGifs(offset: offset, limit: pageSize);
      setState(() {
        gifs.addAll(response.data.map((e) => e.images));
      });
    } catch (e) {
      print(e);
      setState(() {
        error = true;
      });
    }
  }
}

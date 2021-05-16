import 'package:flutter/material.dart';
import 'package:gif_search/giphy_lib.dart';

class GifItemView extends StatelessWidget {
  GifItemView({@required this.gif});
  final Gifs gif;
  @override
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground: true,
      elevation: 4,
      child: Image.network(
        gif.fixedWidthDownsampled.url,
        fit: BoxFit.cover,
        errorBuilder: (context, details, trace) {
          return Container(
            child: Center(
              child: Text(
                "Error",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ),
            color: Colors.red[600],
          );
        },
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent loadingProgress) {
          if (loadingProgress == null) return child;

          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes
                  : null,
            ),
          );
        },
      ),
    );
  }
}
/*
class GifItemView extends StatefulWidget {
  final Gifs gif;
  GifItemView({@required this.gif});
  @override
  _GifItemViewState createState() => _GifItemViewState(gif: gif);
}

class _GifItemViewState extends State<GifItemView> {
  Gifs gif;

  _GifItemViewState({@required this.gif});

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground: true,
      elevation: 4,
      child: Image.network(
        gif.fixedWidthDownsampled.url,
        fit: BoxFit.cover,
        errorBuilder: (context, details, trace) {
          return Container(
            child: Center(
              child: Text(
                "Error",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ),
            color: Colors.red[600],
          );
        },
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent loadingProgress) {
          if (loadingProgress == null) return child;

          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes
                  : null,
            ),
          );
        },
      ),
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double _progress = 0;
  late InAppWebViewController webView;

  // Function to show a dialog for no internet connection
  void _showNoInternetDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('No Internet Connection'),
          content: Text('Please check your internet connection and try again.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
                style: TextStyle(color: Colors.blue, fontSize: 18),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            // Progress Indicator
            _progress < 1
                ? Container(
                    color: Colors.black26,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: h * 0.003, horizontal: w * 0.02),
                      child: Row(
                        children: [
                          Expanded(
                            child: LinearProgressIndicator(
                              borderRadius: BorderRadius.circular(15),
                              minHeight: h * 0.010,
                              value: _progress,
                              backgroundColor: Colors.black45,
                              color: const Color.fromARGB(255, 11, 101, 219),
                            ),
                          ),
                          SizedBox(width: w * 0.02),
                          Text(
                            '${(_progress * 100).toInt()}%',
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(
                    color: Colors.transparent,
                  ),
            Expanded(
              child: InAppWebView(
                initialUrlRequest: URLRequest(
                  url: WebUri('https://anbarfish.com'),
                ),
                onWebViewCreated: (InAppWebViewController controller) {
                  webView = controller;
                },
                onProgressChanged:
                    (InAppWebViewController controller, int progress) {
                  setState(() {
                    _progress = progress / 100;
                  });
                },
                onLoadError: (InAppWebViewController controller, Uri? url,
                    int code, String message) {
                  // Handle load errors, e.g., show a dialog for no internet connection
                  if (code == -2) {
                    _showNoInternetDialog();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

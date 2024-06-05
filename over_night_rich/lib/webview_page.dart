import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:over_night_rich/untils/color_untils.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({Key? key}) : super(key: key);

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late String url;
  WebViewController? _controller;

  @override
  initState() {
    super.initState();
    // 你可以在这里对控制器进行初始化操作，如设置初始页面等
    url = Get.arguments['url'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //设置appBar的高度
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          elevation: 0,
          backgroundColor: ColorUtils.themeColor,
        ),
      ),
      body: Stack(
        children: [
          WebView(
            initialUrl: url,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              // 你可以在这里对控制器进行初始化操作，如设置初始页面等
              _controller = webViewController;
            },
            navigationDelegate: (NavigationRequest request) {
              if (request.url.startsWith('https://www.example.com/')) {
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            },
            onPageStarted: (String url) {
              print('Page started loading: $url');
            },
            onPageFinished: (String url) {
              print('Page finished loading: $url');
            },
            gestureNavigationEnabled: true,
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: 44,
              height: 44,
              color: ColorUtils.themeColor,
              child: GestureDetector(
                  onTap: () {
                    _goBack();
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  )),
            ),
          ),
          Positioned(
            bottom: 60,
            right: 16,
            child: FloatingActionButton(
              backgroundColor: ColorUtils.themeColor,
              onPressed: () {
                EasyLoading.showToast("收藏成功");
              },
              tooltip: 'Increment',
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }

  //判断是否可以返回
  void _goBack() async {
    if (_controller != null) {
      if (await _controller!.canGoBack()) {
        _controller!.goBack();
      } else {
        Get.back();
      }
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

const homeUrl = 'https://sfs-ys9jwtlw74mc.live-website.com/';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ScubaBuddiesApp());
}

class ScubaBuddiesApp extends StatelessWidget {
  const ScubaBuddiesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ScubaBuddies',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: const Color(0xFF007F9E), useMaterial3: true),
      home: const ScubaBuddiesHome(),
    );
  }
}

class ScubaBuddiesHome extends StatefulWidget {
  const ScubaBuddiesHome({super.key});

  @override
  State<ScubaBuddiesHome> createState() => _ScubaBuddiesHomeState();
}

class _ScubaBuddiesHomeState extends State<ScubaBuddiesHome> {
  late final WebViewController controller;
  int progress = 0;
  String? error;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (value) {
          if (mounted) setState(() => progress = value);
        },
        onPageStarted: (_) {
          if (mounted) setState(() { error = null; progress = 0; });
        },
        onWebResourceError: (webError) {
          if (webError.isForMainFrame == true && mounted) {
            setState(() => error = 'Die Seite konnte nicht geladen werden. Bitte prüfe deine Internetverbindung.');
          }
        },
        onNavigationRequest: (request) async {
          final uri = Uri.tryParse(request.url);
          if (uri == null) return NavigationDecision.prevent;
          if (uri.scheme == 'https' || uri.scheme == 'http') {
            if (uri.host == Uri.parse(homeUrl).host) return NavigationDecision.navigate;
            await launchUrl(uri, mode: LaunchMode.externalApplication);
            return NavigationDecision.prevent;
          }
          if (['mailto', 'tel', 'sms'].contains(uri.scheme)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
          return NavigationDecision.prevent;
        },
      ))
      ..loadRequest(Uri.parse(homeUrl));
  }

  Future<void> goBack() async {
    if (await controller.canGoBack()) {
      await controller.goBack();
    } else {
      await SystemNavigator.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) goBack();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ScubaBuddies'),
          actions: [
            IconButton(
              tooltip: 'Startseite',
              icon: const Icon(Icons.home_outlined),
              onPressed: () => controller.loadRequest(Uri.parse(homeUrl)),
            ),
            IconButton(
              tooltip: 'Neu laden',
              icon: const Icon(Icons.refresh),
              onPressed: () {
                setState(() => error = null);
                controller.reload();
              },
            ),
          ],
        ),
        body: Column(children: [
          if (progress < 100 && error == null)
            LinearProgressIndicator(value: progress == 0 ? null : progress / 100),
          Expanded(
            child: error != null
                ? Center(child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      const Icon(Icons.wifi_off, size: 48),
                      const SizedBox(height: 16),
                      Text(error!, textAlign: TextAlign.center),
                      const SizedBox(height: 12),
                      FilledButton(onPressed: () {
                        setState(() => error = null);
                        controller.loadRequest(Uri.parse(homeUrl));
                      }, child: const Text('Erneut versuchen')),
                    ]),
                  ))
                : WebViewWidget(controller: controller),
          ),
        ]),
      ),
    );
  }
}

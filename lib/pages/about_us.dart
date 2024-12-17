// import 'package:flutter/material.dart';

// class AboutUs extends StatelessWidget {
//   const AboutUs({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("About us"),
//       ),
//       body: Center(
//           child: Text(
//         "tootisabz.tech",
//         style: TextStyle(fontSize: 24),
//       )),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  // launch the URL in the browser /// (ITS NOT WORKING) ///
  Future<void> _launchURL() async {
    const url = 'https://tootisabz.tech';
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About us"),
      ),
      body: Center(
        child: GestureDetector(
          onTap: _launchURL, // Trigger the _launchURL
          child: Text(
            "tootisabz.tech",
            style: TextStyle(
              fontSize: 24,
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ),
    );
  }
}

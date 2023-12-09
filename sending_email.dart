import 'package:url_launcher/url_launcher.dart';

class EmailUseCases {
  String email;
  String subject;
  String body;
  EmailUseCases({
    required this.email,
    required this.subject,
    required this.body,
  });

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  send(type) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      query: encodeQueryParameters(<String, String>{
        'subject': subject,
        'body': body,
      }),
    );
    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      throw "Error occured sending an email";
    }
  }
}

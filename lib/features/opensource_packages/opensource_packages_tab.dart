import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:flutter/services.dart' show rootBundle;
import 'package:url_launcher/url_launcher.dart';

class OpensourcePackagesTab extends StatelessWidget {
  const OpensourcePackagesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.opensourcepackages),
        ),
        body: FutureBuilder<String>(
          future: loadLicenses(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Markdown(
                data: snapshot.data!,
                selectable: true,
                extensionSet: md.ExtensionSet.commonMark,
                onTapLink: (String text, String? href, String title) =>
                    linkOnTapHandler(href!),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text('Error loading licenses: ${snapshot.error}'),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
    );
  }

  Future<String> loadLicenses() async {
    return await rootBundle.loadString('assets/licenses.md');
  }

  Future<void> linkOnTapHandler(String href) async {
    Uri uri = Uri.parse(href);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }
}

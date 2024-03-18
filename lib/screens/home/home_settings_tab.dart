import 'package:flutter/material.dart';
import 'package:taskland/custom_icon/custom_icons_icons.dart';
import 'package:taskland/extensions/color_scheme_direct_access.dart';
import 'package:taskland/services/version_fetching.dart';
import 'package:taskland/widgets/container_button.dart';
import 'package:taskland/widgets/info_card.dart';
import 'package:taskland/widgets/version_card.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeSettingsTab extends StatefulWidget {
  const HomeSettingsTab({super.key});

  @override
  State<HomeSettingsTab> createState() => _HomeSettingsTabState();
}

class _HomeSettingsTabState extends State<HomeSettingsTab> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      children: [
        const ListTile(
          title: Text("Uygulama Hakkında"),
          contentPadding: EdgeInsets.zero,
          leading: Icon(Icons.info_outline_rounded),
        ),
        const SizedBox(height: 24),
        const VersionCard(),
        const SizedBox(height: 24),
        const InfoCard(
          icon: Icon(Icons.auto_awesome),
          title: "Ön Sürüm",
          description: "Uygulama hala geliştirme sürecindedir. "
              "Gördüğünüz özellikler ileride değişiklik gösterebilir ve "
              "uygulamada bazı kararsız davranışlar gözlemlenebilir. Bunları "
              "bildirirseniz çok memnun olurum. İlginiz için teşekkür ederim!",
        ),
        const SizedBox(height: 24),
        ContainerButton(
          onPressed: () {
            final url = Uri.parse('https://github.com/berkakkaya/taskland');
            launchUrl(url);
          },
          icon: const Icon(Icons.public_rounded),
          content: "Proje Sayfası",
        ),
        const SizedBox(height: 24),
        ContainerButton(
          onPressed: () {
            final url = Uri.parse(
                'https://github.com/berkakkaya/taskland-policies/blob/main/PRIVACY-POLICY.md');
            launchUrl(url);
          },
          icon: const Icon(Icons.verified_user_outlined),
          content: "Gizlilik Politikası",
        ),
        const SizedBox(height: 24),
        ContainerButton(
          onPressed: () {
            showLicensePage(
              context: context,
              applicationName: "Taskland",
              applicationVersion: "v${VersionFetchingService.version}",
              applicationLegalese: "Copyright (©) 2024 Berk Akkaya\n"
                  "Bu uygulama GPLv3 lisansı altında lisanslanmıştır. "
                  "Daha fazla bilgi için lütfen lisans sayfasını ziyaret edin.",
            );
          },
          icon: const Icon(Icons.code_rounded),
          content: "Açık Kaynak Lisansları",
        ),
        const SizedBox(height: 24),
        const ListTile(
          title: Text("Geliştirici"),
          contentPadding: EdgeInsets.zero,
          leading: Icon(Icons.computer_rounded),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: context.colorScheme.primaryContainer,
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    foregroundImage: NetworkImage(
                      "https://avatars.githubusercontent.com/u/31767631?v=4",
                    ),
                    radius: 36,
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Berk Akkaya",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Text(
                        "Yazılım Geliştirici",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ContainerButton(
                onPressed: () {
                  final url = Uri.parse('https://github.com/berkakkaya');
                  launchUrl(url);
                },
                icon: const Icon(CustomIcons.github),
                content: "GitHub",
                secondaryContainer: true,
              ),
              const SizedBox(height: 16),
              ContainerButton(
                onPressed: () {
                  final url = Uri.parse(
                      'https://www.linkedin.com/in/berk-akkaya-32001418a/');
                  launchUrl(url);
                },
                icon: const Icon(CustomIcons.linkedin),
                content: "LinkedIn",
                secondaryContainer: true,
              ),
              const SizedBox(height: 16),
              ContainerButton(
                onPressed: () {
                  final url = Uri.parse('https://mastodon.social/@berkakkaya');
                  launchUrl(url);
                },
                icon: const Icon(CustomIcons.mastodon),
                content: "Mastodon",
                secondaryContainer: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

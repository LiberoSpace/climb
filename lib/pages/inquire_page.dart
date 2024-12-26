import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

class InquirePage extends StatelessWidget {
  static String routerName = "Inquire";

  const InquirePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: const Text(
          '문의하기',
        ),
      ),
      body: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              child: MarkdownBody(
                data: '''
**안녕하세요. 클라임입니다!**  
**클라임을 이용해 주셔서 감사합니다.**
ㅤ
ㅤ
ㅤ
여러분의 소중한 의견은 앱을 업데이트하는데 큰 도움이 됩니다.
불편한 사항이 있거나 개선되었으면 하는 기능들을 편하게 작성해주세요!
ㅤ
ㅤ
ㅤ
문의하기 링크)
[https://forms.gle/sAPb32ochYusZ32A6](https://forms.gle/sAPb32ochYusZ32A6)
                ''',
                softLineBreak: true,
                onTapLink: (text, url, title) {
                  launchUrl(
                    Uri.parse(url!),
                  );
                },
                styleSheet: MarkdownStyleSheet(
                  a: Theme.of(context).textTheme.bodyMedium,
                  strong: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

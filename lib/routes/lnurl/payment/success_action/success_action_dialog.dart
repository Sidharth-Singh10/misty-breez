import 'package:auto_size_text/auto_size_text.dart';
import 'package:breez_translations/breez_translations_locales.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:l_breez/theme/theme.dart';
import 'package:l_breez/widgets/shareable_payment_row.dart';
import 'package:l_breez/widgets/single_button_bottom_bar.dart';

class SuccessActionDialog extends StatefulWidget {
  final String message;
  final String? url;

  const SuccessActionDialog({super.key, required this.message, this.url});

  @override
  State<StatefulWidget> createState() => SuccessActionDialogState();
}

class SuccessActionDialogState extends State<SuccessActionDialog> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final texts = context.texts();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: Theme.of(context).appBarTheme.systemOverlayStyle!.copyWith(
            systemNavigationBarColor: Theme.of(context).colorScheme.surface,
          ),
      child: Dialog.fullscreen(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(child: SizedBox.expand()),
              Text(
                texts.ln_url_success_action_title,
                style: themeData.dialogTheme.titleTextStyle,
              ),
              Column(
                children: [
                  widget.url == null
                      ? Message(widget.message)
                      : ShareablePaymentRow(
                          title: widget.message,
                          titleWidget: Message(widget.message),
                          sharedValue: widget.url!,
                          isURL: true,
                          isExpanded: true,
                          titleTextStyle: themeData.primaryTextTheme.displaySmall!.copyWith(fontSize: 16),
                          childrenTextStyle: themeData.primaryTextTheme.displaySmall!.copyWith(
                            fontSize: 12,
                            height: 1.5,
                            color: Colors.blue,
                          ),
                          iconPadding: EdgeInsets.zero,
                          tilePadding: EdgeInsets.zero,
                          childrenPadding: EdgeInsets.zero,
                        ),
                ],
              ),
              const Expanded(child: SizedBox.expand()),
              Theme(
                data: breezDarkTheme,
                child: SingleButtonBottomBar(
                  text: texts.lnurl_withdraw_dialog_action_close,
                  stickToBottom: false,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Message extends StatelessWidget {
  final String message;

  const Message(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, bottom: 8.0),
      child: Container(
        constraints: const BoxConstraints(
          maxHeight: 200,
          minWidth: double.infinity,
        ),
        child: Scrollbar(
          radius: const Radius.circular(16.0),
          thumbVisibility: true,
          child: SingleChildScrollView(
            child: AutoSizeText(
              message,
              style: themeData.primaryTextTheme.displaySmall!.copyWith(fontSize: 16),
              textAlign: message.length > 40 && !message.contains("\n") ? TextAlign.start : TextAlign.left,
            ),
          ),
        ),
      ),
    );
  }
}

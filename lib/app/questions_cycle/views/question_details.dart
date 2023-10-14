import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_one/app/questions_cycle/models/questions%20_model.dart';
import 'package:task_one/app/questions_cycle/styles/colors.dart';
import 'package:task_one/app/questions_cycle/styles/fonts.dart';
import 'package:task_one/helpers/application_dimentions.dart';
import 'package:webview_flutter/webview_flutter.dart';

class QuestionDetails extends StatefulWidget {
  final Item question;
  const QuestionDetails({
    super.key,
    required this.question,
  });

  @override
  State<QuestionDetails> createState() => _QuestionDetailsState();
}

class _QuestionDetailsState extends State<QuestionDetails> {
  var controller = WebViewController();
  AppDimentions appDimentions = AppDimentions();

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.question.link!));
  }

  @override
  Widget build(BuildContext context) {
    appDimentions.appDimentionsInit(context);
    return Scaffold(
      body: SafeArea(
          top: true,
          child: Column(
            children: [
              Container(
                height: appDimentions.availableheightWithAppBar * .12,
                decoration: BoxDecoration(
                  color: purple,
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 0),
                      blurRadius: 7,
                      blurStyle: BlurStyle.solid,
                      color: black.withOpacity(.5),
                    )
                  ],
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const BackButton(
                      color: white,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Container(
                      height: 50.h,
                      width: 50.w,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, 0),
                              blurRadius: 7,
                              blurStyle: BlurStyle.solid,
                              color: black.withOpacity(.5),
                            )
                          ],
                          image: DecorationImage(
                              image: NetworkImage(widget.question.owner!.profileImage!),
                              fit: BoxFit.cover)),
                    ),
                    SizedBox(
                      width: 50.w,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.elliptical(40, 200),
                              bottomRight: Radius.elliptical(40, 200),
                              bottomLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      child: Text(
                        widget.question.owner!.displayName!,
                        style: mainTextStyle.copyWith(
                            color: purple, fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Expanded(child: WebViewWidget(controller: controller)),
            ],
          )),
    );
  }
}

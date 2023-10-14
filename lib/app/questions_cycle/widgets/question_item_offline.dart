import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_one/app/questions_cycle/models/questions%20_model.dart';
import 'package:task_one/app/questions_cycle/models/questions_item_model.dart';
import 'package:task_one/app/questions_cycle/styles/colors.dart';
import 'package:task_one/app/questions_cycle/styles/fonts.dart';
import 'package:task_one/app/questions_cycle/views/question_details.dart';
import 'package:task_one/app/questions_cycle/views/question_details_offline.dart';
import 'package:task_one/helpers/application_dimentions.dart';
import 'package:task_one/helpers/navigation_helper.dart';
import 'package:task_one/services/local_services/sqlite_db.dart';

class QuestionItemOffline extends StatefulWidget {
  final QuestionItemModel question;
  const QuestionItemOffline({super.key, required this.question});

  @override
  State<QuestionItemOffline> createState() => _QuestionItemOfflineState();
}

class _QuestionItemOfflineState extends State<QuestionItemOffline> {
  DateTime? dateTime;
  List<String> tags = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dateTime = DateTime.fromMillisecondsSinceEpoch(widget.question.creditdate! * 1000);
    Future.microtask(() async {
      tags = await LocalDataBase().tags(widget.question.questionid!);
    });
    print(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    AppDimentions().appDimentionsInit(context);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigation().goToScreen(
          context, (context) => QuestionDetailsOffline(question: widget.question), (_) {}),
      child: Container(
        margin: const EdgeInsets.all(12),
        padding: EdgeInsets.zero,
        width: AppDimentions().availableWidth,
        decoration: BoxDecoration(
          color: purple.withOpacity(.7),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 0),
              blurRadius: 7,
              blurStyle: BlurStyle.solid,
              color: black.withOpacity(.7),
            )
          ],
          borderRadius: const BorderRadius.only(
              topLeft: Radius.elliptical(40, 200),
              bottomRight: Radius.elliptical(40, 200),
              bottomLeft: Radius.circular(20),
              topRight: Radius.circular(20)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  height: 50.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                            widget.question.profileimage!,
                          ),
                          fit: BoxFit.cover),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.elliptical(40, 200),
                          bottomRight: Radius.elliptical(40, 200),
                          bottomLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.question.displayname!,
                          style: mainTextStyle.copyWith(
                              color: white, fontSize: 18.sp, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 5.h,
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
                            widget.question.title!,
                            style: mainTextStyle.copyWith(
                                color: purple, fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
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
                            'Cerdit Date : ${dateTime!.year}/${dateTime!.month}/${dateTime!.day} ',
                            style:
                                mainTextStyle.copyWith(color: purple, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
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
                            widget.question.answerd! == 1
                                ? 'Answered and Count : ${widget.question.countanswerd}'
                                : "Not Answered ",
                            style:
                                mainTextStyle.copyWith(color: purple, fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                    tags.length,
                    (index) => Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.elliptical(40, 200),
                                  bottomRight: Radius.elliptical(40, 200),
                                  bottomLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                          child: Text(
                            tags[index],
                            style:
                                mainTextStyle.copyWith(color: purple, fontWeight: FontWeight.bold),
                          ),
                        )),
              ),
            ),
            SizedBox(
              height: 10.h,
            )
          ],
        ),
      ),
    );
  }
}

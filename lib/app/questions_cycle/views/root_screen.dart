// ignore_for_file: unused_local_variable, use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loadmore/loadmore.dart';
import 'package:provider/provider.dart';
import 'package:task_one/app/questions_cycle/models/questions_item_model.dart';
import 'package:task_one/app/questions_cycle/providers/question_provider.dart';
import 'package:task_one/app/questions_cycle/styles/colors.dart';
import 'package:task_one/app/questions_cycle/views/question_details.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:task_one/app/questions_cycle/widgets/app_bar_custom.dart';
import 'package:task_one/app/questions_cycle/widgets/question_item.dart';
import 'package:task_one/app/questions_cycle/widgets/question_item_offline.dart';
import 'package:task_one/helpers/application_dimentions.dart';
import 'package:task_one/services/local_services/sqlite_db.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  AppDimentions appDimentions = AppDimentions();
  bool result = false;

  void load() {
    print("load");
    context.read<QuestionProvider>().getAllQuestions();
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      result = await InternetConnection().hasInternetAccess;
      log(result.toString());
      if (result) {
        await context.read<QuestionProvider>().getAllQuestions();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    appDimentions.appDimentionsInit(context);
    final questionProviderWatch = context.watch<QuestionProvider>();
    final questionProviderRead = context.read<QuestionProvider>();
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            const AppBarCustom(),
            SizedBox(
              height: 20.h,
            ),
            Expanded(
              child: result
                  ? RefreshIndicator(
                      onRefresh: _refresh,
                      child: LoadMore(
                        isFinish: !questionProviderWatch.questions.hasMore!,
                        onLoadMore: _loadMore,
                        whenEmptyLoad: false,
                        delegate: const DefaultLoadMoreDelegate(),
                        child: ListView.builder(
                          itemBuilder: (BuildContext context, int index) {
                            return QuestionItem(
                              question: questionProviderWatch.questions.items![index],
                            );
                          },
                          itemCount: questionProviderWatch.questions.items!.length,
                        ),
                      ),
                    )
                  : FutureBuilder<List<QuestionItemModel>>(
                      future: LocalDataBase().getData(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.separated(
                              itemBuilder: (context, index) {
                                return QuestionItemOffline(question: snapshot.data![index]);
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: 10.h,
                                );
                              },
                              itemCount: snapshot.data!.length);
                        }

                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: purple,
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }

  Future<bool> _loadMore() async {
    print("onLoadMore");
    await Future.delayed(const Duration(seconds: 2));
    load();
    return true;
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 2));
    context.read<QuestionProvider>().getAllQuestions();

    load();
  }
}

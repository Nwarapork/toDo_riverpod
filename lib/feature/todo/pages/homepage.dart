import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_todo/common/models/task_model.dart';
import 'package:riverpod_todo/common/utils/constants.dart';
import 'package:riverpod_todo/common/widgets/appstyle.dart';
import 'package:riverpod_todo/common/widgets/custom_text.dart';
import 'package:riverpod_todo/common/widgets/reuseable_text.dart';
import 'package:riverpod_todo/common/widgets/width_spacer.dart';
import 'package:riverpod_todo/common/widgets/xpansion_tile.dart';
import 'package:riverpod_todo/feature/todo/controllers/todo/todo_provider.dart';
import 'package:riverpod_todo/feature/todo/controllers/xpansion_provider.dart';
import 'package:riverpod_todo/feature/todo/pages/add.dart';
import 'package:riverpod_todo/feature/todo/widgets/today_task.dart';
import 'package:riverpod_todo/feature/todo/widgets/todo_tile.dart';

import '../../../common/widgets/height_spacer.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with TickerProviderStateMixin {
  late final TabController tabController =
      TabController(length: 2, vsync: this);
  final TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ref.watch(todoStateProvider.notifier).refresh();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(85),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ReuseableText(
                          text: "Dashboard",
                          style: appstyle(18, AppConst.kLight, FontWeight.bold),
                        ),
                        Container(
                          width: 25.w,
                          height: 25.h,
                          decoration: const BoxDecoration(
                            color: AppConst.kLight,
                            borderRadius: BorderRadius.all(Radius.circular(9)),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const AddTask()));
                            },
                            child: const Icon(
                              Icons.add,
                              color: AppConst.kBkDark,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const HeightSpacer(height: 20),
                  CustomTextField(
                    hintText: "Search",
                    controller: search,
                    prefixIcon: Container(
                      padding: EdgeInsets.all(14.h),
                      child: GestureDetector(
                        onTap: null,
                        child: const Icon(
                          AntDesign.search1,
                          color: AppConst.kGreyLight,
                        ),
                      ),
                    ),
                    suffixIcon: const Icon(
                      FontAwesome.sliders,
                      color: AppConst.kGreyLight,
                    ),
                  ),
                  const HeightSpacer(height: 15)
                ],
              )),
        ),
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: ListView(
            children: [
              const HeightSpacer(height: 25),
              Row(
                children: [
                  const Icon(
                    FontAwesome.tasks,
                    size: 20,
                    color: AppConst.kLight,
                  ),
                  const WidthSpacer(width: 10),
                  ReuseableText(
                      text: "Task Today",
                      style: appstyle(18, AppConst.kLight, FontWeight.bold))
                ],
              ),
              const HeightSpacer(height: 25),
              Container(
                decoration: BoxDecoration(
                  color: AppConst.kBkLight,
                  borderRadius: BorderRadius.all(
                    Radius.circular(AppConst.kRadius),
                  ),
                ),
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: BoxDecoration(
                    color: AppConst.kGreyLight,
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppConst.kRadius),
                    ),
                  ),
                  controller: tabController,
                  labelPadding: EdgeInsets.zero,
                  isScrollable: false,
                  labelColor: AppConst.kBlueLight,
                  labelStyle:
                      appstyle(12, AppConst.kBlueLight, FontWeight.w700),
                  unselectedLabelColor: AppConst.kLight,
                  tabs: [
                    Tab(
                      child: SizedBox(
                        width: AppConst.kwidth * 0.5,
                        child: Center(
                          child: ReuseableText(
                              text: "Pending",
                              style: appstyle(
                                  16, AppConst.kBkDark, FontWeight.bold)),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        padding: EdgeInsets.only(left: 30.w),
                        width: AppConst.kwidth * 0.5,
                        child: Center(
                          child: ReuseableText(
                              text: "Completed",
                              style: appstyle(
                                  16, AppConst.kBkDark, FontWeight.bold)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const HeightSpacer(height: 20),
              SizedBox(
                height: AppConst.kHieght * 0.3,
                width: AppConst.kwidth,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(AppConst.kRadius),
                  ),
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      Container(
                          color: AppConst.kRed,
                          height: AppConst.kHieght * 0.3,
                          child: const TodayTasks()),
                      Container(
                        color: AppConst.kBkLight,
                        height: AppConst.kHieght * 0.3,
                      ),
                    ],
                  ),
                ),
              ),
              const HeightSpacer(height: 20),
              XpansionTile(
                  text: "Tomorrow's Task",
                  text2: "Tomorrow's tasks  are show here",
                  onExpansionChanged: (bool expanded) {
                    ref
                        .read(xpansionStateProvider.notifier)
                        .setStart(!expanded);
                  },
                  trailing: Padding(
                      padding: EdgeInsets.only(right: 12.0.w),
                      child: ref.watch(xpansionStateProvider)
                          ? const Icon(AntDesign.closecircleo,
                              color: AppConst.kLight)
                          : const Icon(
                              AntDesign.circledown,
                              color: AppConst.kBkLight,
                            )),
                  childern: [
                    TodoTile(
                      start: "3:00",
                      end: "05:00",
                      switcher: Switch(value: true, onChanged: (value) {}),
                    )
                  ]),
              const HeightSpacer(height: 20),
              XpansionTile(
                  text: DateTime.now()
                      .add(const Duration(days: 2))
                      .toString()
                      .substring(5, 10),
                  text2: "Day After tomorrow task",
                  onExpansionChanged: (bool expanded) {
                    ref
                        .read(xpansionState0Provider.notifier)
                        .setStart(!expanded);
                  },
                  trailing: Padding(
                      padding: EdgeInsets.only(right: 12.0.w),
                      child: ref.watch(xpansionState0Provider)
                          ? const Icon(AntDesign.closecircleo,
                              color: AppConst.kLight)
                          : const Icon(
                              AntDesign.circledown,
                              color: AppConst.kBkLight,
                            )),
                  childern: [
                    TodoTile(
                      start: "3:00",
                      end: "05:00",
                      switcher: Switch(value: true, onChanged: (value) {}),
                    )
                  ]),
            ],
          ),
        )));
  }
}



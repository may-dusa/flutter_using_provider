import 'dart:developer';

import 'package:animations/animations.dart';
import 'package:catalog/screens/newtask.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../themes/texttheme.dart';

import '../models/tasklist.dart';
import '../models/selectedtab.dart';

import '../widgets/tab.dart';
import '../widgets/buttons.dart';
import '../widgets/taskcard.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            centerTitle: false,
            title: Text(
              'My tasks',
              style: typography.headline1,
            ),
            actions: [
              OpenContainer(
                transitionDuration: const Duration(milliseconds: 500),
                closedBuilder: (context, openCreateTask) {
                  return RoundIconButton.notFilled(Icons.add, () {
                    openCreateTask();
                  });
                },
                closedShape: CircleBorder(),
                closedElevation: 0,
                openBuilder: (context, closeCreateTask) {
                  return NewTaskPage();
                },
                openShape: RoundedRectangleBorder(),
              ),
            ],
          ),
          body: MultiProvider(
            providers: [
              ChangeNotifierProvider<SelectedTab>(
                create: (context) => SelectedTab(),
              )
            ],
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  const StatusTabs(),
                  const SizedBox(
                    height: 16,
                  ),
                  Consumer<SelectedTab>(
                    builder: (context, value, child) {
                      if (value.selected == Status.upcoming) {
                        return UpcomingTaskListBody();
                      } else {
                        return CompletedTaskListBody();
                      }
                    },
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

class StatusTabs extends StatelessWidget {
  const StatusTabs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var status = context.watch<SelectedTab>();

    return Row(
      children: List.generate(
        2,
        (index) {
          bool isSelected = status.selected == Status.values[index];
          return GestureDetector(
            onTap: () {
              status.changeState();
            },
            child: AppTab(
              label: Status.values[index],
              isSelected: isSelected,
            ),
          );
        },
      ),
    );
  }
}

class UpcomingTaskListBody extends StatelessWidget {
  const UpcomingTaskListBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var list = context.watch<TaskList>();
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: list.upcomingTask.length,
          itemBuilder: (context, index) {
            var currentMap = list.totalList[list.upcomingTask[index]];
            return TaskCard(
              title: currentMap['title'],
              colorScheme: currentMap['colorScheme'],
              date: currentMap['date'],
              time: currentMap['time'],
              status: Status.upcoming,
              index: list.upcomingTask[index],
            );
          }),
    );
  }
}

class CompletedTaskListBody extends StatelessWidget {
  const CompletedTaskListBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var list = context.watch<TaskList>();
    return Expanded(
      child: ListView.builder(
          padding: const EdgeInsets.only(bottom: 24),
          itemCount: list.completedTask.length,
          itemBuilder: (context, index) {
            var currentMap = list.totalList[list.completedTask[index]];
            return TaskCard(
              title: currentMap['title'],
              colorScheme: currentMap['colorScheme'],
              date: currentMap['date'],
              time: currentMap['time'],
              status: Status.checked,
              index: list.completedTask[index],
            );
          }),
    );
  }
}

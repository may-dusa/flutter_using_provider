import 'package:catalog/models/newtaskdetails.dart';
import 'package:catalog/widgets/inputfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../themes/texttheme.dart';

import '../models/tasklist.dart';
import '../models/newtaskdetails.dart';

import '../widgets/buttons.dart';
import '../widgets/divider.dart';

DateTimeValues dtModel = DateTimeValues();

class NewTaskPage extends StatelessWidget {
  NewTaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dtModel.dateChanged(DateTime.now());
    dtModel.timeChange(TimeOfDay.now());

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          shadowColor: Colors.transparent,
          automaticallyImplyLeading: false,
          leading: RoundIconButton.notFilled(
            Icons.arrow_back,
            () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.transparent,
          centerTitle: false,
          title: Text(
            'Create new task',
            style: typography.headline1,
          ),
        ),
        body: Container(
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 32),
            child: NewTaskForm()),
      ),
    );
  }
}

class NewTaskForm extends StatelessWidget {
  const NewTaskForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<TaskTitle>(create: (_) => TaskTitle()),
        ChangeNotifierProvider<CardColors>(create: (context) => CardColors()),
        Provider<DateNames>(
          create: (_) => DateNames(),
        ),
        ChangeNotifierProvider<DateTimeValues>.value(value: dtModel),
      ],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 24,
              ),
              TitleInput(),
              ThinDivider(),
              const DateTimeWidget(),
              ThinDivider.withLine(),
              const ColorSelector(),
            ],
          ),
          const CreateTaskButton(),
        ],
      ),
    );
  }
}

class TitleInput extends StatelessWidget {
  final TextEditingController _tec = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var title = context.read<TaskTitle>();
    return GestureDetector(
      child: InputField(
        hintText: "Enter the title",
        controller: _tec,
        onChanged: (t) {
          title.title = t;
        },
      ),
    );
  }
}

class ColorSelector extends StatelessWidget {
  const ColorSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        child: Consumer<CardColors>(
          builder: (context, value, child) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(value.colorList.length, (index) {
                bool isSelected = value.selectedColor == index;
                return GestureDetector(
                  onTap: () {
                    value.changeColor(index);
                  },
                  child: Container(
                    height: 32,
                    width: 32,
                    margin: const EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      color: value.colorList[index],
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 2,
                        color: Colors.black.withOpacity(isSelected ? 0.5 : 0.0),
                      ),
                    ),
                  ),
                );
              }),
            );
          },
        ));
  }
}

class DateTimeWidget extends StatelessWidget {
  const DateTimeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DateField(),
        const SizedBox(
          width: 16,
        ),
        TimeField(),
      ],
    );
  }
}

class DateField extends StatelessWidget {
  Future<void> _selectDate(BuildContext context) async {
    var date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 1));
    if (date != null) {
      dtModel.dateChanged(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    var dateText = dtModel.dateToText(dtModel.selectedDate);

    return Expanded(
      child: GestureDetector(
        onTap: () {
          _selectDate(context);
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black87.withOpacity(0.8),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.event,
                size: 12,
                color: Colors.white,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                dateText,
                style: typography.bodyText2!.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TimeField extends StatelessWidget {
  Future<void> _selectTime(BuildContext context) async {
    var timeChanger = context.read<DateTimeValues>();
    var time =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (time != null) {
      timeChanger.timeChange(time);
    }
  }

  @override
  Widget build(BuildContext context) {
    var timeText = dtModel.timeToText(dtModel.selectedTime);

    return Expanded(
      child: GestureDetector(
        onTap: () {
          _selectTime(context);
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black87.withOpacity(0.8),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.schedule,
                size: 12,
                color: Colors.white,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                timeText,
                style: typography.bodyText2!.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CreateTaskButton extends StatelessWidget {
  const CreateTaskButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = context.read<CardColors>();
    var title = context.read<TaskTitle>();
    var dateTime = context.read<DateTimeValues>();

    var taskList = context.read<TaskList>();

    return ExpandedTextButton(
      title: 'Create Task',
      onPressFn: () {
        taskList.add([
          title.title,
          color.colorList[color.selectedColor],
          dateTime.dateToText(dateTime.selectedDate),
          dateTime.timeToText(dateTime.selectedTime),
        ]);
        Navigator.pop(context);
      },
    );
  }
}

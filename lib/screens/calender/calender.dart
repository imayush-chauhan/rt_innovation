import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rt_innovation/bloc/add_employee.dart';
import 'package:rt_innovation/data/data.dart';
import 'package:rt_innovation/utils/color.dart';
import 'package:rt_innovation/utils/textStyle.dart';
import 'package:table_calendar/table_calendar.dart';

class MyCalenderToday extends StatelessWidget {
  const MyCalenderToday({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Scaffold(
        backgroundColor: MyColor.backgroundPopup,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: BlocBuilder<AddToday,DateTime?>(
              builder: (context,state){
                if(state == null){ return const SizedBox();}
                return GestureDetector(
                  onTap: (){},
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Wrap(
                            spacing: 10,
                            children: [
                              MaterialButton(
                                onPressed: () async{
                                  BlocProvider.of<AddToday>(context).setStr(DateTime.now());
                                  await Future.delayed(const Duration(milliseconds: 50));
                                  Navigator.of(context).pop();
                                },
                                color: MyColor.mainLight,
                                height: 35,
                                minWidth: 140,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6)
                                ),
                                child: Text("Today",
                                  style: MyTextStyle.fontF2,),
                              ),
                              MaterialButton(
                                onPressed: ()async{
                                  if(DateTime.now().weekday != 1){
                                    BlocProvider.of<AddToday>(context).setStr(DateTime.now().add(Duration(days: 8 - DateTime.now().weekday)));
                                  }else{
                                    BlocProvider.of<AddToday>(context).setStr(DateTime.now());
                                  }
                                  await Future.delayed(const Duration(milliseconds: 50));
                                  Navigator.of(context).pop();
                                },
                                color: MyColor.mainLight,
                                height: 35,
                                minWidth: 140,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6)
                                ),
                                child: Text("Next Monday",
                                  style: MyTextStyle.fontF2,),
                              ),
                              MaterialButton(
                                onPressed: ()async{
                                  if(DateTime.now().weekday != 1){
                                    BlocProvider.of<AddToday>(context).setStr(DateTime.now().add(Duration(days: 9 - DateTime.now().weekday)));
                                  }else{
                                    BlocProvider.of<AddToday>(context).setStr(DateTime.now());
                                  }
                                  await Future.delayed(const Duration(milliseconds: 50));
                                  Navigator.of(context).pop();
                                },
                                color: MyColor.mainLight,
                                height: 35,
                                minWidth: 140,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6)
                                ),
                                child: Text("Next Tuesday",
                                  style: MyTextStyle.fontF2,),
                              ),
                              MaterialButton(
                                onPressed: ()async{
                                  BlocProvider.of<AddToday>(context).setStr(DateTime.now().add(const Duration(days: 7)));
                                  await Future.delayed(const Duration(milliseconds: 50));
                                  Navigator.of(context).pop();
                                },
                                color: MyColor.mainLight,
                                height: 35,
                                minWidth: 140,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6)
                                ),
                                child: Text("After 1 week",
                                  style: MyTextStyle.fontF2,),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 340,
                            child: TableCalendar(
                              firstDay: DateTime.utc(2020, 10, 16),
                              lastDay: DateTime.utc(2030, 3, 14),
                              focusedDay: state,
                              currentDay: state,
                              calendarFormat: CalendarFormat.month,
                              rowHeight: 42.5,
                              calendarStyle: CalendarStyle(
                                  todayTextStyle: MyTextStyle.fontE1,
                                  defaultTextStyle: MyTextStyle.fontE,
                                  weekendTextStyle: MyTextStyle.fontE,
                                  outsideTextStyle: const TextStyle(
                                      color: Colors.transparent,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16
                                  ),
                                  todayDecoration: const BoxDecoration(
                                      color: MyColor.main,
                                      shape: BoxShape.circle
                                  )
                              ),
                              headerStyle: const HeaderStyle(
                                formatButtonVisible : false,
                                titleCentered: true,
                              ),
                              onDaySelected: (selectedDay, focusedDay) {
                                BlocProvider.of<AddToday>(context).setStr(focusedDay);
                              },
                            ),
                          ),

                          SizedBox(
                            height: 64,
                            child: Column(
                              children: [
                                const Divider(height: 2,color: MyColor.border,),
                                SizedBox(
                                  height: 60,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(Icons.calendar_month,color: MyColor.main,),
                                            const SizedBox(width: 5,),
                                            Text("${state.day} ${Data.month[state.month] ?? "-" } ${state.year}",
                                              style: MyTextStyle.fontD1,)
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            MaterialButton(
                                              onPressed: (){
                                                BlocProvider.of<AddToday>(context).clean();
                                                Navigator.of(context).pop();
                                              },
                                              color: MyColor.mainLight,
                                              height: 40,
                                              minWidth: 73,
                                              elevation: 0,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(6)
                                              ),
                                              child: Text("Cancel",
                                                style: MyTextStyle.fontL1,),
                                            ),
                                            const SizedBox(width: 30,),
                                            MaterialButton(
                                              onPressed: (){
                                                Navigator.of(context).pop();
                                              },
                                              color: MyColor.main,
                                              height: 40,
                                              minWidth: 73,
                                              elevation: 0,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(6)
                                              ),
                                              child: Text("Save",
                                                style: MyTextStyle.fontL,),
                                            ),

                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )

                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}


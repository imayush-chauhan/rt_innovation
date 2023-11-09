import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rt_innovation/bloc/add_employee.dart';
import 'package:rt_innovation/bloc/cubit.dart';
import 'package:rt_innovation/data/data.dart';
import 'package:rt_innovation/screens/calender/calender.dart';
import 'package:rt_innovation/screens/calender/calenderNoToday.dart';
import 'package:rt_innovation/screens/employee_list.dart';
import 'package:rt_innovation/utils/color.dart';
import 'package:rt_innovation/utils/snackbar.dart';
import 'package:rt_innovation/utils/textField.dart';
import 'package:rt_innovation/utils/textStyle.dart';

// ignore: must_be_immutable
class AddEmployeeDetails extends StatelessWidget {
  final bool edit;
  final String editName;
  final int inx;
  AddEmployeeDetails({Key? key, required this.edit, required this.editName, required this.inx}) : super(key: key);

  final name = TextEditingController();
  bool first = true;
  final List<String> role = [
    "Product Developer",
    "Flutter Developer",
    "QA Tester",
    "Product Owner",
  ];

  @override
  Widget build(BuildContext context) {
    if(first){ name.text = editName; first = false;}
    return WillPopScope(
      onWillPop: () async{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
          return EmployeeList();
        }));
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: edit == false ?
        AppBar(
          backgroundColor: MyColor.main,
          elevation: 0,
          leading: const SizedBox(),
          leadingWidth: 0,
          title: Text("Add Employee Details", style: MyTextStyle.fontA),
        ) : AppBar(
          backgroundColor: MyColor.main,
          elevation: 0,
          leading: const SizedBox(),
          leadingWidth: 0,
          title: Text("Edit Employee Details", style: MyTextStyle.fontA),
          actions:  [
             Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: ()async{
                  await BlocProvider.of<EmployeeData>(context).deleteDataAt(inx);
                  await Future.delayed(const Duration(milliseconds: 50));
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                    return EmployeeList();
                  }));
                },
                  child: const Icon(Icons.delete_outline,color: MyColor.white,)),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: BlocBuilder<AddRole, String?>(
            builder: (context,state){
              return Column(
                children: [
                  MyTextField.textField("Employee name", name, TextInputType.name, true),
                  selectRole(context,state),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      timeStart(context),
                      const Icon(Icons.arrow_forward,color: MyColor.main,size: 20,),
                      timeEnd(context),
                    ],
                  )
                ],
              );
            },
          ),
        ),
        bottomNavigationBar: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: SizedBox(
            height: 64,
            child: Column(
              children: [
                const Divider(height: 2,color: MyColor.border,),
                SizedBox(
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MaterialButton(
                          onPressed: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                              return EmployeeList();
                            }));
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
                          onPressed: ()async{
                            if(name.text.isEmpty){
                              snackBar(context, "Enter Employee Name");
                              return;
                            }
                            if(context.read<AddRole>().state == null){
                              snackBar(context, "Select Employee Role");
                              return;
                            }
                            if(context.read<AddToday>().state == null || context.read<NoToday>().state == null){
                              snackBar(context, "Select Joining and Leaving Date");
                              return;
                            }
                            DateTime today = context.read<AddToday>().state!;
                            DateTime noToday = context.read<NoToday>().state!;

                            Map<dynamic,dynamic> data = {
                              "name": name.text,
                              "role": context.read<AddRole>().state,
                              "today": today.toString(),
                              "noday": noToday.toString(),
                              "time": "${today.day} ${Data.month[today.month] ?? "-" } ${today.year}",
                              "timeLeaving": "${noToday.day} ${Data.month[noToday.month] ?? "-" } ${noToday.year}",
                              "check": int.parse("${noToday.year}${noToday.month.toString().padLeft(2,"0")}${noToday.day.toString().padLeft(2,"0")}",)
                            };
                            if(edit){
                              await BlocProvider.of<EmployeeData>(context).editData(data,inx);
                            }else{
                              await BlocProvider.of<EmployeeData>(context).addData(data);
                            }
                            await Future.delayed(const Duration(milliseconds: 50));
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                              return EmployeeList();
                            }));
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
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  selectRole(BuildContext context,String? state){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        onTap: (){
          showModalBottomSheet(
              context: context,
              elevation: 10,
              useSafeArea: true,
              builder: (context) {
                return Container(
                  decoration:const  BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30), topLeft: Radius.circular(30)),
                    color: MyColor.white
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(role.length, (index) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: (){
                              BlocProvider.of<AddRole>(context).setStr(role[index]);
                              Navigator.of(context).pop();
                            },
                            child: SizedBox(
                              height: 50,
                              width: double.infinity,
                              child: Center(child: Text(role[index])),
                            ),
                          ),
                          const Divider(),
                        ],
                      );
                    }),
                  ),
                );
              });
        },
        child: Container(
          height: 40,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: MyColor.border)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 13),
                    child: Icon(Icons.work_outline,color: MyColor.main,size: 20,),
                  ),
                  state == null ?
                  Text("Select role",style: MyTextStyle.fontD,) :
                  Text(state,style: MyTextStyle.fontD1,)
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Icon(Icons.arrow_drop_down_sharp,color: MyColor.main),
              ),
            ],
          ),
        ),
      ),
    );
  }

  timeStart(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: BlocBuilder<AddToday,DateTime?>(
        builder: (context,state){
          return InkWell(
            onTap: (){
              if(state == null){
                BlocProvider.of<AddToday>(context).setStr(DateTime.now());
              }
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const MyCalenderToday();
                  });
            },
            child: Container(
              height: 40,
              width: 140,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: MyColor.border)
              ),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 13),
                    child: Icon(Icons.calendar_month,color: MyColor.main,size: 20,),
                  ),
                  state == null ?
                  Text("Today",style: MyTextStyle.fontF1,) :
                  Text("${state.day} ${Data.month[state.month] ?? "-" } ${state.year}",style: MyTextStyle.fontF1,)
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  timeEnd(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: BlocBuilder<NoToday,DateTime?>(
        builder: (context,state){
          return InkWell(
            onTap: (){
              if(state == null){
                BlocProvider.of<NoToday>(context).setStr(DateTime.now());
              }
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const MyCalenderNoToday();
                  });
            },
            child: Container(
              height: 40,
              width: 140,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: MyColor.border)
              ),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 13),
                    child: Icon(Icons.calendar_month,color: MyColor.main,size: 20,),
                  ),
                  state == null ?
                  Text("No Date",style: MyTextStyle.fontF1,) :
                  Text("${state.day} ${Data.month[state.month] ?? "-" } ${state.year}",style: MyTextStyle.fontF1,)
                ],
              ),
            ),
          );
        },
      ),
    );
  }



}

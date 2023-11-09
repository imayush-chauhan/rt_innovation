import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rt_innovation/bloc/add_employee.dart';
import 'package:rt_innovation/bloc/cubit.dart';
import 'package:rt_innovation/screens/addEmployeeDetails.dart';
import 'package:rt_innovation/utils/color.dart';
import 'package:rt_innovation/utils/textStyle.dart';

class EmployeeList extends StatefulWidget {
  const EmployeeList({Key? key}) : super(key: key);

  @override
  State<EmployeeList> createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {

  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    context.read<EmployeeData>().getData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColor.main,
        elevation: 0,
        title: Text("Employee List", style: MyTextStyle.fontA),
      ),
      bottomNavigationBar: Container(
        height: 50,
        width: double.infinity,
        color: Colors.grey.shade300,
        child: Align(
          alignment: Alignment.centerLeft*0.9,
          child: Text("Swipe Left To Delete",
            style: MyTextStyle.fontE,),
        ),
      ),
      body: BlocBuilder<EmployeeData, List<dynamic>>(
        builder: (context,state){
          if(state.isEmpty){
            return Center(child: SvgPicture.asset("assets/images/no_employee.svg"));
          }
          List<dynamic> current = state.where((element) => element["check"] >= int.parse("${dateTime.year}${dateTime.month.toString().padLeft(2,"0")}${dateTime.day.toString().padLeft(2,"0")}",)).toList();
          List<dynamic> previous = state.where((element) => element["check"] < int.parse("${dateTime.year}${dateTime.month.toString().padLeft(2,"0")}${dateTime.day.toString().padLeft(2,"0")}",)).toList();

          return SingleChildScrollView(
            child: Column(
              children: [
                current.isNotEmpty ?
                Column(
                  children: [
                    Container(
                      height: 50,
                      width: double.infinity,
                      color: Colors.grey.shade300,
                      child: Align(
                        alignment: Alignment.centerLeft*0.9,
                        child: Text("Current Employee",
                          style: MyTextStyle.fontC4,),
                      ),
                    ),
                    Column(
                      children: List.generate(current.length, (index) => card(context,index,current,state)),
                    ),
                  ],
                ) : const SizedBox(),

                previous.isNotEmpty ?
                Column(
                  children: [
                    Container(
                      height: 50,
                      width: double.infinity,
                      color: Colors.grey.shade300,
                      child: Align(
                        alignment: Alignment.centerLeft*0.9,
                        child: Text("Previous Employee",
                          style: MyTextStyle.fontC4,),
                      ),
                    ),
                    Column(
                      children: List.generate(previous.length, (index) => card(context,index,previous,state)),
                    ),
                  ],
                ) : const SizedBox(),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          BlocProvider.of<AddRole>(context).clean();
          BlocProvider.of<AddToday>(context).clean();
          BlocProvider.of<NoToday>(context).clean();
          await Navigator.push(context, MaterialPageRoute(builder: (context){
            return AddEmployeeDetails(edit: false,editName: "",inx: 0,);
          })).then((value) {
            setState(() {});
          });

        },
        backgroundColor: MyColor.main,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(Icons.add,color: MyColor.white,),
      ),
    );
  }

  card(BuildContext context,int index, List<dynamic> state, List<dynamic> data){
    return Dismissible(
      key: Key(state[index].toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight*0.9,
        child: const Icon(Icons.delete_outline,color: MyColor.white,),
      ),
      onDismissed: (_){
        BlocProvider.of<EmployeeData>(context).deleteData(state[index]);
      },
      child: ListTile(
        onTap: () async{
          BlocProvider.of<AddRole>(context).setStr(state[index]["role"]);
          BlocProvider.of<AddToday>(context).setStr(DateTime.parse(state[index]["today"]));
          BlocProvider.of<NoToday>(context).setStr(DateTime.parse(state[index]["noday"]));
          await Navigator.push(context, MaterialPageRoute(builder: (context){
            return AddEmployeeDetails(edit: true,editName: state[index]["name"],inx: data.indexOf(state[index]),);
          })).then((value) {
            setState(() {});
          });
        },
        title: Text(state[index]["name"],style: MyTextStyle.fontC1,),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(state[index]["role"],style: MyTextStyle.fontC2,),
            const SizedBox(height: 2,),
            Text(state[index]["time"],style: MyTextStyle.fontC3,),
          ],
        ),
      ),
    );
  }
}


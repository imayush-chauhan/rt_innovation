import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rt_innovation/main.dart';

class EmployeeData extends Cubit<List<dynamic>>{
  EmployeeData(): super([]);

  final str = "employeeData";

  getData() async{
    emit(await box.get(str) ?? []);
  }

  addData(Map<dynamic,dynamic> ed) async{
    List<dynamic> data = await box.get(str) ?? [];
    data.add(ed);
    await box.put(str,data);
    emit(await box.get(str) ?? []);
  }

  deleteData(Map<dynamic,dynamic> inx) async{
    List<dynamic> data = await box.get(str) ?? [];
    data.remove(inx);
    await box.put(str,data);
    emit(await box.get(str) ?? []);
  }

  deleteDataAt(int inx) async{
    List<dynamic> data = await box.get(str) ?? [];
    data.removeAt(inx);
    await box.put(str,data);
    emit(await box.get(str) ?? []);
  }

  editData(Map<dynamic,dynamic> ed,int inx) async{
    List<dynamic> data = await box.get(str) ?? [];
    data[inx] = ed;
    await box.put(str,data);
    emit(await box.get(str) ?? []);
  }


}
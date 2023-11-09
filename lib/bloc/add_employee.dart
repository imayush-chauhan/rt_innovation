import 'package:flutter_bloc/flutter_bloc.dart';

class AddRole extends Cubit<String?>{
  AddRole(): super(null);

  void setStr(String str){
    emit(str);
  }

  void clean(){
    emit(null);
  }

}

class AddToday extends Cubit<DateTime?>{
  AddToday(): super(null);

  void setStr(DateTime str){
    emit(str);
  }

  void clean(){
    emit(null);
  }

}

class NoToday extends Cubit<DateTime?>{
  NoToday(): super(null);

  void setStr(DateTime str){
    emit(str);
  }

  void clean(){
    emit(null);
  }

}

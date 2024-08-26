
import '../database/local/db_helper.dart';

class ListModel {
  String title;
  String desc;
  int? s_no;
  int? isComp;

  ListModel({required this.title, required this.desc, this.s_no,this.isComp});

  factory ListModel.fromMap({required Map<String, dynamic> map}) {
    return ListModel(
        title: map[DbHelper.table_Col_Title],
        desc: map[DbHelper.table_Col_Desc],
        s_no: map[DbHelper.table_Col_S_no],
      isComp: map[DbHelper.table_Col_IsComp]
    );
  }

  Map<String, dynamic> toMap() {
    return {
      DbHelper.table_Col_Title: title,
      DbHelper.table_Col_Desc: desc,
      DbHelper.table_Col_S_no: s_no,
      DbHelper.table_Col_IsComp : isComp
    };
  }
}

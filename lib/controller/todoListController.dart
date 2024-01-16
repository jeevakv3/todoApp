import '../allpackages.dart';

class ToDoListController extends GetxController {
  MysqlService mysqlService = MysqlService();
  List<ToDoListModel> response = [];
  var isLoad = false.obs;

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  Future<void> fetchData() async {
    isLoadingBar('fetchData', true);
    List<dynamic> data = await ApiService().getData();
    print('Data -----123 $data');

    List<Map<String, dynamic>> insertData =
        data.whereType<Map<String, dynamic>>().toList();
    final db = await mysqlService.openDataBase();
    if (db != null) {
      var dbdata = await db.query('todoList');
      if (dbdata.isNotEmpty) {
        response = dbdata.map((e) => ToDoListModel.fromJson(e)).toList();
        isLoadingBar('fetchData', false);
      } else {
        mysqlService.insertData(insertData);
        fetchData();
      }
      print('sqlData -- $response');
    }
    update(['fetchData']);
  }

  Future<void> updateData(Map<String, dynamic> data, int id, int userId) async {
    isLoadingBar('upDateData', true);
    final db = await mysqlService.openDataBase();
    if (db != null) {
      await mysqlService.updateData(data, id, userId);
      await fetchData();
      isLoadingBar('upDateData', false);
      Get.back();
    }
  }

  isLoadingBar(type, isLoad) {
    this.isLoad.value = isLoad;
    update([type]);
  }
}

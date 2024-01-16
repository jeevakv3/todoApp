import '../allpackages.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({Key? key}) : super(key: key);

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  bool isCheckBox = true;

  var controller = Get.put(ToDoListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'ToDo Items',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: GetBuilder<ToDoListController>(
          id: 'fetchData',
          builder: (_) {
            return controller.isLoad.value == true
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: controller.response.length,
                    itemBuilder: (context, index) {
                      var data = controller.response[index];
                      print(data.completed);
                      bool isCheck = data.completed == '0' ? false : true;
                      return InkWell(
                        onTap: () {
                          if (data.completed == '0') {
                            Get.to(ToDoListEdit(
                              data: data,
                            ));
                          }
                        },
                        child: Card(
                          elevation: 2,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: ListTile(
                            title: Text(
                                'userId : ${data.userId != null ? data.userId : '-'}'),
                            subtitle:
                                Text(data.title != null ? data.title! : '-'),
                            leading: Checkbox(
                                value: isCheck,
                                onChanged: (value) {
                                  setState(() {
                                    isCheckBox = value!;
                                  });
                                }),
                          ),
                        ),
                      );
                    });
          }),
    );
  }
}

class ToDoListEdit extends StatefulWidget {
  ToDoListModel data;
  ToDoListEdit({required this.data});

  @override
  State<ToDoListEdit> createState() => _ToDoListEditState();
}

class _ToDoListEditState extends State<ToDoListEdit> {
  TextEditingController userIdController = TextEditingController();
  TextEditingController IdController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController isCompletedController = TextEditingController();

  var controller = Get.put(ToDoListController());

  @override
  void initState() {
    super.initState();
    userIdController.text = widget.data.userId.toString();
    IdController.text = widget.data.id.toString();
    titleController.text = widget.data.title.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'ToDo Items Edit',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              enabled: false,
              controller: userIdController,
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: titleController,
            ),
            const SizedBox(
              height: 100,
            ),
            InkWell(
              onTap: () {
                if (titleController.text.isNotEmpty) {
                  Map<String, dynamic> data = {
                    'title': titleController.text,
                    'completed': 'true'
                  };
                  controller.updateData(
                      data, widget.data.id!, widget.data.userId!);
                }
              },
              child: Container(
                height: 55,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(15)),
                child: const Center(
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

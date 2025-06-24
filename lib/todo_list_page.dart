import 'package:flutter/material.dart';
import 'package:todoapp/add_task_form.dart';
import 'package:todoapp/task.dart';
import 'package:todoapp/task_detailed_page.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

   @override
  State<TodoListPage> createState() => _TodoListPageState();

}

class _TodoListPageState extends State<TodoListPage>{

  List listDummyTasks = Task.getDummyTaskList();

  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
      //backgroundColor: Colors.white,
      appBar: AppBar(
        //backgroundColor: Colors.blue,
        title: Text('Todo List')
      ),


      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){ 
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddTaskForm()));
        },),


      body: ListView.separated(
        itemCount: listDummyTasks.length,
        itemBuilder: (context, index){
          Task thisTask = listDummyTasks[index];
        return ListTile(
          onTap: (){
            MaterialPageRoute route = MaterialPageRoute(builder: (BuildContext context){
              return TaskDetailedPage(thisTask, updateListItemByIndex);
            });
            Navigator.of(context).push(route);
          },
          title: Text(thisTask.title,
          style: TextStyle(decoration:(thisTask.status == 'Complete')?TextDecoration.lineThrough : TextDecoration.none ),),
          subtitle: Text(thisTask.description),
          trailing: Checkbox(value: thisTask.status == 'Complete', onChanged: (bool? value){ 

            if(value == true){
              thisTask.status = 'Complete';
            }else{
              thisTask.status = 'Incomplete';
            }
           updateListItemByIndex(thisTask);

          }),
        );
      }, 
      separatorBuilder: (BuildContext context, int index) {  
        return Divider();
      },)
    );
  }

  updateListItemByIndex(Task task){
    int index = listDummyTasks.indexWhere((element) => element.taskId == task.taskId);

     listDummyTasks[index] = task;

    setState(() {});
  }
  
 
}
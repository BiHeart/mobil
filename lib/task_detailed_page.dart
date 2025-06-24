import 'package:flutter/material.dart';
import 'package:todoapp/edit_task_form.dart';

import 'task.dart';

class TaskDetailedPage extends StatefulWidget {

  late Task task;

  Function(Task task) updateListItem;

  TaskDetailedPage(this.task, this.updateListItem);
  
  @override
  State<StatefulWidget> createState() {
    return _TaskDetailPageState();
  }

}

class _TaskDetailPageState extends State<TaskDetailedPage>{

  bool _deleted = false;
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        title: Text('Task details'),
        actions: [
          IconButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context){return EditTaskForm(widget.task);})); // a return... helyett lehet használni a (context) => EditTaskForm cuccot is
           }, icon: Icon(Icons.edit)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
      child: (_deleted)?Text('Task deleted'): Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.task.title, 
          style: TextStyle(fontSize: 20),),
          Text(widget.task.status, 
          style: TextStyle(color: (widget.task.status=='Incomplete')?Colors.red:Colors.green, fontWeight: FontWeight.bold)),
          Text(widget.task.description),
          SizedBox(height: 10,),
          Row(
            children: [
              ElevatedButton(
                onPressed: (){
                  
                  if(widget.task.status=='Incomplete'){
                    widget.task.status = 'Complete';
                  }else{
                    widget.task.status = 'Incomplete';
                  }

                  setState(() {
                    
                  });

                  widget.updateListItem(widget.task);


              }, child: Text((widget.task.status=='Incomplete')?'Mark as Complete':'Mark as Incomplete'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue)),
                SizedBox(width: 10,),
              ElevatedButton(onPressed: (){
                  showDialog(context: context, barrierDismissible: false,builder: (context){
                        return AlertDialog(
                          title: Text('Confirm delete'),
                          content: Text('Are you sure to delete this task?'),
                          actions: [OutlinedButton(onPressed: (){
                            _deleteTask();
                          },
                                   child: Text('Yes', style: TextStyle(color: Colors.amber),)), 
                                   OutlinedButton(onPressed: (){
                                    Navigator.of(context).pop();
                                   },
                                    child: Text('No', style: TextStyle(color: Colors.amber),))],
                        );
                  });

              },
               child: Text('Delete task'), 
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),)
            ],
          )
        ],
      ),
    
    ));
  }

  _deleteTask(){

    Navigator.of(context).pop();

    setState(() {
      _deleted = true;
    });

    
  }
  
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/shared/cubit/cubit/cubit.dart';
import 'package:todo/shared/cubit/states/states.dart';
import 'package:todo/shared/shared/components.dart';
import 'package:conditional_builder/conditional_builder.dart';


class NewTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
      listener: (context , state){},
      builder: (context,state) {
        var tasks= AppCubit.get(context).newtasks;
        return ConditionalBuilder (
          condition: tasks.length > 0 ,
          builder: (context)=>ListView.separated(
            itemBuilder: (context,index) => defautTaskItem(tasks[index],context),
            separatorBuilder: (context,index) => Container(),
            itemCount:tasks.length,
          ),
          fallback: (context) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.menu,size: 100, color:Colors.grey),
                Text('No Tasks Yet , Please Add New Tasks',style: TextStyle(fontSize: 16,color: Colors.grey),),
              ],
            ),
          ),
        );}
    );
  }
}

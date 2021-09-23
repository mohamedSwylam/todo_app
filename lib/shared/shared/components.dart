import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:todo/shared/cubit/cubit/cubit.dart';


Widget defaultFormField({
  Color cursorColor,
  @required TextInputType type,
  @required TextEditingController controller,
  @required String labelText,
  Color labelColor,
  double borderRaduis,
  Color borderColor,
  IconData prefix,
  Color iconColor,
  Color focusColor,
  Color fillcolor,
  double focusedBorderRaduis,
  Color focusdborderColor,
  double enabledBorderRaduis,
  Color enabledBorderColor,
  double errorBorderRaduis,
  Color errorBorderColor,
  @required Function validate,
  Function onTap,
}) =>
    TextFormField(
      onTap: onTap,
      validator: validate,
      cursorColor: cursorColor,
      keyboardType: type,
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: labelColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRaduis),
          borderSide: BorderSide(
            color: borderColor,
          ),
        ),
        prefixIcon: Icon(
          prefix,
          color: iconColor,
        ),
        focusColor: focusColor,
        fillColor: fillcolor,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(focusedBorderRaduis),
          borderSide: BorderSide(
            color: focusdborderColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(enabledBorderRaduis),
          borderSide: BorderSide(
            color: enabledBorderColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(errorBorderRaduis),
          borderSide: BorderSide(
            color: errorBorderColor,
          ),
        ),
      ),
    );
Widget defautTaskItem(Map model,context)=>Dismissible(
  key: Key(model['id'].toString()),
  child:   Padding(

  padding: const EdgeInsets.all(20.0),

  child: Row(

  crossAxisAlignment: CrossAxisAlignment.start,

  children: [

  CircleAvatar(

  backgroundColor: Colors.teal,

  radius: 35,

  child: Text('${model['time']}',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),

  ),

  SizedBox(width: 20,),

  Expanded(

  child: Padding(

  padding: const EdgeInsets.symmetric(vertical: 15),

  child: Column(

  mainAxisSize: MainAxisSize.min,

  crossAxisAlignment: CrossAxisAlignment.start,

  children: [

  Text ('${model['title']}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.white),),

  Text ('${model['date']}',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),),

  ],

  ),

  ),

  ),

  SizedBox(width: 25,),

  Padding(

  padding: const EdgeInsets.symmetric(vertical: 10),

  child: IconButton(onPressed: (){

    AppCubit.get(context).updateDatabase(status: 'done', id: model['id']);

  }, icon: Icon(Icons.check_circle_outline),color: Colors.white,),

  ),

  Padding(

  padding: const EdgeInsets.symmetric(vertical: 10),

  child: IconButton(onPressed: (){

    AppCubit.get(context).updateDatabase(status: 'archived', id: model['id']);

  }, icon: Icon(Icons.archive_outlined),color: Colors.white,),

  ),

  ],

  ),

  ),
  onDismissed: (direction){
    AppCubit.get(context).deleteDatebase(id: model['id']);
  },
);
Widget taskBuilder({
  @required List <Map> tasks,
})=> ConditionalBuilder (
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
);

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'commonList.dart';
import 'editDatas.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GlobalList.data.isEmpty?const Center(child: Text('Add Todo')):ListView.builder(
        itemCount: GlobalList.data.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: ()async{
                await Navigator.push(context, MaterialPageRoute(builder: (context) => EditDataPage(data: GlobalList.data[index],index: index),));
                setState((){});
                },
              child: Slidable(
                endActionPane:ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      autoClose: true,
                      flex: 2,
                      backgroundColor: const Color(0xFFFE4A49),
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete', onPressed: (BuildContext context) {
                        setState(() {
                          GlobalList.data.removeAt(index);
                        });
                    },
                    ),
                  ],
                ) ,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5,
                            spreadRadius: 2,
                            offset: Offset(2, 2))
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.black26)
                              ),
                              child: Row(
                                children: [
                                  Expanded(child: Text('${GlobalList.data[index]['title']}')),
                                ],
                              ),
                            )
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.grey)
                              ),
                              child: Row(
                                children: [
                                  Expanded(child: Text('${GlobalList.data[index]['message']}')),
                                ],
                              ),
                            )
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          await showDialog(context: context, builder: (context) {
            return
              const AlertForm();
          },);
          setState((){});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AlertForm extends StatefulWidget {
  const AlertForm({super.key});

  @override
  State<AlertForm> createState() => _AlertFormState();
}

class _AlertFormState extends State<AlertForm> {
  TextEditingController controllerTitle=TextEditingController();
  TextEditingController controllerMessage=TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      spreadRadius: 2,
                      offset: Offset(2, 2))
                ]),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text('Add Details',style: TextStyle(fontSize: 25,color: Colors.black26)),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 50,
                        child: TextFormField(
                          controller: controllerTitle,
                          decoration: const InputDecoration(
                              hintText: 'Title',
                              hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black))),
                          validator: (value){
                            if(value!.isEmpty) return '';
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxHeight: 300.0,
                          ),
                          child: Scrollbar(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              reverse: true,
                              child: TextFormField(
                                maxLines: null,
                                controller: controllerMessage,
                                decoration: const InputDecoration(
                                    hintText: 'Message',
                                    hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black))),
                                validator: (value){
                                  if(value!.isEmpty) return '';
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),

                  InkWell(
                    onTap: (){
                      final validate=_formKey.currentState!.validate();
                      if(validate) {
                        setState(() {
                          GlobalList.data.add({'title':controllerTitle.text,'message':controllerMessage.text});
                        });
                        Navigator.pop(context);
                      }else{
                        Navigator.pop(context);
                      }
                    },
                    child: SizedBox(
                      height: 50,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blue,
                          borderRadius:BorderRadius.circular(5),
                        ),
                        child: const Center(child: Text('SAVE',style: TextStyle(color: Colors.white),)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}


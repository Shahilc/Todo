import 'package:flutter/material.dart';

import 'commonList.dart';
class EditDataPage extends StatefulWidget {
  final Map<String, String> data;
  final int index;
  const EditDataPage({super.key, required this.data, required this.index});

  @override
  State<EditDataPage> createState() => _EditDataPageState();
}

class _EditDataPageState extends State<EditDataPage> {
  TextEditingController controllerTitle=TextEditingController();
  TextEditingController controllerMessage=TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
      controllerTitle.text=widget.data['title'].toString();
      controllerMessage.text=widget.data['message'].toString();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 10,),
                      const Text('Update Todo',style: TextStyle(fontSize: 30,color: Colors.black26),),
                      const Text('details',style: TextStyle(fontSize: 30,color: Colors.black26),),
                      const SizedBox(height: 20,),
                      SizedBox(
                        height: 50,
                        child: TextFormField(
                          controller: controllerTitle,
                          decoration: const InputDecoration(
                              hintText: 'Title',
                              hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black12))),
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
                        GlobalList.data.removeAt(widget.index);
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
            )
        ),
      ),
    );
  }
}

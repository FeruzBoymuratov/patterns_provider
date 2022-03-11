
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:patterns_provider/pages/home_page.dart';
import 'package:provider/provider.dart';

import '../models/post_model.dart';
import '../services/http_service.dart';
import '../viewmodel/update_viewmodel.dart';

class UpdatePage extends StatefulWidget {
  static const String id = "update_page";
  String title, body;
  UpdatePage({Key? key, required this.title, required this.body}) : super(key: key);

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  UpdateViewModel updateViewModel = UpdateViewModel();
  var response;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateViewModel.isLoading = true;
    updateViewModel.titleInput = widget.title;
    updateViewModel.bodyInput = widget.body;
    updateViewModel.titleController.text = updateViewModel.titleInput;
    updateViewModel.bodyController.text = updateViewModel.bodyInput;
    updateViewModel.isLoading = true;
    Post post = Post(title: updateViewModel.titleController.text, body: updateViewModel.bodyController.text, id: Random().nextInt(10), userId: Random().nextInt(10));
    response = Network.PUT(Network.API_UPDATE, Network.paramsUpdate(post));
    updateViewModel.isLoading = false;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => updateViewModel,
        child: Consumer<UpdateViewModel>(
          builder: (ctx, model, index) => Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 30,),
                    const Center(
                      child: Text('Title', style: TextStyle(fontSize: 20, color: Colors.blue, fontWeight: FontWeight.bold),),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: const EdgeInsets.only(top: 5, bottom: 5),
                      child: Text(updateViewModel.titleInput,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      padding: const EdgeInsets.all(15),
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: TextField(
                              controller: updateViewModel.titleController,
                              decoration: const InputDecoration(
                                label: Text("Title"),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            shape: BoxShape.circle,
                          ),
                          margin: const EdgeInsets.only(left: 10),
                          child: IconButton(
                            icon: const Icon(Icons.check),
                            onPressed: (){
                                updateViewModel.titleInput = updateViewModel.titleController.text;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    const Center(
                      child: Text('Body', style: TextStyle(fontSize: 20, color: Colors.blue, fontWeight: FontWeight.bold),),
                    ),
                    const SizedBox(height: 5,),
                    Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.all(15),
                        child: Text(updateViewModel.bodyInput)),
                    const SizedBox(height: 20,),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: TextField(
                              keyboardType: TextInputType.multiline,
                              maxLength: null,
                              controller: updateViewModel.bodyController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            shape: BoxShape.circle,
                          ),
                          margin: const EdgeInsets.only(left: 10),
                          child: IconButton(
                            icon: const Icon(Icons.check),
                            onPressed: (){
                                updateViewModel.bodyInput = updateViewModel.bodyController.text;
                            },
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.blue,
                      ),
                      child: TextButton(
                        onPressed: () {
                          if(response != null){
                            Navigator.pushNamedAndRemoveUntil(context, HomePage.id, (route) => false);
                          }
                        },
                        child: const Text("SUBMIT", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              updateViewModel.isLoading ?
              const Center(child: CircularProgressIndicator(),) :
              const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}

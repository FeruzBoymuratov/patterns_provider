import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:patterns_provider/pages/create_page.dart';
import 'package:patterns_provider/pages/update_page.dart';
import 'package:patterns_provider/viewmodel/home_viewmodel.dart';
import 'package:provider/provider.dart';
import '../models/post_model.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home_page';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  HomeViewModel viewModel = HomeViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.apiPostList();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            onPressed: (){
              Navigator.pushNamed(context, CreatePage.id);
            },
            child: const Icon(Icons.add),
          ),
          body: ChangeNotifierProvider(
            create: (context) => viewModel,
            child: Consumer<HomeViewModel>(
              builder: (ctx, model, index) => Stack(
            children: [
              ListView.builder(
                itemCount: viewModel.items.length,
                itemBuilder: (ctx, index){
                  return itemOfPost(viewModel.items[index]);
                },),
              viewModel.isLoading ?
              const Center(
                child: CircularProgressIndicator(),
              ) : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  Widget itemOfPost(Post post){
    return Slidable(
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.title.toUpperCase(),
              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5,),
            Text(post.body),
          ],
        ),
      ),
      startActionPane: ActionPane(
        extentRatio: 0.25,
        children: [
          Flexible(
            child: Container(
              color: Colors.indigo,
              child: IconButton(
                icon: const Icon(Icons.edit, semanticLabel: 'Update',),
                color: Colors.white,
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatePage(title: post.title, body: post.body,)));
                },
              ),
            ),
          ),
        ],
        motion: const DrawerMotion(),
      ),
      endActionPane: ActionPane(
        extentRatio: 0.25,
        children: [
          Flexible(
            child: Container(
              color: Colors.red,
              child: IconButton(
                icon: const Icon(Icons.delete, semanticLabel: 'Delete',),
                color: Colors.white,
                onPressed: (){
                  viewModel.apiPostDelete(post);
                },
              ),
            ),
          ),
        ],
        motion: const DrawerMotion(),
      ),
    );
  }
}
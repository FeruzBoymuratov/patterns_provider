
import 'package:flutter/material.dart';
import 'package:patterns_provider/pages/create_page.dart';
import '../models/post_model.dart';
import '../services/http_service.dart';

class CreateViewModel extends ChangeNotifier{
  bool isLoading = false;
  int dropdownValue = 1;
  var titleController = TextEditingController();
  var bodyController = TextEditingController();
  apiCreatePost() {
      isLoading = true;
      notifyListeners();
    var title = titleController.text.trim().toString();
    var body = bodyController.text.trim().toString();
    var id = dropdownValue;
    notifyListeners();
    Post post = Post(title: title, body: body, userId: id, id: id);
    var response = Network.POST(Network.API_CREATE, Network.paramsCreate(post));
    print(response);
    notifyListeners();
      isLoading = false;
      notifyListeners();
  }
}
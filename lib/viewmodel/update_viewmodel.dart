
import 'package:flutter/cupertino.dart';

class UpdateViewModel extends ChangeNotifier{
  String titleInput = "", bodyInput = "";
  var titleController = TextEditingController();
  var bodyController = TextEditingController();
  bool isLoading = false;

}
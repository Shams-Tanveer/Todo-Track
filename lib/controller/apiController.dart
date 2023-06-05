import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:todo_track/components/snackBar.dart';

/*This Controller is responsible to fetch the data of all the laptops and of a specific single laptop using api when initialized. */

class ApiController extends GetxController {
  var laptopList = [].obs;

  var selectedLaptopId = "".obs;
  var selectedLaptop = {}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  getSelectedLaptopInfo()async{
    final response = await http
        .get(Uri.parse('https://laptop-purchasing.vercel.app/laptop?id=${selectedLaptopId}'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      selectedLaptop.value  = data["laptop"];
    } else {
      SnackBarUtility.showSnackBar(
          'Request failed with status: ${response.statusCode}');
    }
  }


  setSelectLaptop(String id){
    selectedLaptopId.value = id;
  }

  fetchData() async {
    final response = await http
        .get(Uri.parse('https://laptop-purchasing.vercel.app/laptop/all'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      laptopList.value = data["laptops"];
    } else {
      SnackBarUtility.showSnackBar(
          'Request failed with status: ${response.statusCode}');
    }
  }
}

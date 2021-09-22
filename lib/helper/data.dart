import 'package:dailyhunt/data/Categorgy.dart';



List<CategorgyModel> getCategogry(){

List<CategorgyModel> categorgy =  List<CategorgyModel>();
CategorgyModel categoryModel =  CategorgyModel();


//1

categoryModel.categorgyName = "Business";

categorgy.add(categoryModel);
categoryModel  = CategorgyModel();

//2
categoryModel.categorgyName = "Sports";
categorgy.add(categoryModel);

//3
categoryModel = CategorgyModel();
categoryModel.categorgyName = "Business";
categorgy.add(categoryModel);

//4
categoryModel = CategorgyModel();
categoryModel.categorgyName = "Entertianment";
categorgy.add(categoryModel);

//5
categoryModel = CategorgyModel();
categoryModel.categorgyName = "Tech";
categorgy.add(categoryModel);

//6
categoryModel = CategorgyModel();
categoryModel.categorgyName = "General";
categorgy.add(categoryModel);

//7
categoryModel = CategorgyModel();
categoryModel.categorgyName = "Defence";
categorgy.add(categoryModel);

return categorgy;

}
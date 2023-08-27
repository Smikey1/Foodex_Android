import 'package:flutter/material.dart';
import 'package:foodex_app/app/theme/constants.dart';
import 'package:foodex_app/app/utils/dimension.dart';
import 'package:foodex_app/model/export_model.dart';
import 'package:foodex_app/repository/remote_repository/export_remote_repo.dart';
import 'package:foodex_app/response/food_response.dart';
import 'package:foodex_app/screen/food/our_menu.dart';
import 'package:foodex_app/widgets/export_widgets.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class CategoryScreen extends StatefulWidget {
  final String? recievedFoodCategoryTitle;
  final String? recievedFoodCategoryId;
  const CategoryScreen({
    this.recievedFoodCategoryTitle,
    this.recievedFoodCategoryId,
    super.key,
  });

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  String categoryTitle = "";

  @override
  void initState() {
    // getAllFood();
    categoryTitle = widget.recievedFoodCategoryId!;
    getAllCategoryProduct();
    super.initState();
  }

  List<Food> originalFoodList = [];
  List<Food> searchedFoodList = [];
  final TextEditingController _searchController = TextEditingController();

  void _searchProduct(String searchTypedText) {
    List<Food> searchResultFound = [];
    if (searchTypedText.isNotEmpty) {
      searchResultFound = originalFoodList.where((food) {
        String productNameInSmallCase = food.title.toLowerCase();
        String searchTypedTextInSmallCase = searchTypedText.toLowerCase();
        return productNameInSmallCase.contains(searchTypedTextInSmallCase);
      }).toList();
    } else {
      searchResultFound = originalFoodList;
    }
    setState(() {
      searchedFoodList = searchResultFound;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(Dimensions.height10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const AppIcon(
                        backgroundColor: AppColor.kSecondaryColor,
                        icon: Icons.arrow_back_ios,
                        iconColor: Colors.white,
                        // size: Dimensions.iconSize20,
                      )),
                  Container(
                    // padding: EdgeInsets.only(top: Dimensions.height30),
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Text(
                      widget.recievedFoodCategoryTitle!,
                      style: TextStyle(
                        // color: Colors.white,
                        fontSize: Dimensions.font20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    // padding: EdgeInsets.only(top: Dimensions.height30),
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Center(
                      child: Text(
                        'Hell',
                        style: TextStyle(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          fontSize: Dimensions.font26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: Dimensions.height10 / 5,
            ),
            // Search Bar
            Padding(
              padding: EdgeInsets.all(Dimensions.height10),
              child: Container(
                height: Dimensions.height10 * 5,
                decoration: BoxDecoration(
                  // color: Colors.green,
                  border: Border.all(
                    color: AppColor.kSecondaryColor,
                    width: Dimensions.width10 / 10,
                  ),
                  borderRadius: BorderRadius.circular(Dimensions.radius10),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: Dimensions.width10,
                    ),
                    const AppIcon(
                      backgroundColor: AppColor.kSecondaryColor,
                      icon: Icons.search,
                      iconColor: Colors.white,
                      // size: Dimensions.iconSize20,
                    ),
                    SizedBox(
                      width: Dimensions.width10,
                    ),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          _searchProduct(value);
                        },
                        decoration: const InputDecoration(
                          hintText: 'Search',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(child: getAllCategoryProduct()),
          ],
        ),
      ),
    );
  }

  FutureBuilder<FoodResponse?> getAllCategoryProduct() {
    return FutureBuilder<FoodResponse?>(
        future: FoodRepository().getAllFoodCategory(categoryTitle),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.data!.isNotEmpty) {
            List<Food>? catFoodList = snapshot.data!.data!;
            originalFoodList = catFoodList;
            if (searchedFoodList.isEmpty) {
              searchedFoodList = catFoodList;
            }
            return ListView.builder(
                itemCount: searchedFoodList.length,
                itemBuilder: (context, index) {
                  return Card(
                      child: Padding(
                    padding: EdgeInsets.all(Dimensions.height10 - 3),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(Dimensions.height10 - 7),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OurFoodMenu(
                                            receivedFoodId:
                                                searchedFoodList[index].id,
                                            receivedFoodPrice:
                                                searchedFoodList[index].price,
                                            receivedFood:
                                                searchedFoodList[index].title,
                                          )));
                            },
                            child: SizedBox(
                              width: Dimensions.width30 * 3,
                              height: Dimensions.height30 * 3,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.radius50 * 2),
                                child: Image.network(
                                  searchedFoodList[index].foodPhoto[0],
                                  fit: BoxFit.cover,
                                  width: double.maxFinite,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Dimensions.width10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: Dimensions.width200 + 70,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  BigText(text: searchedFoodList[index].title),
                                  const IconTextWidget(
                                      icon: LineAwesomeIcons.star_struck,
                                      Text: "  4.5",
                                      iconColor: AppColor.kSecondaryColor)
                                ],
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => OurFoodMenu(
                                              receivedFoodId:
                                                  searchedFoodList[index].id,
                                              receivedFoodPrice:
                                                  searchedFoodList[index].price,
                                              receivedFood:
                                                  searchedFoodList[index].title,
                                            )));
                              },
                              child: SizedBox(
                                width: Dimensions.width200 + 65,
                                child: Text(
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  searchedFoodList[index].description,
                                  style: TextStyle(
                                    fontSize: Dimensions.font15,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            SizedBox(
                              width: Dimensions.width200 + 70,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SmallText(
                                    text: "\$${searchedFoodList[index].price}",
                                    size: Dimensions.font15 + 3,
                                    color: AppColor.kPrimaryColor,
                                  ),
                                  const AppIcon(
                                    icon: LineAwesomeIcons.heart,
                                    iconColor: AppColor.kErrorColor,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ));
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}

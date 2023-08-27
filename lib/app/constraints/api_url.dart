//--> only for your local server
// const baseUrl = "http://localhost:5000/";

// --> only for your android (localhost --> 10.0.2.2)
import 'package:foodex_app/model/export_model.dart';

const baseUrl = "http://10.0.2.2:5050/";

// --> only for your android real device
// const baseUrl = "http://192.168.137.1:5000/";

// const baseUrl = "http://localhost:5050/";

// other urls
const loginUrl = "user/login";
const registerUrl = "user/register";
const foodUrl = "food";

const foodCategoryUrl = "food_category";

const cartUrl = "cart";
const orderUrl = "order";
// const cartDeleteUrl = "cart/delete/:id";
// const foodCategoryUrl = "food_category/get";

const userUrl = "user";
const updateProfileAllUrl = "user/update/profile-all";
const updateProfileDataUrl = "user/update/profile-data";
const changePasswordUrl = "user/change-password";

const wishlistUrl = "user/wishlistProduct";

// for token
String? tokenConstant = "";

List<Food>? loggedInUserWishlist;

// location address
String? getCurrentLocation = "";

String? getSelectedPaymentMethod = "COD";

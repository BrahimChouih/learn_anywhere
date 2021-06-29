import 'package:get/get.dart';

class AppBarController extends GetxController {
  int shoppingCartCount = 8;
  int notificationsCount = 3;

  static const shCartID = "shoppingCart";
  static const notifID = "notifications";
  static const usrPictureID = "usrPicture";

  void onChangeShoppingCartCount() {
    shoppingCartCount++;
    update([AppBarController.shCartID]);
  }

  void onChangenotificationsCount() {
    notificationsCount++;
    update([AppBarController.notifID]);
  }

  void updateUserPicture() => update([AppBarController.usrPictureID]);
}

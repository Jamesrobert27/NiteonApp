String imageName(String imageName, {String? type}) {
  return "assets/images/$imageName.${type ?? "png"}";
}

class ImageOf {
  static String logo = imageName("logo");
  static String network = imageName("network");
  static String slide2 = imageName("slide2");
  static String slide1 = imageName("slide1");
  static String slide3 = imageName("slide3");
  static String homeIcon = imageName("home_icon");
  static String shopIcon = imageName("shop_icon");
  static String cartIcon = imageName("cart_icon");
  static String myAccountIcon = imageName("my_account");
}

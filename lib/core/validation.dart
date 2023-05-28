class Validate {
  static String? username(String? name) {
    if (name == null || name.length <= 2) {
      return 'name should be greater than three laters';
    } else if (name.length >= 25) {
      return 'name most be less than 25 characters';
    } else {
      return null;
    }
  }

  static String? transactionAmount(String? money) {
    if (money!.isEmpty) {
      return 'amount most not be null';
    }
    if (double.parse(money) == 0) {
      return 'amount must be greater than zero';
    }
    if (double.parse(money) < 0) {
      return 'amount must be positive';
    } else if (money.length >= 13) {
      return 'amount be less than 13 digits';
    } else {
      return null;
    }
  }

  static String? categoryName(String? categoryName) {
    if (categoryName!.isEmpty) {
      return 'category name most not be empty';
    } else if (categoryName.length >= 25) {
      return 'category name must be less than 25 characters';
    } else {
      return null;
    }
  }
}

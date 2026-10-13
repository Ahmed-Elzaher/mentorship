// 1️⃣ Abstraction & Encapsulation
abstract class Product {
  final String name;
  final double _price; // خاص ومحمي (Encapsulation)
  final String id;
  final int quantity;

  double get price => _price; // Getter للقراءة فقط

  Product({
    required this.name,
    required this._price, // براميتر نظيف بدون _
    required this.id,
    required this.quantity,
  });

  double calculateFinalPrice() {
    return _price * quantity;
  }
}

// 2️⃣ Inheritance & Polymorphism
class PhysicalProduct extends Product {
  final double shippingCost;

  PhysicalProduct({
    required this.shippingCost,
    required super.name,
    required super.id,
    required super.quantity,
    required super.price, // وراثة البراميتر النظيف للأب
  });

  @override
  double calculateFinalPrice() {
    // تعدد الأوجه: حساب السعر الأساسي + مصاريف الشحن
    return super.calculateFinalPrice() + shippingCost;
  }
}

// 3️⃣ Composition (السلة تحتوي على منتجات Has-A وليست منتج Is-A)
class Cart {
  final List<Product> _items = []; // محمية لا يمكن العبث بها من الخارج

  List<Product> get items => _items;

  void addProduct(Product product) {
    _items.add(product);
    print('تمت إضافة: ${product.name} بسعر: ${product.price} جنيه');
  }

  double calculateTotal() {
    double total = 0;
    for (final product in _items) {
      // هنا بيتم تطبيق الـ Polymorphism تلقائياً
      total += product.calculateFinalPrice();
    }
    return total;
  }
}

// 4️⃣ تجربة وتشغيل البرنامج
void main() {
  // إنشاء منتج مادي
  final laptop = PhysicalProduct(
    id: '1',
    name: 'لابتوب ديل',
    price: 20000,
    quantity: 1,
    shippingCost: 150, // شحن 150 جنيه
  );

  // إنشاء السلة وإضافة المنتج
  final cart = Cart();
  cart.addProduct(laptop);

  // طباعة الإجمالي
  print('إجمالي السلة بعد حساب الشحن: ${cart.calculateTotal()} جنيه');
}

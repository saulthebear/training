class Product {
  constructor(title, image, description, price) {
    this.title = title;
    this.imageUrl = image;
    this.description = description;
    this.price = price;
  }
}

class ElementAttribute {
  constructor(name, value) {
    this.name = name;
    this.value = value;
  }
}

class Component {
  constructor(renderHookId, shouldRender = true) {
    this.hookId = renderHookId;
    if (shouldRender) {
      this.render();
    }
  }

  render() {}

  createRootElement(tag, cssClasses, attributes) {
    const rootElement = document.createElement(tag);
    if (cssClasses) {
      rootElement.className = cssClasses;
    }

    if (attributes && attributes.length > 0) {
      for (const attribute of attributes) {
        rootElement.setAttribute(attribute.name, attribute.value);
      }
    }

    document.getElementById(this.hookId).append(rootElement);
    return rootElement;
  }
}

class ShoppingCart extends Component {
  items = [];

  get totalAmount() {
    return this.items.reduce((sum, item) => sum + item.price, 0);
  }

  constructor(hookId) {
    super(hookId);
  }

  addProduct(product) {
    this.items.push(product);
    const total = this.totalAmount.toFixed(2);
    this.totalOutput.innerHTML = `<h2>Total: $${total}</h2>`;
  }

  handleOrderProducts() {
    console.log("Ordering all products");
    console.log(this.items);
  }

  render() {
    const cartElement = this.createRootElement("section", "cart");
    cartElement.innerHTML = `
      <h2>Total: $${0}</h2>
      <button>Order Now!</button>
    `;

    const orderButton = cartElement.querySelector("button");
    orderButton.addEventListener("click", () => this.handleOrderProducts());

    this.totalOutput = cartElement.querySelector("h2");
  }
}

class ProductItem extends Component {
  constructor(renderHookId, product) {
    super(renderHookId, false);
    this.product = product;
    this.render();
  }

  addToCart() {
    App.addProductToCart(this.product);
  }

  render() {
    const productElement = this.createRootElement("li", "product-item");
    productElement.innerHTML = `
        <div>
          <img src="${this.product.imageUrl}" alt="${this.product.description}">
          <div class="product-item__content">
            <h2>${this.product.title}</h2>
            <h3>$${this.product.price}</h3>
            <p>${this.product.description}</p>
            <button>Add to Cart</button>
          </div>
        </div>
      `;
    const addToCartBtn = productElement.querySelector("button");
    addToCartBtn.addEventListener("click", this.addToCart.bind(this));
  }
}

class ProductList extends Component {
  products = [];

  constructor(renderHookId) {
    super(renderHookId);
    this.fetchProducts();
  }

  fetchProducts() {
    this.products = [
      new Product(
        "A pillow",
        "https://target.scene7.com/is/image/Target/GUEST_3d52ad7a-40b3-4a3f-ac4f-e10b19b17ccc?wid=488&hei=488&fmt=pjpeg",
        "A soft pillow!",
        19.99
      ),
      new Product(
        "A carpet",
        "https://media.istockphoto.com/photos/turkish-carpet-picture-id486167735?k=20&m=486167735&s=612x612&w=0&h=C-hW6Mj4YpUwCLl9hp_n8IVqxf-By0X1RmT_xgsl3d8=",
        "What a great carpet!",
        99.99
      ),
    ];
    this.renderProducts();
  }

  renderProducts() {
    /* eslint-disable no-restricted-syntax */
    for (const product of this.products) {
      new ProductItem("product-list", product);
    }
  }

  render() {
    const productList = this.createRootElement("ul", "product-list", [
      new ElementAttribute("id", "product-list"),
    ]);

    if (this.products && this.products.length > 0) {
      this.renderProducts();
    }
  }
}

class Shop {
  constructor() {
    this.cart = new ShoppingCart("app");
    this.render();
  }

  render() {
    new ProductList("app");
  }
}

class App {
  static cart;

  static init() {
    const shop = new Shop();
    this.cart = shop.cart;
  }

  static addProductToCart(product) {
    this.cart.addProduct(product);
  }
}

App.init();

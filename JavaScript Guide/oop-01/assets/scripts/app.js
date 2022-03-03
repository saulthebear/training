class Product {
  constructor(title, image, description, price) {
    this.title = title;
    this.imageUrl = image;
    this.description = description;
    this.price = price;
  }
}

class ProductItem {
  constructor(product) {
    this.product = product;
  }

  addToCart() {
    console.log("adding product to cart");
    console.log(this.product);
  }

  toElement() {
    const productElement = document.createElement("li");
    productElement.className = "product-item";
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
    return productElement;
  }
}

class ProductList {
  products = [
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

  constructor() {}

  render() {
    const renderHook = document.getElementById("app");
    const prodList = document.createElement("ul");
    prodList.className = "product-list";
    /* eslint-disable no-restricted-syntax */
    for (const product of this.products) {
      const productItem = new ProductItem(product);
      const productElement = productItem.toElement();
      prodList.append(productElement);
    }
    renderHook.append(prodList);
  }
}

const productList = new ProductList();
productList.render();

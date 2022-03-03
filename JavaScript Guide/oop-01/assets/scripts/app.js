class Product {
  constructor(title, image, description, price) {
    this.title = title;
    this.imageUrl = image;
    this.description = description;
    this.price = price;
  }
}

const ProductList = {
  products: [
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
  ],

  render() {
    const renderHook = document.getElementById("app");
    const prodList = document.createElement("ul");
    prodList.className = "product-list";
    /* eslint-disable no-restricted-syntax */
    for (const product of this.products) {
      const prodEl = document.createElement("li");
      prodEl.className = "product-item";
      prodEl.innerHTML = `
        <div>
          <img src="${product.imageUrl}" alt="${product.description}">
          <div class="product-item__content">
            <h2>${product.title}</h2>
            <h3>$${product.price}</h3>
            <p>${product.description}</p>
            <button>Add to Cart</button>
          </div>
        </div>
      `;
      prodList.append(prodEl);
    }
    renderHook.append(prodList);
  },
};

ProductList.render();

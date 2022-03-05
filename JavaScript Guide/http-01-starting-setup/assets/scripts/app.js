const listElement = document.querySelector(".posts");
const postTemplate = document.getElementById("single-post");

const xhr = new XMLHttpRequest();

xhr.open("GET", "https://jsonplaceholder.typicode.com/posts");

xhr.responseType = "json";

xhr.onload = function () {
  const listOfPosts = xhr.response;

  /* eslint-disable no-restricted-syntax */
  for (const post of listOfPosts) {
    const postElement = document.importNode(postTemplate.content, true);
    postElement.querySelector("h2").textContent = post.title.toUpperCase();
    postElement.querySelector("p").textContent = post.body;
    listElement.append(postElement);
  }
};

xhr.send();

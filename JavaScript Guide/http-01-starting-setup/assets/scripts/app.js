const listElement = document.querySelector(".posts");
const postTemplate = document.getElementById("single-post");

function sendHttpRequest(method, url) {
  const promise = new Promise((resolve, reject) => {
    const xhr = new XMLHttpRequest();
    xhr.open(method, url);
    xhr.responseType = "json";

    xhr.onload = () => resolve(xhr.response);

    xhr.send();
  });

  return promise;
}

function fetchPosts() {
  sendHttpRequest("GET", "https://jsonplaceholder.typicode.com/posts").then(
    (responseData) => {
      const listOfPosts = responseData;

      /* eslint-disable no-restricted-syntax */
      for (const post of listOfPosts) {
        const postElement = document.importNode(postTemplate.content, true);
        postElement.querySelector("h2").textContent = post.title.toUpperCase();
        postElement.querySelector("p").textContent = post.body;
        listElement.append(postElement);
      }
    }
  );
}

fetchPosts();

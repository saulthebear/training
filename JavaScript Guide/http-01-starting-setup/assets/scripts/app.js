const listElement = document.querySelector(".posts");
const postTemplate = document.getElementById("single-post");
const fetchButton = document.querySelector("#available-posts button");

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

async function fetchPosts() {
  const responseData = await sendHttpRequest(
    "GET",
    "https://jsonplaceholder.typicode.com/posts"
  );

  const listOfPosts = responseData;
  // Clear existing posts
  listElement.innerHTML = "";

  /* eslint-disable no-restricted-syntax */
  for (const post of listOfPosts) {
    const postElement = document.importNode(postTemplate.content, true);
    postElement.querySelector("h2").textContent = post.title.toUpperCase();
    postElement.querySelector("p").textContent = post.body;
    listElement.append(postElement);
  }
}

fetchButton.addEventListener("click", fetchPosts);

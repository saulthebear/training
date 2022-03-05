const listElement = document.querySelector(".posts");
const postTemplate = document.getElementById("single-post");
const form = document.querySelector("#new-post form");
const fetchButton = document.querySelector("#available-posts button");
const postList = document.querySelector(".posts");

function sendHttpRequest(method, url, data) {
  return fetch(url, {
    method,
    body: JSON.stringify(data),
    headers: {
      "Content-Type": "application/json",
    },
  }).then((response) => {
    if (response.status >= 200 && response.status < 300) {
      return response.json();
    }
    throw new Error("Something went wrong server side.");
  });
}

async function fetchPosts() {
  try {
    const responseData = await sendHttpRequest(
      "GET",
      "https://jsonplaceholder.typicode.com/pos"
    );

    const listOfPosts = responseData;
    // Clear existing posts
    listElement.innerHTML = "";

    /* eslint-disable no-restricted-syntax */
    for (const post of listOfPosts) {
      const postElement = document.importNode(postTemplate.content, true);
      postElement.querySelector("h2").textContent = post.title.toUpperCase();
      postElement.querySelector("p").textContent = post.body;
      postElement.querySelector("li").id = post.id;
      listElement.append(postElement);
    }
  } catch (error) {
    alert(error);
  }
}

async function createPost(title, content) {
  const userId = Math.random();
  const post = {
    title,
    body: content,
    userId,
  };

  sendHttpRequest("POST", "https://jsonplaceholder.typicode.com/posts", post);
}

fetchButton.addEventListener("click", fetchPosts);
form.addEventListener("submit", (event) => {
  event.preventDefault();
  const enteredTitle = event.currentTarget.querySelector("#title").value;
  const enteredContent = event.currentTarget.querySelector("#content").value;

  createPost(enteredTitle, enteredContent);
});

postList.addEventListener("click", (event) => {
  if (event.target.tagName === "BUTTON") {
    const postId = event.target.closest("li").id;
    const postUrl = `https://jsonplaceholder.typicode.com/posts/${postId}`;
    sendHttpRequest("DELETE", postUrl);
  }
});

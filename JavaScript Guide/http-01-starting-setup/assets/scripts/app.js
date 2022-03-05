const xhr = new XMLHttpRequest();

xhr.open("GET", "https://jsonplaceholder.typicode.com/posts");

xhr.responseType = "json";

xhr.onload = function () {
  const listOfPosts = xhr.response;
  console.log(listOfPosts);
};

xhr.send();

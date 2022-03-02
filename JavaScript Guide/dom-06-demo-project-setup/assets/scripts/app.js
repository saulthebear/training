const addModal = document.getElementById("add-modal");
const cancelAddMovieBtn = addModal.querySelector(".js-cancel-add");
const confirmAddMovieBtn = addModal.querySelector(".js-add-movie");
const backdrop = document.getElementById("backdrop");
const addMovieModalBtn = document.getElementById("js-add-movie-modal-btn");

const userInputs = addModal.querySelectorAll("input");

const entryTextSection = document.getElementById("entry-text");

const movies = [];

const updateUI = () => {
  if (movies.length === 0) {
    entryTextSection.style.display = "block";
  } else {
    entryTextSection.style.display = "none";
  }
};

const deleteMovieHandler = (id) => {
  let targetIndex;
  for (let i = 0; i < movies.length; i += 1) {
    const movie = movies[i];
    if (movie.id === id) {
      targetIndex = i;
      break;
    }
  }

  movies.splice(targetIndex, 1);
  const list = document.getElementById("movie-list");
  list.children[targetIndex].remove();
};

const renderNewMovieElement = (id, title, imageUrl, rating) => {
  const newMovieElement = document.createElement("li");
  newMovieElement.className = "movie-element";
  newMovieElement.innerHTML = `
    <div class="movie-element__image">
      <img src="${imageUrl}" alt="${title}">
    </div>
    <div class="movie-element__info">
      <h2>${title}</h2>
      <p>${rating}/5
    </div>
  `;

  newMovieElement.addEventListener("click", deleteMovieHandler.bind(null, id));

  const list = document.getElementById("movie-list");
  list.append(newMovieElement);
};

const clearMovieInputs = () => {
  /* eslint-disable-next-line no-restricted-syntax */
  for (const userInput of userInputs) {
    userInput.value = "";
  }
};

const toggleBackdrop = () => {
  backdrop.classList.toggle("visible");
};

const toggleMovieModal = () => {
  addModal.classList.toggle("visible");
  toggleBackdrop();
  clearMovieInputs();
};

const backdropClickHandler = () => {
  toggleMovieModal();
};

const addMovieHandler = () => {
  const titleValue = userInputs[0].value;
  const imageUrlValue = userInputs[1].value;
  const ratingValue = userInputs[2].value;

  if (
    titleValue.trim() === "" ||
    imageUrlValue.trim() === "" ||
    ratingValue.trim() === "" ||
    +ratingValue < 1 ||
    +ratingValue > 5
  ) {
    alert("Please enter valid values (rating between 1 and 5)");
  }

  const newMovie = {
    id: Math.random().toString(),
    title: titleValue,
    image: imageUrlValue,
    rating: ratingValue,
  };

  movies.push(newMovie);
  console.log(movies);
  toggleMovieModal();
  renderNewMovieElement(
    newMovie.id,
    newMovie.title,
    newMovie.image,
    newMovie.rating
  );
  updateUI();
};

addMovieModalBtn.addEventListener("click", toggleMovieModal);
backdrop.addEventListener("click", backdropClickHandler);
cancelAddMovieBtn.addEventListener("click", toggleMovieModal);
confirmAddMovieBtn.addEventListener("click", addMovieHandler);

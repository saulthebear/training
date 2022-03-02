const addModal = document.getElementById("add-modal");
const cancelAddMovieBtn = addModal.querySelector(".js-cancel-add");
const confirmAddMovieBtn = addModal.querySelector(".js-add-movie");
const backdrop = document.getElementById("backdrop");
const addMovieModalBtn = document.getElementById("js-add-movie-modal-btn");

const userInputs = addModal.querySelectorAll("input");

const movies = [];

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
    title: titleValue,
    image: imageUrlValue,
    rating: ratingValue,
  };

  movies.push(newMovie);
  console.log(movies);
  toggleMovieModal();
};

addMovieModalBtn.addEventListener("click", toggleMovieModal);
backdrop.addEventListener("click", backdropClickHandler);
cancelAddMovieBtn.addEventListener("click", toggleMovieModal);
confirmAddMovieBtn.addEventListener("click", addMovieHandler);

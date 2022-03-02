const modal = document.getElementById("add-modal");

const toggleMovieModal = () => {
  modal.classList.toggle("visible");
};

const addMovieModalBtn = document.getElementById("js-add-movie-modal-btn");
addMovieModalBtn.addEventListener("click", toggleMovieModal);

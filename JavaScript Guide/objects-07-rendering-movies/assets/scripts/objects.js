const addMovieBtn = document.getElementById("add-movie-btn");
const searchBtn = document.getElementById("search-btn");

const movies = [];

const renderMovies = (filter = "") => {
  const movieList = document.getElementById("movie-list");

  if (movies.length === 0) {
    movieList.classList.remove("visible");
    return;
  }

  movieList.classList.add("visible");

  movieList.innerHTML = "";

  const filteredMovies = !filter
    ? movies
    : movies.filter((movie) => movie.info.title.includes(filter));

  filteredMovies.forEach((movie) => {
    const movieElement = document.createElement("li");
    let text = `${movie.info.title} -- `;
    /* eslint-disable no-restricted-syntax */
    for (const key in movie.info) {
      if (key !== "title") {
        text += `${key}: ${movie.info[key]}`;
      }
    }
    movieElement.textContent = text;
    movieList.append(movieElement);
  });
};

const addMovieHandler = () => {
  const title = document.getElementById("title").value;
  const extraName = document.getElementById("extra-name").value;
  const extraValue = document.getElementById("extra-value").value;

  if (!title.trim() || !extraName.trim() || !extraValue.trim()) return;

  const newMovie = {
    info: {
      title,
      [extraName]: extraValue,
    },
    id: Math.random(),
  };

  movies.push(newMovie);
  renderMovies();
};

const searchMovieHandler = () => {
  const filterTerm = document.getElementById("filter-title").value;
  renderMovies(filterTerm);
};

addMovieBtn.addEventListener("click", addMovieHandler);
searchBtn.addEventListener("click", searchMovieHandler);

class PlaceFinder {
  constructor() {
    const addressForm = document.querySelector("form");
    const locateUserBtn = document.getElementById("locate-btn");

    locateUserBtn.addEventListener("click", this.#locateUserHandler);
    addressForm.addEventListener("submit", this.#findAddressHandler);
  }

  #locateUserHandler() {
    navigator.geolocation.getCurrentPosition(
      (successResult) => {
        const coordinates = {
          lat: successResult.coords.latitude,
          lng: successResult.coords.longitude,
        };
        console.log(coordinates);
      },
      (error) => {
        alert("Courld not locate you. Please enter an address manually.");
      }
    );
  }

  #findAddressHandler() {}
}

const placeFinder = new PlaceFinder();

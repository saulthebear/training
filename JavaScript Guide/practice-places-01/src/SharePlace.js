import Modal from "./UI/Modal";

class PlaceFinder {
  constructor() {
    const addressForm = document.querySelector("form");
    const locateUserBtn = document.getElementById("locate-btn");

    locateUserBtn.addEventListener("click", this.#locateUserHandler);
    addressForm.addEventListener("submit", this.#findAddressHandler);
  }

  #locateUserHandler() {
    const modal = new Modal("loading-modal-content", "Loading location...");
    modal.show();
    navigator.geolocation.getCurrentPosition(
      (successResult) => {
        modal.hide();
        const coordinates = {
          lat: successResult.coords.latitude,
          lng: successResult.coords.longitude,
        };
        console.log(coordinates);
      },
      (error) => {
        modal.hide();
        alert("Courld not locate you. Please enter an address manually.");
      }
    );
  }

  #findAddressHandler() {}
}

const placeFinder = new PlaceFinder();

import Map from "./UI/Map";
import Modal from "./UI/Modal";

class PlaceFinder {
  constructor() {
    const addressForm = document.querySelector("form");
    const locateUserBtn = document.getElementById("locate-btn");

    locateUserBtn.addEventListener("click", this.#locateUserHandler.bind(this));
    addressForm.addEventListener("submit", this.#findAddressHandler.bind(this));
  }

  #selectPlace(coordiantes) {
    if (this.map) {
      this.map.render(coordiantes);
    }

    this.map = new Map(coordiantes);
    this.map.render(coordiantes);
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
        this.#selectPlace(coordinates);
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

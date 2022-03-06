import Map from "./UI/Map";
import Modal from "./UI/Modal";
import getCoordinatesFromAddress from "./Utility/Location";

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
    const modal = PlaceFinder.getLoadingModal();
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
      () => {
        modal.hide();
        alert("Courld not locate you. Please enter an address manually.");
      }
    );
  }

  async #findAddressHandler(event) {
    console.log(event);
    event.preventDefault();
    const address = event.target.querySelector("input").value.trim();
    if (!address) {
      alert("Invalid address entered - please try again");
      return;
    }

    const modal = PlaceFinder.getLoadingModal();
    modal.show();
    try {
      const coordinates = await getCoordinatesFromAddress(address);
      this.#selectPlace(coordinates);
    } catch (error) {
      alert(error.message);
    }
    modal.hide();
  }

  static getLoadingModal() {
    return new Modal("loading-modal-content", "Loading location...");
  }
}

const placeFinder = new PlaceFinder();

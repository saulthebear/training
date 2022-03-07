import Map from "./UI/Map";
import Modal from "./UI/Modal";
import {
  getCoordinatesFromAddress,
  getAddressFromCoordinates,
} from "./Utility/Location";

class PlaceFinder {
  constructor() {
    const addressForm = document.querySelector("form");
    const locateUserBtn = document.getElementById("locate-btn");
    this.shareBtn = document.getElementById("share-btn");

    locateUserBtn.addEventListener("click", this.#locateUserHandler.bind(this));
    addressForm.addEventListener("submit", this.#findAddressHandler.bind(this));
    this.shareBtn.addEventListener(
      "click",
      PlaceFinder.#sharePlaceHandler.bind(this)
    );
  }

  static #sharePlaceHandler() {
    const sharedLinkInputElement = document.getElementById("share-link");
    if (!navigator.clipboard) {
      sharedLinkInputElement.ariaSelected();
      return;
    }
    navigator.clipboard
      .writeText(sharedLinkInputElement.value)
      .then(() => {
        alert("Copied into clipboard");
      })
      .catch((error) => console.error(error));
  }

  #selectPlace(coordinates, address) {
    if (this.map) {
      this.map.render(coordinates);
    }

    this.map = new Map(coordinates);
    this.map.render(coordinates);

    this.shareBtn.disabled = false;
    const shareLinkInput = document.getElementById("share-link");
    shareLinkInput.value = `${location.origin}/my-place?address=${encodeURI(
      address
    )}&lat=${coordinates.lat}&lng=${coordinates.lng}`;
  }

  #locateUserHandler() {
    const modal = PlaceFinder.getLoadingModal();
    modal.show();
    navigator.geolocation.getCurrentPosition(
      async (successResult) => {
        const coordinates = {
          lat: successResult.coords.latitude,
          lng: successResult.coords.longitude,
        };

        const address = await getAddressFromCoordinates(coordinates);
        modal.hide();
        this.#selectPlace(coordinates, address);
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
      this.#selectPlace(coordinates, address);
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

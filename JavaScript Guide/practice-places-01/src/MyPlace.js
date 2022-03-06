import Map from "./UI/Map";

class LoadedPlace {
  constructor(coordinates, address) {
    this.map = new Map(coordinates);
    const headerTitleElement = document.querySelector("header h1");
    headerTitleElement.textContent = address;
  }
}

const url = new URL(location.href);
const queryParams = url.searchParams;
const coordinates = {
  lat: +queryParams.get("lat"),
  lng: +queryParams.get("lng"),
};
const address = queryParams.get("address");
const place = new LoadedPlace(coordinates, address);

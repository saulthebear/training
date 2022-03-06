export default class Map {
  constructor(coordiantes) {
    this.coordiantes = coordiantes;
    this.render(coordiantes);
  }

  render(coordinates) {
    if (!google) {
      alert("Could not load maps - Please try again!");
      return;
    }

    const map = new google.maps.Map(document.getElementById("map"), {
      center: coordinates,
      zoom: 16,
    });

    const marker = new google.maps.Marker({
      position: coordinates,
      map,
    });
  }
}

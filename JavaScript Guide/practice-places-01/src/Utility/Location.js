const MAPS_API_KEY = "AIzaSyBZc7z2nB5D7PM4zbleKNgmNOD8yDEaNq4";
export async function getCoordinatesFromAddress(address) {
  const encodedAddress = encodeURI(address);
  const url = `https://maps.googleapis.com/maps/api/geocode/json?address=${encodedAddress}&key=${MAPS_API_KEY}`;
  const response = await fetch(url);
  if (!response.ok) {
    throw new Error("Failed to fetch coordinates. Please try again!");
  }

  const data = await response.json();
  if (data.error_message) {
    throw new Error(data.error_message);
  }

  const coordinates = data.results[0].geometry.location;
  return coordinates;
}

export async function getAddressFromCoordinates(coordinates) {
  const { lat, lng } = coordinates;
  const url = `https://maps.googleapis.com/maps/api/geocode/json?latlng=${lat},${lng}&key=${MAPS_API_KEY}`;
  const response = await fetch(url);

  if (!response.ok) {
    throw new Error("Failed to fetch address. Please try again");
  }

  const data = await response.json();
  if (data.error_message) {
    throw new Error(data.error_message);
  }

  const address = data.results[0].formatted_address;
  return address;
}

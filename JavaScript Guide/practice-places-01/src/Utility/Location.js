const MAPS_API_KEY = "AIzaSyBZc7z2nB5D7PM4zbleKNgmNOD8yDEaNq4";
export default async function getCoordinatesFromAddress(address) {
  const encodedAddress = encodeURI(address);
  console.log(
    `https://maps.googleapis.com/maps/api/geocode/json?address=${encodedAddress}&key=${MAPS_API_KEY}`
  );
  const response = await fetch(
    `https://maps.googleapis.com/maps/api/geocode/json?address=${encodedAddress}&key=${MAPS_API_KEY}`
  );
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

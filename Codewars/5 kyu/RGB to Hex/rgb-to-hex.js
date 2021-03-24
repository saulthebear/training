
// eslint-disable-next-line no-unused-vars
function rgb(r, g, b) {
  return decToHex(r) + decToHex(g) + decToHex(b);
}

function decToHex(num) {
  if (num > 255) num = 255;
  else if (num < 0) num = 0;

  let hex = num.toString(16).toUpperCase();
  // pad with leading zero
  if (hex.length === 1) hex = '0' + hex;
  return hex;
}

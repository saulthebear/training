// eslint-disable-next-line no-unused-vars
function toCamelCase(str) {
  return str.replace(/([-_])(\w)/g, (match, delim, char) => {
    return char.toUpperCase();
  });
}

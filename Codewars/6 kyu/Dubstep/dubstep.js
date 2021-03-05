function songDecoder(song){
    // Match regular expression,
    // replace matches with a space,
    // then remove leading and trailing spaces.
    return song.replace(/(WUB)+/g, ' ').trim();
  }

// Export function for tests to work
 module.exports = {songDecoder};
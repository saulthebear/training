// describe("Fixed tests", function(){
//     it("It should pass fixed tests", function(){
//       Test.assertEquals(songDecoder("AWUBBWUBC"), "A B C","WUB should be replaced by 1 space");
//       Test.assertEquals(songDecoder("AWUBWUBWUBBWUBWUBWUBC"), "A B C","multiples WUB should be replaced by only 1 space");
//       Test.assertEquals(songDecoder("WUBAWUBBWUBCWUB"), "A B C","heading or trailing spaces should be removed");
//     });
//   });

// Refactored to use Mocha & Chai
const chai = require("chai");
const assert = chai.assert;
chai.config.truncateThreshold=0;

const dubstep = require('./dubstep.js');
const songDecoder = dubstep.songDecoder;

describe("Fixed tests", function() {
    it("It should pass fixed tests", function(){
        assert.equal(songDecoder("AWUBBWUBC"), "A B C","WUB should be replaced by 1 space");
        assert.equal(songDecoder("AWUBWUBWUBBWUBWUBWUBC"), "A B C","multiples WUB should be replaced by only 1 space");
        assert.equal(songDecoder("WUBAWUBBWUBCWUB"), "A B C","heading or trailing spaces should be removed");
    });
});
// Test.describe("addBinary(1,2)", function() {
//     var results1 = addBinary(1,2);
//     Test.it("Should return something that isn't falsy", function() {
//       Test.expect(results1, "Something is wrong, no results!");
//     });
//     Test.it("Should return \"11\"", function() {
//       Test.assertEquals(results1, "11");
//     });
//   });

// Refactored to use Mocha & Chai
const chai = require("chai");
const assert = chai.assert;
chai.config.truncateThreshold=0;

const binaryAddition = require('./binaryAddition.js');
const addBinary = binaryAddition.addBinary;

describe("addBinary(1,2)", function() {
    let results1 = addBinary(1,2);
    it("Should return something that isn't falsy", function(){
        chai.expect(results1, "Something is wrong, no results!");
    });
    it("Should return \"11\"", function(){
        assert.equal(results1, "11");
    });
});
// Original tests on codewars
// Test.assertEquals(duplicateEncode("din"),"(((");
// Test.assertEquals(duplicateEncode("din"),"(((");
// Test.assertEquals(duplicateEncode("recede"),"()()()");
// Test.assertEquals(duplicateEncode("Success"),")())())","should ignore case");
// Test.assertEquals(duplicateEncode("(( @"),"))((");

// Refactored to use Mocha & Chai
const chai = require("chai");
const assert = chai.assert;
chai.config.truncateThreshold=0;

const solution = require('./solution.js')

describe("Duplicate Encoder", function(){
    it('should succeed with no duplicates', function() {
        assert.equal(solution.duplicateEncode("din"), "(((");
    });
    it('should succeed with duplicates', function() {
        assert.equal(solution.duplicateEncode("recede"), "()()()");
    });
    it('should ignore case', function() {
        assert.equal(solution.duplicateEncode("Success"), ")())())");
    });
    it('should work with non-alphabetic characters', function() {
        assert.equal(solution.duplicateEncode("(( @"), "))((");
    });
});
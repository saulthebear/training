const assert = require('chai').assert;

// Use lookaheads in the pwRegex to match passwords that are
// greater than 5 characters long, and have two consecutive digits.
const pwRegex = /(?=\w{6,})(?=\D*\d{2})/;

// TESTS
describe('Matches', () => {
  it('Matches bana12', () => assert.isTrue(pwRegex.test('bana12')));
  it('Matches abc123', () => assert.isTrue(pwRegex.test('abc123')));
  it('Matches 8pass99', () => assert.isTrue(pwRegex.test('8pass99')));
  it('Matches astr1on11aut', () => assert.isTrue(pwRegex.test('astr1on11aut')));
});

describe('Non Matches', () => {
  it('Does not match astronaut', () =>
    assert.isFalse(pwRegex.test('astronaut')));
  it('Does not match banan1', () =>
    assert.isFalse(pwRegex.test('banan1')));
  it('Does not match 12345', () =>
    assert.isFalse(pwRegex.test('12345')));
  it('Does not match 1a2bcde', () =>
    assert.isFalse(pwRegex.test('1a2bcde')));
});

// spec.js

describe('angularjs homepage', function() {
  it('should have a title', function() {
    //url = "http://184.169.165.135:8010/test/test_email"
    //url = "https://saisappdev68.stanford.edu/test/test_email"
    url = "https://selection.stanford.edu/test/test_email"
    browser.get(url);

    expect(browser.getTitle()).toEqual('Stanford SAAS');
  });
});
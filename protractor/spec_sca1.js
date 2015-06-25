// spec.js
describe('angularjs homepage', function() {
  it('should have a title', function() {
    browser.get('http://184.169.165.135:8010/');
    expect(browser.getTitle()).toEqual('Stanford ResJobs');
  });
});

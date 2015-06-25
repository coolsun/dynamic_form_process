// spec.js
describe('angularjs homepage', function() {
  it('should have a title', function() {
    browser.get('http://localhost:3000/saas/app/index.html#/2014-2015/DEV/interview_admin');

    expect(browser.getTitle()).toEqual('Stanford SAAS');
  });
});
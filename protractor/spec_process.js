// spec.js
describe('angularjs homepage', function() {
  var manage_btn = element(by.id('manage_btn'));
  var process_result = element.all(by.css('process'));

  beforeEach(function() {
    browser.get('http://184.169.165.135:8010');
  });

  it('should have a title', function() {
    expect(browser.getTitle()).toEqual('Stanford ResJobs');
  });

  it('should 4 process', function() {
    var allOptions = element.all(by.options('process.name for process in processSelectBar.processes'));
    expect(allOptions.count()).toEqual(10);
  });

  it('go Graduate Community Associate (CA) process page', function() {
    var allOptions = element.all(by.options('process.name for process in processSelectBar.processes'));
    console.log(allOptions);
    var firstOption = allOptions.get(1);
    expect(firstOption.getText()).toEqual('Graduate Community Associate (CA)');
    firstOption.click();
    element(by.id('APPLY-GO-TO-APPLICATION')).click();
    expect(browser.getLocationAbsUrl()).toEqual('http://184.169.165.135:8010/saas/app/index.html#/2014-2015/CA/apply_now');
  });


  it('go Manage page', function() {
    element(by.id('manage_btn')).click();
    expect(browser.getLocationAbsUrl()).toEqual('http://184.169.165.135:8010/saas/app/index.html#/process');
  });


});

// spec.js
/*
  Download report
  Create/Edit year
  Switch year
  Clone year
  Create/Edit/Delete User
  Create/Edit/Delete Roles
  Create/Edit/Delete Locations
  Edit System Message
  Time Setting
  User Permissions
*/

//var testHost = "http://saas.stanford.edu";
//var testHost = "http://184.169.165.135:8010";
var testHost = "http://localhost:3000";

/*
describe('Test download report', function() {
  beforeEach(function() {
    browser.get(testHost);
  });

  it('Download report', function() {
    element(by.id('Footer-Manage-Process')).click();
    element(by.id('showMenuList')).click();
    element(by.id('showMenuList-Report')).click();
    var allOptions = element.all(by.options('procedure.id as procedure.name for procedure in procedures'));
    allOptions.get(1).click();
    expect(element(by.id('ApplicantListReport-Download')).submit());
  });

});
*/
describe('Test year', function() {
  beforeEach(function() {
    browser.get(testHost);
  });

  it('Create year', function() {
    element(by.id('Footer-Manage-Process')).click();
    element(by.id('showMenuList')).click();
    element(by.id('showMenuList-Report')).click();
    var allOptions = element.all(by.options('procedure.id as procedure.name for procedure in procedures'));
    allOptions.get(1).click();
    expect(element(by.id('ApplicantListReport-Download')).submit());
  });

});






/*
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
*/
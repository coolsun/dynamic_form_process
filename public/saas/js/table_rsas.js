 /**
 * last update : 2014, AUG 5
 */

var table = angular.module("tableRsas", ["waitingIconModule"]);

var pageGoTop = function(a, t){
  //window.scrollTo(0, 0);
};

table.factory(
  "CTableRsas",
  function($http, waitingIcon) {
    function CTableRsas(name, url) {
      this.name = name;
      this.url = url;
      this.img = ['sort_asc', 'sort_desc', 'sort_both'];
      this.header = [];           // [name=>string, sortable=>int]
      this.show = [];             // show data on table page
      this.orderBy = '';          // order by table field
      this.sortOrder = 0;         // must ASC DESC
      this.pNow = 1;
      this.pTotal = 0;
      this.perPage = 25;
      this.goPage = 1;
      this.goPageAble = 1;
      this.searchText = '';
    }

    CTableRsas.prototype.init = function(scope, tbl, bGoPageNow) {
      bGoPageNow = (false == bGoPageNow)? bGoPageNow : true;
      if (bGoPageNow)
      {
        tbl.pageChange(tbl);
      }
      tbl.initWatch(scope, tbl);
      tbl.checkGotoAble();
    };

    CTableRsas.prototype.initWatch = function(scope, tbl) {
      scope.$watch((this.name + '.goPage'), function(){
        tbl.checkGotoAble();
      }, true);
    };

    CTableRsas.prototype.checkGotoAble = function() {
      var i = new RegExp(/^-{0}\d+$/);
      var s = this.goPage;
      this.goPageAble = (i.test(s))? 0 : 1;
    };

    CTableRsas.prototype.pageChange = function() {
      this.goPage = this.pNow;
      this.goToPage();
    };

    CTableRsas.prototype.goToPage = function() {
      pageGoTop();
      this.setDataAndRequest();
    };

    CTableRsas.prototype.setHeader = function() { // arguments(['name':string, enableSort:int], ...);
      if (arguments.length)
      {
        var argLen = arguments.length;
        for (var i = 0; i < argLen; i++)
        {
          this.header.push(arguments[i]);
        }
        return true;
      }
      else
      {
        return false; // error;
      }
    };

    CTableRsas.prototype.headerClick = function(header) {
      if (header[1])
      {
        this.orderBy = header[0];
        this.sortOrder = this.sortOrder? 0 : 1;
        this.setDataAndRequest();
      }
    };

    CTableRsas.prototype.searchClick = function(tbl) {
      tbl.setDataAndRequest();
    };

    // callback first
    CTableRsas.prototype.successDo = function(data){
      //console.warn('you maybe need define function: this.successDo()');
    };

    // link first
    CTableRsas.prototype.setDataAndRequest = function(){
      console.error('you have to define function: this.setDataAndRequest()');
      console.warn('this.linkServerGetData(tbl, postData); // this line must add');
    };

    CTableRsas.prototype.linkServerGetData = function(tbl, data){
      var s;
      waitingIcon.open();
      $http({
          url: this.url,
          method: "GET",
          params: data
        })
        .success(function (data, status, headers, config) {
          tbl.pTotal = data.total;
          tbl.pNow = data.now;
          tbl.goPage = data.now;
          tbl.show = data.show;
          s = true;
          tbl.successDo(data);
          waitingIcon.close();
        })
        .error(function (data, status, headers, config) {
          s = false;
          waitingIcon.close();
        });
      return(s);
    };

    CTableRsas.prototype.linkServerPostData = function(tbl, data){
      var s;
      waitingIcon.open();
      $http({
          url: this.url,
          method: "POST",
          data: data
        })
        .success(function (data, status, headers, config) {
          tbl.pTotal = data.total;
          tbl.pNow = data.now;
          tbl.goPage = data.now;
          tbl.show = data.show;
          s = true;
          tbl.successDo(data);
          waitingIcon.close();
        })
        .error(function (data, status, headers, config) {
          s = false;
          waitingIcon.close();
        });
      return(s);
    };
    return(CTableRsas);
  }
);


/* EOF */

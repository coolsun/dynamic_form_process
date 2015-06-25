'use strict';

/* Filters */
var rsasFilters = angular.module('rsasFilters', ['ui.calendar', 'ui.bootstrap']);
rsasFilters
.filter("datetimeFormatUTC2ZoneSub8", function() {
  return function(input) {
    var dt = new Date(input);
    dt = transDateTimeAtZoneUTCToSub8(dt);
    var dtSub8 = [];
    var dtDateSub8 = [];
    var dtTimeSub8 = [];

    dtDateSub8.push(dt.getUTCMonth() + 1);
    dtDateSub8.push("/");
    dtDateSub8.push(dt.getUTCDate());
    dtDateSub8.push("/");
    dtDateSub8.push(dt.getUTCFullYear());
    dtSub8.push(dtDateSub8.join(""));
    dtTimeSub8.push(dt.getUTCHours());
    dtTimeSub8.push(":");
    dtTimeSub8.push(dt.getUTCMinutes());
    /*
    dtTimeSub8.push(":");
    dtTimeSub8.push(dt.getUTCSeconds());
    */
    dtSub8.push(dtTimeSub8.join(""));
    return (dtSub8.join(" ").replace (/(\b|\:|-|\s)(\d)(?=\D|$)/g, '$10$2'));
  };
})
.filter("dateFormatUTC2ZoneSub8", function() {
  return function(input) {
    var dt = new Date(input);
    dt = transDateTimeAtZoneUTCToSub8(dt);
    var dtDateSub8 = [];

    dtDateSub8.push(dt.getUTCMonth() + 1);
    dtDateSub8.push("/");
    dtDateSub8.push(dt.getUTCDate());
    dtDateSub8.push("/");
    dtDateSub8.push(dt.getUTCFullYear());
    return (dtDateSub8.join('').replace (/(\b|\:|-|\s)(\d)(?=\D|$)/g, '$10$2'));
  };
})
.filter("timeFormatUTC2ZoneSub8", function() {
  return function(input) {
    var dt = new Date(input);
    dt = transDateTimeAtZoneUTCToSub8(dt);
    var dtTimeSub8 = [];

    dtTimeSub8.push(dt.getUTCHours());
    dtTimeSub8.push(":");
    dtTimeSub8.push(dt.getUTCMinutes());
    /*
    dtTimeSub8.push(":");
    dtTimeSub8.push(dt.getUTCSeconds());
    */
    return (dtTimeSub8.join("").replace (/(\b|\:|-|\s)(\d)(?=\D|$)/g, '$10$2'));
  };
})
.filter("showPositionsUseLocationsAndRoles", function() {
  return function(positions, locations, roles){
    var filtered = [];
    var location_ids =[];
    var role_ids =[];

    angular.forEach(locations, function(location){
      location_ids.push(location.id);
    });
    angular.forEach(roles, function(role){
      role_ids.push(role.id);
    });
    angular.forEach(positions, function(position){
      if((location_ids.length == 0 || location_ids.indexOf(position.location_id) != -1) && (role_ids.length == 0 || role_ids.indexOf(position.role_id) != -1)){
        filtered.push(position);
      }
    });
    return filtered;
  };
})
;

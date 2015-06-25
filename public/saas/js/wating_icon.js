/**
 * last update : 2014, AUG 05
 */

var icon = angular.module("waitingIconModule", []);

icon.value("countWaiting", 0);
icon.factory("waitingIcon", ["countWaiting",
  function(countWaiting){
    return({
      open: function(){
        countWaiting += 1;
        $("#waiting_icon").show();
      },

      close: function(){
        countWaiting -= 1;
        if (0 == countWaiting)
        {
          $("#waiting_icon").hide();
        }
      }
    });
  }
]);

/* EOF */

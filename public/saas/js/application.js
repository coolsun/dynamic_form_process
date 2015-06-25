//console.log = function(){};
function validateEmail(email) {
    var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(email);
}

function http_array_safe(array){
  return array.length == 0 ? null : array;
}

function pluck_array(array, key){
  var return_array = [];
  if(array){
    for(var i = 0; i < array.length; i++){
      return_array.push(array[i][key]);
    }
  }
  return return_array;
}

function findObj(array, key, value){
  var return_value = null;
  if(array){
    for(var i = 0; i < array.length; i++){
      if(array[i][key] == value){
        return_value = array[i];
        break;
      }
    }
  }
  return return_value;
}

function findObjs(array, key, value){
  var return_value = [];
  for(var i = 0; i < array.length; i++){
    if(array[i][key] == value){
      return_value.push(array[i]);
    }
  }
  return return_value;
}

function selectObjs(array, select_arr){ //select_arr = [[key1,value1],[key2,value2],[key3,value3]...]
  var return_array = array;
  for(var j = 0; j < select_arr.length; j++){
    var tmp_array = [];
    for(var i = 0; i < return_array.length; i++){
      if(return_array[i][select_arr[j][0]] == select_arr[j][1]){
        tmp_array.push(return_array[i]);
      }
    }
    return_array = tmp_array;
  }
  return return_array;
}

function findMax(array, key){
  var value = 0;
  for(var i = 0; i < array.length; i++){
    if(array[i][key] > value){
      value = array[i][key];
    }
  }
  return value;
}


function checkPositiveInteger(n) {
  var c = new RegExp(/^[1-9]+\d*$/);
  return(c.test(n));
};

function transDateTimeAtZoneSub8ToUTC(dt){
  dt.setUTCHours(dt.getUTCHours() + 8);
  return (dt);
};

function transDateTimeAtZoneUTCToSub8(dt){
  dt.setUTCHours(dt.getUTCHours() - 8);
  return (dt);
};

function transDateTimeAtZoneSub8ToUTCRemoveClientZone(dt){
  var clientZone = dt.getTimezoneOffset() / 60;
  dt.setUTCHours(dt.getUTCHours() + 8 - clientZone);
  return (dt);
};

function transDateTimeAtZoneUTCToSub8RemoveClientZone(dt){
  var clientZone = dt.getTimezoneOffset() / 60;
  dt.setUTCHours(dt.getUTCHours() - 8 - clientZone);
  return (dt);
};

function transDateTimeAtZoneSub8ToUTCExistClientZone(dt){
  var clientZone = dt.getTimezoneOffset() / 60;
  dt.setUTCHours(dt.getUTCHours() + 8 + clientZone);
  return (dt);
};

function transDateTimeAtZoneUTCToSub8ExistClientZone(dt){
  var clientZone = dt.getTimezoneOffset() / 60;
  dt.setUTCHours(dt.getUTCHours() - 8 + clientZone);
  return (dt);
};


function combineUserName(user){
  var user_name = "User Info Missing";
  if(user){
    user_name = [user.first_name, user.middle_name, user.last_name].join(" ");
  }
  return user_name;
}




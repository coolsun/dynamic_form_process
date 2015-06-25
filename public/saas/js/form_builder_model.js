var flow_num = 0;

// The .drag-item are draggable items like text, radio buttons, etc.
$(".drag-item").draggable({
  cancel : null, // Cancel the default events on the controls
  helper : "clone",
  cursor : "move"
});

//. drag-block are droppable blocks at the bottom of the page
$(".drop-block")
.droppable({
  hoverClass : "drop-block-hover",
  accept : ":not(.ui-sortable-helper)",
  drop : function(event, ui) {
    // Create a sort-item div, and insert the item html into it.  Then append it to the drop-block
    $('<div id="flow_' + flow_num + '" class="sort-item" href="#control-item-modify" data-toggle="modal" style="cursor:pointer;"></div>')
    .html(ui.draggable.html()).appendTo(this);
    flow_num ++;
    
    $(".sort-item").click(function(){
      // Get the element data into pop window
      $("div.form-group").show();
      $("div#form-id").find("input#id").attr("value",this.id);

      switch(this.children[0].attributes["class"].value)
      {
        case "simple":
          $("div#form-options").hide();
          
          $("div#form-label").find("input#label")[0].value = this.children[0].innerHTML;
          $("div#form-name").find("input#name")[0].value = this.children[1].name;
          $("div#form-placeholder").find("input#placeholder")[0].value = this.children[1].placeholder;
        break;
        
        case "select":
          $("div#form-placeholder").hide();
          
          $("div#form-label").find("input#label")[0].value = this.children[0].innerHTML;
          $("div#form-name").find("input#name")[0].value = this.children[1].name;
          var content = "";
          for(var i = 0; i < this.children[1].length; i ++){
            content += this.children[1].children[i].innerHTML + "\n";
          }
          $("div#form-options").find("textarea#options")[0].value = content;
        break;
        
        case "multiple":
          $("div#form-placeholder").hide();
          
          $("div#form-label").find("input#label")[0].value = this.children[0].innerHTML;
          $("div#form-name").find("input#name")[0].value = this.children[1].children[0].name;
          var content = "";
          for(var i = 1; i < this.children.length; i ++){
            content += this.children[i].children[1].innerHTML + "\n";
          }
          $("div#form-options").find("textarea#options")[0].value = content;
        break;
        
        case "button":
          $("div#form-name").hide();
          $("div#form-options").hide();
          $("div#form-placeholder").hide();
          
          $("div#form-label").find("input#label")[0].value = this.children[1].innerHTML;
        break;
      }
    });
  }
}).sortable({
  cancel : null, // Cancel the default events on the controls
  connectWith : ".drop-block"
}).disableSelection();

$("#modal-delete").click(function(){
  var delete_id = "#" + $("div#form-id").find("input#id")[0].value;
  $(delete_id).remove();
});

$("#modal-change").click(function(){
  var change_id = "#" + $("div#form-id").find("input#id")[0].value;
  
  // Data back to the clicked item
  switch($(change_id)[0].children[0].attributes["class"].value)
  {
    case "simple":
      $(change_id)[0].children[0].innerHTML = $("div#form-label").find("input#label")[0].value;
      $(change_id)[0].children[1].name = $("div#form-name").find("input#name")[0].value;
      $(change_id)[0].children[1].placeholder = $("div#form-placeholder").find("input#placeholder")[0].value;
    break;
    
    case "select":
      $(change_id)[0].children[0].innerHTML = $("div#form-label").find("input#label")[0].value;
      $(change_id)[0].children[1].name = $("div#form-name").find("input#name")[0].value;
      
      options = $("div#form-options").find("textarea#options")[0].value.split("\n");
      var new_options = "";
      for(var i = 0; i < options.length; i ++)
      {
        new_options += "<option value='option" + (i + 1) + "'>" + options[i] + "</option>";
      }
      $(change_id)[0].children[1].innerHTML = new_options;
    break;
    
    case "multiple":
      $(change_id)[0].children[0].innerHTML = $("div#form-label").find("input#label")[0].value;
      
      options = $("div#form-options").find("textarea#options")[0].value.split("\n");
      var new_options = "<label class='multiple'>" + $("div#form-label").find("input#label")[0].value + "</label>";
      for(var i = 0; i <options.length; i ++)
      {
        new_options += "<label class='" + $(change_id)[0].children[1].attributes["class"].value + "'>"
                     + "<input type='" + $(change_id)[0].children[1].attributes["class"].value
                          + "' name='" + $("div#form-name").find("input#name")[0].value 
                          + "' value='option" + (i + 1) + "'>"
                     + "<span>" + options[i] + "</span>"
                     + "</label>\n";
      }
      $(change_id)[0].innerHTML = new_options;
    break;
    
    case "button":
      $(change_id)[0].children[1].innerHTML = $("div#form-label").find("input#label")[0].value;
    break;
  }
});

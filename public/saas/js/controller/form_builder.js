var formBuilderModule = angular.module('formBuilderApp', []);

formBuilderModule.controller('FormBuilder',
  function($scope, $sce, $rootScope, formBuilderFactory, userFormFactory, waitingIcon) {
    // Get the forms with this process from DB first
    $scope.current_form = null;
    if(location.hash.indexOf('global') != -1){
      $scope.process_id = 0;
    }
    else{
      $scope.process_id = $rootScope.current_process.id;
      $scope.sub_step_identify_name = $rootScope.current_sub_step.identify_name;
    }

    if($scope.sub_step_identify_name == "set_up_attachable_forms" || $scope.sub_step_identify_name == "post_offer_fill_in_form") {
      $scope.tag_type = "";
      $scope.selected = { "roles" : [], "locations" : [], "positions" : [] };
    }

    formBuilderFactory.showProcessForms($scope.process_id, $scope.sub_step_identify_name, $rootScope.current_year.id, $rootScope.current_process.id)
    .success(function(data) {
      if(data.success) {
        $scope.forms_obj = data.forms;
        $scope.permission_to_active = data.permission_to_active;
        if($scope.sub_step_identify_name == "set_up_attachable_forms" || $scope.sub_step_identify_name == "post_offer_fill_in_form") {
          $scope.role_list = data.all_tag_sets.roles;
          $scope.location_list = data.all_tag_sets.locations;
          $scope.position_list = data.all_tag_sets.positions;
        }
        $rootScope.rsasAlert({type: 'success', msg: "The form(s) have been got successfully."});
      }
      else {
        $rootScope.rsasAlert({type: 'danger', msg: "There was a problem to get the form(s)."});
      }
    })
    .error(function(data) {
      $rootScope.rsasAlert({type: 'danger', msg: "There was a problem to get the form(s)."});
    });

    // Go back the oldest situation, after saving or deleting form
    $scope.init = function() {
      $("#current-fname").val("New Form"); // This is for pre-set the new form name
      $("#render-block").html(""); // Clear the content of render block for user notice the new
      $("#preview-block").html(""); // Clear the preview block
      $scope.current_form = null; // Clear current form
      if($scope.sub_step_identify_name == "set_up_attachable_forms" || $scope.sub_step_identify_name == "post_offer_fill_in_form") {
        $scope.tag_type = "";
        $scope.selected = { "roles" : [], "locations" : [], "positions" : [] };
      }
      $scope.add_row(); // Append a row easy for new a form
    };

    function open_sort_item() {
      // Get the element data into pop window
      $("div.form-group").show();
      $("div#form-id").find("input#id").attr("value", $(this).attr("id"));
      $("div#form-label").find("input#label").attr("disabled",false);
      $("div#form-options").children(":first").html("Options:");
      $(this).children(":first").attr("rq") == "yes" ? $("div#form-rq").find("input#rq").prop("checked", true) : $("div#form-rq").find("input#rq").prop("checked", false);

      switch($(this).children(":first").attr("class")) {
        case "simple":
          $("div#form-options").hide();
          $("div#form-description").hide();
          $("div#form-maxlength").hide();
          $("div#form-label").find("input#label").val($(this).children(":first").html());
          $(this).children(":first").attr("ps") == "yes" ? $("div#form-ps").find("input#ps").prop("checked", true) : $("div#form-ps").find("input#ps").prop("checked", false);
        break;
        case "text-area":
          $("div#form-options").hide();
          $("div#form-description").hide();
          $("div#form-label").find("input#label").val($(this).children(":first").html());
          $("div#form-maxlength").find("input#maxlength").val($(this).children(":first").attr("maxlength"));
          $(this).children(":first").attr("ps") == "yes" ? $("div#form-ps").find("input#ps").prop("checked", true) : $("div#form-ps").find("input#ps").prop("checked", false);
        break;
        case "select":
          $("div#form-ps").hide();
          $("div#form-description").hide();
          $("div#form-maxlength").hide();
          $("div#form-label").find("input#label").val($(this).children(":first").html());
          var content = "";
          content += $(this).children("select").children(":first").html();
          for(var i = 1; i < $(this).children("select").children().length; i++) {
            content += "\n" + $(this).children("select").children().eq(i).html();
          }
          $("div#form-options").find("textarea#options").val(content);
        break;
        case "multiple":
          $("div#form-ps").hide();
          $("div#form-description").hide();
          $("div#form-maxlength").hide();
          $("div#form-label").find("input#label").val($(this).children(":first").html());
          var content = "";
          for(var i = 1; i < $(this).children().length; i ++) {
            if(i >= 2) {
              content += "\n";
            }
            for(var j = 0; j < $(this).children().eq(i).children().length; j ++) {
              if(j >= 1) {
                content += " | ";
              }
              content += $(this).children().eq(i).children().eq(j).children().eq(1).html();
            }
          }
          $("div#form-options").find("textarea#options").val(content);
        break;
        case "date":
          $("div#form-ps").hide();
          $("div#form-options").hide();
          $("div#form-description").hide();
          $("div#form-maxlength").hide();
          $("div#form-label").find("input#label").val($(this).children(":first").html());
        break;
        case "file":
          $("div#form-ps").hide();
          $("div#form-options").hide();
          $("div#form-description").hide();
          $("div#form-maxlength").hide();
          $("div#form-rq").hide();
          $("div#form-label").find("input#label").val($(this).children(":first").html());
        break;
        case "description":
          $("div#form-ps").hide();
          $("div#form-label").hide();
          $("div#form-options").hide();
          $("div#form-maxlength").hide();
          $("div#form-rq").hide();
          $("div#form-description").find("textarea.tinymce").val($(this).children(":first").html());
          tinyMCE.activeEditor.setContent($(this).children(":first").html());
        break;
        default:
          $("div#form-ps").hide();
          $("div#form-options").hide();
          $("div#form-description").hide();
          $("div#form-maxlength").hide();
          $("div#form-label").find("input#label").attr("disabled",true);
          $("div#form-label").find("input#label").val($(this).children(":first").html());
        break;
      }
    };

    function filter_html_tag(string_with_html) {
      var filter = string_with_html.replace("<script>","").replace("</script>","");
      return filter;
    }

    function refresh_render_block() {
      $("#render-block").find(".row-in-form").each(function() {
        var a = 12 / $(this).children(".drop-block").length;
        $(this).children(".drop-block").removeClass("col-lg-12");
        $(this).children(".drop-block").removeClass("col-lg-6");
        $(this).children(".drop-block").removeClass("col-lg-4");
        $(this).children(".drop-block").addClass("col-lg-" + a);
      });
    }
    function prepare_to_save() {
      if($("#current-fname").val()) {
        $("#get-form-name").html($("#current-fname").val());
      }
      else {
        $("#get-form-name").html("(No Title)");
      }
      $("#preview-block").html($("#render-block").html());
      $("#preview-block").find(".sort-item").removeAttr("href style").css({"border":"2px transparent dashed"}); // Clear the attributes no needed at user
      $("#preview-block").find(".drop-block").css({"border":"2px transparent dashed"});

      $("#preview-block").find(".row-in-form").css({"border":"2px transparent dashed"});
      $("#preview-block").find(".control-grid").remove(); // When preview, no change actions
    }

    var flow_num = 0;
    var drop_module = {
      accept: ":not(.ui-sortable-helper)",
      drop: function(event, ui) {
        if($("#render-block").find("label.file").length > 0 && ui.draggable.find("label.file").length > 0) {
          alert("Only one file upload element per form.");
        }
        else {
          // Create a sort-item div, and insert the item html into it.  Then append it to the drop-block
          $('<div id="flow-' + flow_num + '" class="sort-item" href="#control-item-modify" data-toggle="modal" style="cursor:pointer;"></div>')
          .html(ui.draggable.html()).appendTo(this);
          flow_num++;

          $(".sort-item").click(open_sort_item);
          $(".sort-item").find(".cover-icon").remove();
        }
      }
    };

    // The .drag-item are draggable items like text, radio buttons, etc.
    $(".drag-item").draggable({
      cancel : null, // Cancel the default events on the controls
      helper : "clone",
      cursor : "move"
    });

    // Delete the control item
    $("#modal-delete").click(function() {
      var delete_id = "#" + $("div#form-id").find("input#id").val();
      $(delete_id).remove();
    });

    // Change the control item
    $("#modal-change").click(function() {
      var change_id = "#" + $("div#form-id").find("input#id").val();

      $("div#form-rq").find("input#rq").prop("checked") ? $(change_id).children(":first").attr("rq","yes") : $(change_id).children(":first").attr("rq","no");
      // Data back to the clicked item
      switch($(change_id).children(":first").attr("class"))
      {
        case "simple":
          $(change_id).children(":first").html(filter_html_tag($("div#form-label").find("input#label").val()));
          $("div#form-ps").find("input#ps").prop("checked") ? $(change_id).children(":first").attr("ps","yes") : $(change_id).children(":first").attr("ps","no");
        break;
        case "text-area":
          $(change_id).children(":first").html(filter_html_tag($("div#form-label").find("input#label").val()));
          $(change_id).children(":first").attr("maxlength", $("div#form-maxlength").find("input#maxlength").val());
          $("div#form-ps").find("input#ps").prop("checked") ? $(change_id).children(":first").attr("ps","yes") : $(change_id).children(":first").attr("ps","no");
        break;
        case "select":
          $(change_id).children(":first").html(filter_html_tag($("div#form-label").find("input#label").val()));
          options = filter_html_tag($("div#form-options").find("textarea#options").val()).split("\n");
          var new_options = "";
          for(var i = 0; i < options.length; i ++)
          {
            if(options[i] && options[i].match(/\S/g)){
              new_options += "<option value='option" + (i + 1) + "'>" + options[i] + "</option>";
            }
          }
          $(change_id).children().eq(1).html(new_options);
        break;
        case "multiple":
          var options_lines = filter_html_tag($("div#form-options").find("textarea#options").val()).split("\n"); // Separate each line to a array contain lines
          var option = [];
          for(var i = 0; i < options_lines.length; i ++) {
            var options = options_lines[i].split(" | "); // Each line become array, separate by " | "
            for(var j = 0; j < options.length; j ++) {
              if(options[j] != "" && options[j].match(/\S/g)) { // Check the item is not a 0-length string and contain a character not white-space
                // It's normal, so nothing happened ..
              }
              else { // So if options[j] is null or all the white-space, delete it in array
                var position = options.indexOf(options[j]);
                options.splice(position, 1);
                j = -1; // Reset the counter j because the length will become shorter after deleting element
              }
            }
            if(options.length != 0) {
              option.push(options);
            }
          }

          var new_options;
          $("div#form-rq").find("input#rq").prop("checked") ? new_options = "<label class='multiple' rq='yes'>" + filter_html_tag($("div#form-label").find("input#label").val()) + "</label>" : new_options = "<label class='multiple' rq='no'>" + filter_html_tag($("div#form-label").find("input#label").val()) + "</label>";
          for(var i = 0; i < option.length; i ++) {
            new_options += "<div class='normal-height'>";
            for(var j = 0; j < option[i].length; j ++) {
              new_options += "<label class='" + $(change_id).children().eq(1).children(":first").attr("class") + "'>"
                           + "<input type='" + $(change_id).children().eq(1).children(":first").attr("class")
                                + "' value='option" + i + "-" + j + "'>"
                           + "<span>" + option[i][j] + "</span>"
                           + "</label>";
            }
            new_options += "</div>";
          }
          $(change_id).html(new_options);
        break;
        case "date":
          $(change_id).children(":first").html(filter_html_tag($("div#form-label").find("input#label").val()));
        break;
        case "file":
          $(change_id).children(":first").html(filter_html_tag($("div#form-label").find("input#label").val()));
        break;
        case "description":
          var text = $("div#form-description").find("textarea.tinymce").val();
          $(change_id).children(":first").html(text);
        break;
      }
    });

    // Preview button clicked, preview-block get html tag code inside.
    $("#preview").click(prepare_to_save);

    $scope.save_form = function() {
      prepare_to_save();

      new_schema = [];

      // Change the id for each block element to differ the block added later
      var save_flow_num = 0;
      $("#preview-block").find(".row-in-form").each(function() {
        $(this).attr("id","exist-row-" + save_flow_num);
        save_flow_num ++;
      });

      save_flow_num = 0;
      $("#preview-block").find(".drop-block").each(function() {
        $(this).attr("id","exist-drop-" + save_flow_num);
        save_flow_num ++;
      });

      save_flow_num = 0;
      // Push the schema to json for user form constructed
      $("#preview-block").find(".sort-item").each(function() {
        var father = $(this).parent();
        var uncles = $(this).parent().parent().children();
        var father_th = uncles.index(father);

        var grandpa = $(this).parent().parent();
        var granduncles = $(this).parent().parent().parent().children();
        var grandpa_th = granduncles.index(grandpa);

        // Change the id to exist_x to avoid the id same with later for editing
        $(this).attr("id","exist-sort-" + save_flow_num);
        save_flow_num ++;

        var ps_situation = $(this).children(":first").attr("ps") == "yes" ? true : false;
        var rq_situation = $(this).children(":first").attr("rq") == "yes" ? true : false;

        // Identify what kind of this input type, and push different schema to the forms
        switch($(this).children().eq(0).attr("class"))
        {
          case "simple":
            new_schema.push({
              row: grandpa_th,
              column: father_th,
              description: $(this).children(":first").html(),
              type: $(this).children().eq(1).attr("type"),
              ps: ps_situation,
              rq: rq_situation
            });
          break;
          case "text-area":
            new_schema.push({
              row: grandpa_th,
              column: father_th,
              description: $(this).children(":first").html(),
              maxlength: $(this).children(":first").attr("maxlength"),
              type: $(this).children().eq(1).prop("tagName").toLowerCase(),
              ps: ps_situation,
              rq: rq_situation
            });
          break;
          case "select":
            new_options = [];
            for(var i = 0; i < $(this).children().eq(1).children().length; i ++) {
              new_options.push($(this).children().eq(1).children().eq(i).html());
            }
            // Here is the code to check multiple select
            if($(this).children().eq(1).attr("multiple")) {
              new_schema.push({
                row: grandpa_th,
                column: father_th,
                description: $(this).children(":first").html(),
                type: "multi-" + $(this).children().eq(1).prop("tagName").toLowerCase(),
                options: new_options,
                rq: rq_situation
              });
            }
            else {
              new_schema.push({
                row: grandpa_th,
                column: father_th,
                description: $(this).children(":first").html(),
                type: $(this).children().eq(1).prop("tagName").toLowerCase(),
                options: new_options,
                rq: rq_situation
              });
            }
          break;
          case "multiple":
            new_options = [];
            for(var i = 1; i < $(this).children().length; i ++) {
              if(i >= 2) {
                new_options.push("<br />");
              }
              for(var j = 0; j < $(this).children().eq(i).children().length; j ++) {
                new_options.push($(this).children().eq(i).children().eq(j).children().eq(1).html());
              }
            }
            new_schema.push({
              row: grandpa_th,
              column: father_th,
              description: $(this).children(":first").html(),
              type: $(this).children().eq(1).children(":first").children(":first").attr("type"),
              options: new_options,
              rq: rq_situation
            });
          break;
          case "date":
            new_schema.push({
              row: grandpa_th,
              column: father_th,
              description: $(this).children(":first").html(),
              type: "date",
              rq: rq_situation
            });
          break;
          case "file":
            new_schema.push({
              row: grandpa_th,
              column: father_th,
              description: $(this).children(":first").html(),
              type: "file"
            });
          break;
          case "description":
            new_schema.push({
              row: grandpa_th,
              column: father_th,
              description: $(this).children(":first").html(),
              type: "description"
            });
          break;
          // Here are special input dealing
          case "name":
            new_schema.push({
              row: grandpa_th,
              column: father_th,
              description: $(this).children(":first").html(),
              type: "name",
              rq: rq_situation
            });
          break;
          case "e-mail":
            new_schema.push({
              row: grandpa_th,
              column: father_th,
              description: $(this).children(":first").html(),
              type: "email",
              rq: rq_situation
            });
          break;
        }
      });

      new_form_name = $("#current-fname").val();
      new_form_html_tag = $("#preview-block").html();

      // At least one non-whitespace character, and all the non-whitespace are A-Z a-z 0-9
      if(new_form_name.match(/\S/g) && new_form_name.replace(/ /g, "").match(/\W/g) == null) {
        $scope.forms_obj = null;
        if($scope.current_form) {
          // If $scope.current_form_id exist, means the form existed, it's update action now
          formBuilderFactory.editOldForm($scope.current_form.id,
                                         $scope.process_id,
                                         $scope.sub_step_identify_name,
                                         $scope.tag_type,
                                         $scope.selected,
                                         new_form_name,
                                         new_form_html_tag,
                                         new_schema,
                                         $rootScope.current_year.id,
                                         $rootScope.current_process.id)
          .success(function(data) {
            if(data.success){
              $scope.forms_obj = data.forms;
              $rootScope.rsasAlert({type: 'success', msg: "This form is updated successfully."});
            }
            else{
              $rootScope.rsasAlert({type: 'danger', msg: "There was a problem to update the form."});
            }
          })
          .error(function(data) {
            $rootScope.rsasAlert({type: 'danger', msg: "There was a problem to update the form."});
          });
        }else {
          // Else if there is no current form id, add a new form
          formBuilderFactory.saveNewForm($scope.process_id,
                                         $scope.sub_step_identify_name,
                                         $scope.tag_type,
                                         $scope.selected,
                                         new_form_name,
                                         new_form_html_tag,
                                         new_schema,
                                         $rootScope.current_year.id,
                                         $rootScope.current_process.id)
          .success(function(data) {
            if(data.success){
              $scope.forms_obj = data.forms;
              $rootScope.rsasAlert({type: 'success', msg: "This form is created successfully."});
            }
            else{
              $rootScope.rsasAlert({type: 'danger', msg: "There was a problem to create the form."});
            }
          })
          .error(function(data) {
            $rootScope.rsasAlert({type: 'danger', msg: "There was a problem to create the form."});
          });
        }

        $scope.init();
      }
      else {
        alert("Illegal Title");
      }
      // After saving or updating form, we initial the form render
    };

    // This function named "edit_form", but it is just get form data to render block from forms array or DB, not really editting form
    $scope.edit_form = function(form) {
      $scope.current_form = form;
      $scope.selected = { "roles" : [], "locations" : [], "positions" : [] };

      $("#current-fname").val($scope.current_form.form_name); // Get the form name
      $("#render-block").html($scope.current_form.html); //Get the form content

      if($scope.sub_step_identify_name == "set_up_attachable_forms" || $scope.sub_step_identify_name == "post_offer_fill_in_form") {
        angular.forEach($scope.current_form.form_tags, function(tag){
          if(tag.role_id) {
            role_tag = findObj($scope.role_list, "id", tag.role_id);
            $scope.selected.roles.push(role_tag);
          }
          if(tag.location_id) {
            location_tag = findObj($scope.location_list, "id", tag.location_id);
            $scope.selected.locations.push(location_tag);
          }
          if(tag.position_id) {
            position_tag = findObj($scope.position_list, "id", tag.position_id);
            $scope.selected.positions.push(position_tag);
          }
        });
        if($scope.selected.roles.length != 0) {
          $scope.tag_type = "R";
        }
        else if($scope.selected.locations.length != 0) {
          $scope.tag_type = "L";
        }
        else if($scope.selected.positions.length != 0) {
          $scope.tag_type = "P";
        }
        else {
          $scope.tag_type = "";
        }
      }

      $("#render-block").find(".row-in-form,.sort-item").css({"border":"2px #ffaaaa dashed"}); // Get the border back for showing lightly
      $("#render-block").find(".drop-block").css({"border":"2px #0000ff dashed"}); // The drop blocks have different color

      $("<div class='control-grid'></div>").appendTo(".row-in-form");

      $("<button class='btn btn-default' title='Add One Grid'><i class='glyphicon glyphicon-unchecked'></i><i class='glyphicon glyphicon-log-out'></i></button>")
      .appendTo(".control-grid")
      .click(function() {
        if($(this).parent().siblings(".drop-block").length >= 3) {
          alert("Max: 3 columns");
        }else if($(this).parent().siblings(".drop-block").length <= 2 && $(this).parent().siblings(".drop-block").length >= 0){
          drop_num ++;
          $(this).parent().before("<div id='drop-" + drop_num + "' class='drop-block'></div>");
          refresh_render_block();

          $(this).parent().parent().find(".drop-block:last")
          .droppable(drop_module)
          .dblclick(function() {
            if(confirm("Are you sure to delete this grid?") == true) {
              $(this).remove();
              refresh_render_block();
            }
          })
          .sortable({
            cursor: "move",
            cancel : null, // Cancel the default events on the controls
            connectWith : ".drop-block"
          })
          .disableSelection();
        }
      });

      $("<button class='btn btn-default' title='Delete Row'><i class='glyphicon glyphicon-trash'></i></button>").appendTo(".control-grid")
      .click(function() {
        if(confirm("Are you sure to delete this row?") == true) {
          $(this).parent().parent().remove();
        }
      });

      $("#render-block").find(".drop-block")
      .droppable(drop_module)
      .dblclick(function() {
        if(confirm("Are you sure to delete this grid?") == true) {
          $(this).remove();
          refresh_render_block();
        }
      })
      .sortable({
        cursor: "move",
        cancel : null, // Cancel the default events on the controls
        connectWith : ".drop-block"
      }).disableSelection();

      $("#render-block").find(".sort-item").css({"cursor":"pointer"}).attr("href","#control-item-modify");

      $(".sort-item").click(open_sort_item);
    };

    $scope.delete_this_form = function() {
      if(confirm('Are you sure to delete this form "' + $scope.current_form.form_name + '"?') == true) {
        $scope.forms_obj = null;
        // Delete the form in the array 'forms'
        formBuilderFactory.deleteForm($scope.current_form.id,
                                      $scope.process_id,
                                      $scope.sub_step_identify_name,
                                      $rootScope.current_year.id,
                                      $rootScope.current_process.id)
        .success(function(data) {
          if(data.success){
            $scope.forms_obj = data.forms;
            $rootScope.rsasAlert({type: 'success', msg: "This form is deleted successfully."});
          }
          else{
            $rootScope.rsasAlert({type: 'danger', msg: "There was a problem to delete the form."});
          }
        })
        .error(function(data) {
          $rootScope.rsasAlert({type: 'danger', msg: "There was a problem to delete the form."});
        });

        $scope.init();
      }
    };

    // Toggle the current form show or hide on applicant page
    $scope.toggle_form_show = function() {
      $("#wait-response-icon").show();
      formBuilderFactory.toggleShow($scope.current_form.id,
                                    !$scope.current_form.display,
                                    $scope.process_id,
                                    $scope.sub_step_identify_name,
                                    $rootScope.current_year.id,
                                    $rootScope.current_process.id)
      .success(function(data) {
        if(data.success){
          $scope.forms_obj = data.forms;
          $scope.current_form = findObj($scope.forms_obj, "id", $scope.current_form.id);
          $rootScope.rsasAlert({type: 'success', msg: "This form is changed display successfully."});
        }
        else{
          $rootScope.rsasAlert({type: 'danger', msg: "There was a problem to change the display of form."});
        }
        $("#wait-response-icon").hide();
      })
      .error(function (data) {
        $rootScope.rsasAlert({type: 'danger', msg: "There was a problem to change the display of form."});
        $("#wait-response-icon").hide();
      });
    };

    // This add_row function is add new row in render block, Add form and Edit form can use
    var drop_num = 0;
    var current_grid_num;
    $scope.add_row = function() {
      var new_row = $("<div class='col-lg-12 row-in-form'></div>").appendTo("#render-block");

      // When a new row added, just append a drop-block to it
      $("<div id='drop-" + drop_num + "' class='drop-block col-lg-12'></div>").appendTo(new_row)
      .droppable(drop_module)
      .dblclick(function(){
        if(confirm("Are you sure to delete this grid?") == true) {
          $(this).remove();
          refresh_render_block();
        }
      })
      .sortable({
        cursor: "move",
        cancel : null, // Cancel the default events on the controls
        connectWith : ".drop-block"
      })
      .disableSelection();
      drop_num ++;

      var control_grid = $("<div class='control-grid pull-right'></div>").appendTo(new_row);

      // And there is a repeat code for the drop-block which is added later
      var call_uncle = $("<button class='btn btn-default btn-xs' title='Add One Grid'><i class='glyphicon glyphicon-unchecked'></i><i class='glyphicon glyphicon-log-out'></i></button>")
      .appendTo(control_grid)
      .click(function() {
        if($(this).parent().siblings(".drop-block").length >= 3) {
          alert("Max: 3 columns");
        }else if($(this).parent().siblings(".drop-block").length <= 2 && $(this).parent().siblings(".drop-block").length >= 0){
          $(this).parent().before("<div id='drop-" + drop_num + "' class='drop-block'></div>");
          drop_num ++;
          refresh_render_block();

          $(this).parent().parent().find(".drop-block:last")
          .droppable(drop_module)
          .dblclick(function() {
            if(confirm("Are you sure to delete this grid?") == true) {
              $(this).remove();
              refresh_render_block();
            }
          })
          .sortable({
            cursor: "move",
            cancel : null, // Cancel the default events on the controls
            connectWith : ".drop-block"
          })
          .disableSelection();
        }
      });

      // Set delete button for each rows
      $("<button class='btn btn-default btn-xs' title='Delete Row'><i class='glyphicon glyphicon-trash'></i></button>").appendTo(control_grid)
      .click(function() {
        if(confirm("Are you sure to delete this row?") == true) {
          $(this).parent().parent().remove(); // Kill grandpa.. and grandpa's sons and grandsons all be killed..
        }
      });

      $("<button class='btn btn-default btn-xs' title='Insert Row'><i class='glyphicon glyphicon-arrow-down'></i></button>").appendTo(control_grid)
      .click(function(){
        var new_row_after = $("<div class='col-lg-12 row-in-form'></div>").insertAfter($(this).parent().parent());

        // When a new row added, just append a drop-block to it
        $("<div id='drop-" + drop_num + "' class='drop-block col-lg-12'></div>").appendTo(new_row_after)
        .droppable(drop_module)
        .dblclick(function(){
          if(confirm("Are you sure to delete this grid?") == true) {
            $(this).remove();
            refresh_render_block();
          }
        })
        .sortable({
          cursor: "move",
          cancel : null, // Cancel the default events on the controls
          connectWith : ".drop-block"
        })
        .disableSelection();
        drop_num ++;

        var control_grid_after = $("<div class='control-grid pull-right'></div>").appendTo(new_row_after);

        // And there is a repeat code for the drop-block which is added later
        var call_uncle = $("<button class='btn btn-default btn-xs' title='Add One Grid'><i class='glyphicon glyphicon-unchecked'></i><i class='glyphicon glyphicon-log-out'></i></button>")
        .appendTo(control_grid_after)
        .click(function() {
          if($(this).parent().siblings(".drop-block").length >= 3) {
            alert("Max: 3 columns");
          }else if($(this).parent().siblings(".drop-block").length <= 2 && $(this).parent().siblings(".drop-block").length >= 0){
            $(this).parent().before("<div id='drop-" + drop_num + "' class='drop-block'></div>");
            drop_num ++;
            refresh_render_block();

            $(this).parent().parent().find(".drop-block:last")
            .droppable(drop_module)
            .dblclick(function() {
              if(confirm("Are you sure to delete this grid?") == true) {
                $(this).remove();
                refresh_render_block();
              }
            })
            .sortable({
              cursor: "move",
              cancel : null, // Cancel the default events on the controls
              connectWith : ".drop-block"
            })
            .disableSelection();
          }
        });

        $("<button class='btn btn-default btn-xs' title='Delete Row'><i class='glyphicon glyphicon-trash'></i></button>").appendTo(control_grid_after)
        .click(function() {
          if(confirm("Are you sure to delete this row?") == true) {
            $(this).parent().parent().remove(); // Kill grandpa.. and grandpa's sons and grandsons all be killed..
          }
        });

        $(this).clone(true).appendTo(control_grid_after);
      });
    };

    $scope.get_form_translations = function(){
      waitingIcon.open();
      userFormFactory.getFormTranslations()
      .success(function (data){
        if (data.success){
          $scope.form_translations = data.form_translations;
        }
        else {
          $rootScope.rsasAlert({type: 'danger', msg: "Failed to get the form translations."});
        };
        waitingIcon.close();
      })
      .error(function (data){
        $rootScope.rsasAlert({type: 'danger', msg: "Failed to get the form translations."});
        waitingIcon.close();
      });
    };

    $scope.clone_form = function(form){
      waitingIcon.open();
      formBuilderFactory.cloneForm(form, $rootScope.current_year.id, $rootScope.current_process.id)
      .success(function (data){
        if (data.success){
          $scope.forms_obj.push(data.form);
        }
        else {
          $rootScope.rsasAlert({type: 'danger', msg: "Failed to clone the form."});
        };
        waitingIcon.close();
      })
      .error(function (data){
        $rootScope.rsasAlert({type: 'danger', msg: "Failed to clone the form."});
        waitingIcon.close();
      });
    };

  }
);

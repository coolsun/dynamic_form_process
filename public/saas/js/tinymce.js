angular.module('ui.tinymce', []).value('uiTinymceConfig', {}).directive('uiTinymce', ['uiTinymceConfig',
function(uiTinymceConfig) {
  uiTinymceConfig = uiTinymceConfig || {};
  var generatedIds = 0;
  return {
    priority : 10,
    require : 'ngModel',
    link : function(scope, elm, attrs, ngModel) {
      var expression, options, tinyInstance, updateView = function() {
        ngModel.$setViewValue(elm.val());
        if (!scope.$root.$$phase) {
          scope.$apply();
        }
      };

      // generate an ID if not present
      if (!attrs.id) {
        attrs.$set('id', 'uiTinymce' + generatedIds++);
      }

      if (attrs.uiTinymce) {
        expression = scope.$eval(attrs.uiTinymce);
      } else {
        expression = {};
      }

      // make config'ed setup method available
      if (expression.setup) {
        var configSetup = expression.setup;
        delete expression.setup;
      }

      options = {
        relative_urls: false,
        remove_script_host: true,

        setup : function(ed) {
          var args;
          ed.on('init', function(args) {
            ngModel.$render();
            ngModel.$setPristine();
          });
          // Update model on button click
          ed.on('ExecCommand', function(e) {
            ed.save();
            updateView();
          });
          // Update model on keypress
          ed.on('KeyUp', function(e) {
            ed.save();
            updateView();
          });
          // Update model on change, i.e. copy/pasted text, plugins altering content
          ed.on('SetContent', function(e) {
            if (!e.initial && ngModel.$viewValue !== e.content) {
              ed.save();
              updateView();
            }
          });
          ed.on('blur', function(e) {
            elm.blur();
          });
          // Update model when an object has been resized (table, image)
          ed.on('ObjectResized', function(e) {
            ed.save();
            updateView();
          });
          if (configSetup) {
            configSetup(ed);
          }
        },
        mode : 'exact',
        elements : attrs.id,
        
        selector: "textarea#tinymce,textarea.tinymce",
        
        plugins: [
          "advlist autolink autosave link image lists charmap print preview hr anchor pagebreak spellchecker",
          "searchreplace wordcount visualblocks visualchars code fullscreen insertdatetime media nonbreaking",
          "table contextmenu directionality emoticons template textcolor paste fullpage textcolor"],

        toolbar1: "styleselect formatselect fontselect fontsizeselect | undo redo | preview",
        toolbar2: "table hr link unlink image media | inserttime alignleft aligncenter alignright alignjustify | outdent indent blockquote | bullist numlist | ltr rtl",
        toolbar3: "bold italic underline strikethrough | subscript superscript | forecolor backcolor | searchreplace | removeformat | nonbreaking",


        menubar: false,
        toolbar_items_size: 'middle',

        style_formats: [
          {title: 'Bold text', inline: 'b'},
          {title: 'Red text', inline: 'span', styles: {color: '#ff0000'}},
          {title: 'Red header', block: 'h1', styles: {color: '#ff0000'}},
          {title: 'Example 1', inline: 'span', classes: 'example1'},
          {title: 'Example 2', inline: 'span', classes: 'example2'},
          {title: 'Table styles'},
          {title: 'Table row 1', selector: 'tr', classes: 'tablerow1'}
        ],

        templates: [
          {title: 'One Line Text', content: 'This is a simple template.'}
        ]
      };
      // extend options with initial uiTinymceConfig and options from directive attribute value
      angular.extend(options, uiTinymceConfig, expression);
      setTimeout(function() {
        tinymce.init(options);
      });

      ngModel.$render = function() {
        if (!tinyInstance) {
          tinyInstance = tinymce.get(attrs.id);
        }
        if (tinyInstance) {
          tinyInstance.setContent(ngModel.$viewValue || '');
        }
      };

      scope.$on('$destroy', function() {
        if (!tinyInstance) {
          tinyInstance = tinymce.get(attrs.id);
        }
        if (tinyInstance) {
          tinyInstance.remove();
          tinyInstance = null;
        }
      });
    }
  };
}]); 

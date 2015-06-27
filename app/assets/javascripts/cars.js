//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready(function(){
	$('#delete_multiple').attr("disabled",'')
	$("#cars_list_table #checkall").click(function () {
        if ($("#cars_list_table #checkall").is(':checked')) {
            $("#cars_list_table input[type=checkbox]").each(function () {
                $(this).prop("checked", true);
            });

        } else {
            $("#cars_list_table input[type=checkbox]").each(function () {
                $(this).prop("checked", false);
            });
        }
    });
	var checkboxes = $("#cars_list_table input[type='checkbox']");
    
  checkboxes.click(function() {
    $('#delete_multiple').attr("disabled", !checkboxes.is(":checked"));
	});
	
})
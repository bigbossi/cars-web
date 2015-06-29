$('#all_cars_list').html('');
$('#all_cars_list').html('<%= j render(:partial => "cars_table_with_options", locals: {:cars => @cars}) %>')
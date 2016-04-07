$(document).ready(function () {
  var autocompleteStudents = {
    url: function(phrase) {
      return '/students/search.json';
    },
    getValue: function(element) {
      return element.name;
    },
    ajaxSettings: {
      dataType: "json",
      method: "GET",
      data: {
        dataType: "json"
      }
    },
    preparePostData: function(data) {
      data.phrase = $("#studentsSearch").val();
      return data;
    },
    requestDelay: 400
  };
  $("#studentsSearch").easyAutocomplete(autocompleteStudents);

  var autocompleteCourses = {
    url: function(phrase) {
      return '/courses/search.json';
    },
    getValue: function(element) {
      return element.name;
    },
    ajaxSettings: {
      dataType: "json",
      method: "GET",
      data: {
        dataType: "json"
      }
    },
    preparePostData: function(data) {
      data.phrase = $("#coursesSearch").val();
      return data;
    },
    requestDelay: 400
  };
  $("#coursesSearch").easyAutocomplete(autocompleteCourses);

  $(document).on('submit', '#classroom-form', function(e){
    e.preventDefault();
    //
    var action = $(this).attr('action');
    var data = {
        student: $('#studentsSearch').val(),
        course: $('#coursesSearch').val()
    };

    $.post(action, data, function(response){
        if (response.success) {
            location.reload();
        } else {
            alert(response.errors.join("\n"));
        }
    })
    //
    return false;
  })
});

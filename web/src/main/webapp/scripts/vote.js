var nc = 0;
function submitPoll(){
    nc++;
    var optionID = "";
    var selected = $("input[type='radio'][name='options']:checked");
    if (selected.length > 0) {
        optionID = selected.val();
    } else {
        Sexy.valert('Hãy chọn 1 mục trước khi biểu quyết.');
        return;
    }
    var surl = '/ajax/poll.html?optionID=' + optionID + '&pollID=' + $("#pollID").val();
    $.ajax({
        type: 'GET',
        cache: false,
        url: surl,
        timeout: 30000,
        error: function(xhr, ajaxOptions, thrownError){ },
        success: function(data){
            Sexy.vdata(data);
        }
    });

}
function showPoll(){
    nc++;
    var surl = '/ajax/poll.html?optionID=&pollID=' + $("#pollID").val();
    $.ajax({
        type: 'GET',
        cache: false,
        url: surl,
        timeout: 30000,
        error: function(xhr, ajaxOptions, thrownError){ },
        success: function(data){
            Sexy.vdata(data);
        }
    });

}
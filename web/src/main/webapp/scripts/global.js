function popup_fancy_box_ajax(ajax_url, on_closed_callback, width, height) {
    $.fancybox(
        ajax_url
        , {
            width: width,
            height: height,
            'padding'     : 10,
            'margin'          : -20,
            'transitionIn' : 'elastic',
            'transitionOut' : 'elastic',
            'type'            : 'iframe',
            'changeFade'      : 0,
            'autoScale'       : true,
            'hideOnOverlayClick' : false,
            'showCloseButton' : true,
            'onClosed'        : on_closed_callback
        });
}

function triggerBtn(event, comp, target, isPol){
	if(event.keyCode == 13){
		appendZero(comp.id, isPol);
    	document.getElementById(target).click();
    }
}

function toggleMenu(obj) {
    var subMenu = $("#" + obj.id + "_sub");
    if (subMenu.hasClass('hidden')) {
        subMenu.removeClass('hidden');
    }else{
        subMenu.addClass('hidden');
    }
}

function addClass(objId, className) {
    if(!$("#" + objId).hasClass(className)){
        $("#" + objId).addClass(className);
    }
}

function toggleClass(objId, className) {
    if(!$("#" + objId).hasClass(className)){
        $("#" + objId).addClass(className);
    }else{
        $("#" + objId).removeClass(className);
    }
}
function swapClass(obj, newStyle) {
    obj.className = newStyle;
}

function checkAll(theForm) { // check all the checkboxes in the list
    for (var i=0;i<theForm.elements.length;i++) {
        var e = theForm.elements[i];
        var eName = e.name;
        if (eName != 'allbox' &&
            (e.type.indexOf("checkbox") == 0)) {
            e.checked = theForm.allbox.checked;
        }
    }
}
//check all the checkboxes in the list
function checkAll(formId, listName, thisStatus){
    var list = document.getElementById(formId).elements[listName];
    if(list != null){
        var listSize = list.length;
        if(listSize == undefined) {
            list.checked = thisStatus.checked ? true : false;
        } else {
            if(listSize > 0) { //Have one or more element
                for(i = 0; i < listSize; i++) {
                    if (!list[i].disabled) {
                        list[i].checked = thisStatus.checked ? true : false;
                    }
                }
            }
        }
    }

}
//check the all checkbox if there is only one checkbox which be checked
function checkAllIfOne(formId, listName, thisStatus, checkboxAll){
    var allCheck = document.getElementById(formId).elements[checkboxAll];
    if(!thisStatus.checked)	//uncheck one  checkbox
        allCheck.checked = false;
    else{	//check one  checkbox
        //var checkList = document.getElementsByName(listName);
        var checkList = document.getElementById(formId).elements[listName];
        var listSize = checkList.length;
        if(listSize == undefined) {
            if(checkList.checked) {
                allCheck.checked = true;
            }

        } else {
            if(listSize > 0){ //Have one or more elements
                for(i = 0;i < listSize; i++)
                    if(!checkList[i].checked)
                        return false;
                allCheck.checked = true;
            }
        }

    }
}

function checkSelected4ConfirmDelete(formId, checkList) {
    var checkList = document.getElementById(formId).elements[checkList];
    var listSize = undefined;
    if(checkList != null)
        listSize = checkList.length;
    var fb = false;
    if(listSize == undefined && checkList != null) {
        if(checkList.checked) {
            return true;
        }
    }
    else {
        for(i=0; i < listSize; i++) {
            if(checkList[i].checked) {
                return true;
            }
        }
    }
    return false;
}

function highlightTableRows(tableId) {
    var previousClass = null;
    var table = document.getElementById(tableId);
    if(table != null){
    	var startRow = 0;
        // workaround for Tapestry not using thead
        if (!table.getElementsByTagName("thead")[0]) {
            startRow = 1;
        }
        var tbody = table.getElementsByTagName("tbody")[0];
        var rows = tbody.getElementsByTagName("tr");
        // add event handlers so rows light up and are clickable
        for (i=startRow; i < rows.length; i++) {
            rows[i].onmouseover = function() { previousClass=this.className;this.className+=' over' };
            rows[i].onmouseout = function() { this.className=previousClass };
        }
    }
}

validateForm = function(elements) {
	for(var i = 0; i < elements.length; i++) {
		var ele = elements[i];
		if (document.getElementById(ele[0]) != null) {
			var value = document.getElementById(ele[0]).value;
			var isvalid = true;
			if (ele[1] == 'text') {
				if (value == '' || value == ele[3]) {
					isvalid = false;
				}
			}else if (ele[1] == 'email') {
//				if (!isValidEmail(value)) {
//					isvalid = false;
//				}
			}else if (ele[1] == 'number') {
//				if (!isValidNumber(value)) {
//					isvalid = false;
//				}
			}
			if (!isvalid) {
				document.getElementById(ele[0]).focus();
//				jAlert(ele[2], "Thông báo");
				return false;
			}
		}
	}
	return true;

}

function OnUploadCompleted( errorNumber, fileUrl, fileName, customMsg )
{
	switch ( errorNumber )
	{
		case 0 :	// No errors
			alert( 'Your file has been successfully uploaded' ) ;
			break ;
		case 1 :	// Custom error
			alert( customMsg ) ;
			return ;
		case 101 :	// Custom warning
			alert( customMsg ) ;
			break ;
		case 201 :
			alert( 'A file with the same name is already available. The uploaded file has been renamed to "' + fileName + '"' ) ;
			break ;
		case 202 :
			alert( 'Invalid file type' ) ;
			return ;
		case 203 :
			alert( "Security error. You probably don't have enough permissions to upload. Please check your server." ) ;
			return ;
		case 500 :
			alert( 'The connector is disabled' ) ;
			break ;
		default :
			alert( 'Error on file upload. Error number: ' + errorNumber ) ;
			return ;
	}

}

jQuery(document).ready(function(){
    try{
        jQuery(".datepicker" ).datepicker({ dateFormat: 'dd/mm/yy' });
        $('a[name="hidenWarningLink"]').click(function(eventObj) {
            jAlert('Vui lòng chọn ít nhất một phần tử', 'Thông báo');
        });
        $(".myCorner").corner();
    }catch(err){}
});


shareFacebook = function() {
    window.open('http://www.facebook.com/sharer.php?u=' + encodeURIComponent(document.location.href) + '&t=' + encodeURIComponent(document.title));
}

shareGoogle = function() {
    window.open('https://plus.google.com/share?url=' + encodeURIComponent(document.location.href));
}

shareTwitter = function() {
    window.open('https://twitter.com/share');
}

function launchExternalSite(url) {
    if (url != '') {
        window.open(url);
    }
}

function toggleGroup(className) {
    $('.td_' + className).each(function() {
        if ($(this).hasClass('hidden')) {
            $(this).removeClass('hidden');
        }else{
            $(this).addClass('hidden');
        }
    });
}


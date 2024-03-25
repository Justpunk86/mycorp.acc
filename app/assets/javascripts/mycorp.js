

var chk_leaving_date;
var int_leaving_date;

window.onload = function() {
	
}



int_leaving_date = document.getElementById("employee_leaving_date");
chk_leaving_date = document.getElementById("chk_ld");

function change_input() {
	if (chk_leaving_date.checked == true) {
	
		int_leaving_date.disabled = false;
	}
	else {
		int_leaving_date.value = null;
		int_leaving_date.disabled = true;
		
	}
}

chk_leaving_date.addEventListener("click",change_input);





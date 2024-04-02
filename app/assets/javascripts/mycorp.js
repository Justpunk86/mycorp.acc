

var chk_leaving_date;
var int_leaving_date;

window.onload = function() {
	
}



y_leaving_date = document.getElementById("employee_leaving_date_1i");
m_leaving_date = document.getElementById("employee_leaving_date_2i");
d_leaving_date = document.getElementById("employee_leaving_date_3i");
chk_leaving_date = document.getElementById("chk_ld");

function change_input() {
	if (chk_leaving_date.checked == true) {
	
		y_leaving_date.disabled = false;
		m_leaving_date.disabled = false;
		d_leaving_date.disabled = false;
	}
	else {
		
		y_leaving_date.value = null;
		m_leaving_date.value = null;
		d_leaving_date.value = null;
		
		y_leaving_date.disabled = true;
		m_leaving_date.disabled = true;
		d_leaving_date.disabled = true;
		
	}
}

chk_leaving_date.addEventListener("click",change_input);





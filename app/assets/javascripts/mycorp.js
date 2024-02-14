
var form_new_emp;
var input_id;
var elem;

window.onload = function() {
	
}

form_new_emp = document.getElementById("form_new_emp");
input_id = document.getElementById("employee_last_name");
elem = document.getElementById("attr_last_name");

function change_color() {
	
	 // let p = document.createElement('p');
	 // p.innerHTML = "error";
	 // document.body.append(p);
	
	 if (input_id.value == "")
	{
		
	}

}

form_new_emp.addEventListener("submit",change_color);

 
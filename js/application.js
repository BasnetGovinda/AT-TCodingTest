$(document).ready(function() {
//	console.log("dadasda");
	$("#datepicker").datepicker();
	$('#timepicker').timepicker({});
	$("#fomrdiv").hide();
	var monthShortNames = ["Jan", "Feb", "Mar", "Apr", "May", "Jun",
  "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
];

	var showNewForm = showNewForm;
	var cancelForm=cancelForm;
	var getAllAppointment=getAllAppointment;
	$("#idnewform").click(showNewForm);
	$("#btnSearch").click(getAllAppointment);
	$("#btncancel").click(cancelForm);

	function showNewForm() {
		$("#idnewform").hide();
		$("#fomrdiv").show();

	}
	function cancelForm()
	{
		$("#fomrdiv").hide();
		$("#idnewform").show();
	}
	function getAllAppointment()
	{
		var search=$("#txtSearch").val();
	//	console.log(search);

		$.ajax({
                            type: 'GET',
                            url: 'http://localhost/Appointment-App/perlScript/getAllAppointment.pl',
                            data: { 'param': search },
                            success: function(res) {
                            
                       
                            		$("#tblbody").empty();
                            		if(res.length>0)
                            		{
                            	for (var i=0;i<res.length;i++)
                            	{
                            		var mydata=res[i].Datetime;
                            		
                            		var datetime=mydata.split('=');

                            		var data=new Date(datetime[0]);
                            		var compileddata=monthShortNames[data.getMonth()]+" "+data.getDate() ;
                            		console.log(compileddata);
                            		$("#tbldetail > tbody").append("<tr><td>"+compileddata+"</td><td>"+datetime[1]+"</td><td>"+res[i].Description+"</td></tr>");


                            	}

                                                       }
                                                    },
                            error: function() {alert("did not work");}
                    });



	}
});
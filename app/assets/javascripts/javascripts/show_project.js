/**
 * @author Rajesh
 */

$(document).ready(function(){
	$(".tag").click(function(){
		if($("#tags").val()=""){
			$("#tags").val($(this).val());
		}else{
			$("#tags").val($("#tags").val()+"#"+$(this).val());	
		}
	});	
});


function unfollowProject(){
	
	$("#showProjectForm").attr("action","/unfollowProject");
	$("#showProjectForm").submit();
}

function followProject(){
	$("#showProjectForm").attr("action","/followProject");
	$("#showProjectForm").submit();
}

function editProject(){
	$("#showProjectForm").attr("action","/editProject");
	$("#showProjectForm").submit();
}


function collabWithProject(){
	$("#showProjectForm").attr("action","/collabProject");
	$("#showProjectForm").submit();
}

function deCollabProject(){
	$("#showProjectForm").attr("action","/deCollabProject");
	$("#showProjectForm").submit();
}



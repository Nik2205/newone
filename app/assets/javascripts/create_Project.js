/**
 * @author Rajesh
 */

function home(){
	document.forms[0].action.value="/user";
	document.forms[0].method.value="get";
	document.forms[0].submit();
}


function addAnotherImage(){
	$("#otherImages").append('<input type="file" name="relatedImages[]" /><br>');
}

function deleteRelatedImage(project_image_id){
	$.ajax({
		url: "/deleteRelatedImage",
		data: {project_image_id : project_image_id},
		method: 'post',
		success :function(result){
			if(result == "success"){
			$("#relatedImage"+project_image_id).remove();
			}
			
		} 
	});
}


function updateProject(){
	$("#createProjectForm").attr("action","/updateProject");
	$("#createProjectForm").submit();
}

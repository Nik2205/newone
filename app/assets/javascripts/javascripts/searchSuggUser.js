/**
 * @author Rajesh
 */

$(document).ready(function(){

	$("#messageDivOpener").click(function(){
		$("#messageDiv").show();
	});
});


function addComment(obj){
	$("#pipe_comment").val($("#"+obj+"Comment").val());
	$("#pipe_id").val(obj);
	
	$("#searchSuggUserFrom").attr("action","/addCommentOnDifferentUser");
	//alert($("#searchSuggUserFrom").attr("action"));
	$("#searchSuggUserFrom").submit();
}



function deleteComment(pipeCommentId)
{
	$("#pipe_comment_id").val(pipeCommentId);
	$("#searchSuggUserFrom").attr("action","/deleteCommentOnDifferentUser");
	$("#searchSuggUserFrom").submit();
}

function unfollowUser(){
	$("#searchSuggUserFrom").attr("action","/unfollowUser");
	$("#searchSuggUserFrom").submit();
}

function followUser(){
	$("#searchSuggUserFrom").attr("action","/followUser");
	$("#searchSuggUserFrom").submit();
}

function sendMessage(){
	$("#searchSuggUserFrom").attr("action","/sendMessage");
	$("#searchSuggUserFrom").submit();
}

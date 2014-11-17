/**
 * @author Rajesh
 */


function editCommentProject(pipeCommentId){
	$("#"+pipeCommentId+"CommentExistingProject").html("<textarea rows='1' cols='35' id='"+pipeCommentId+"CommentContentTextProject'>"+$.trim($("#"+pipeCommentId+"CommentExistingProject").html())+"</textarea>");
	$("#"+pipeCommentId+"CommentUpdateButtonProject").children().eq(0).replaceWith("<a href='javascript:updateCommentProject("+pipeCommentId+")'>Update</a>");
	
}

function updateCommentProject(pipeCommentId){
	// $("#pipe_comment").val($.trim($("#"+pipeCommentId+"CommentContentText").val()));
	// //alert($("#pipe_comment").val());
	// $("#pipe_comment_id").val(pipeCommentId);
	// $("#showProjectForm").attr("action","/updateProjectPipeComment");
	// $("#showProjectForm").submit();
	
	$.ajax({
		url: "/updateProjectPipeComment",
		method: 'post',
		data: {	
				pipe_comment : $.trim($("#"+pipeCommentId+"CommentContentTextProject").val()),
				pipe_comment_id : pipeCommentId
			  },
		dataType: 'json',
		success :function(result){
			$("#"+pipeCommentId+"CommentExistingProject").html(result.comment);
			
			$("#"+pipeCommentId+"CommentUpdateButtonProject").children().eq(0).replaceWith('<a href="javascript:editCommentProject('+pipeCommentId+')">edit</a>');
			
		} 
	});
	
	
}


function deleteCommentProject(pipeCommentId)
{
	// $("#pipe_comment_id").val(pipeCommentId);
	// $("#showProjectForm").attr("action","/deleteProjectPipeComment");
	// $("#showProjectForm").submit();
	
	$.ajax({
		url: "/deleteProjectPipeComment",
		method: 'post',
		data: {	
				pipe_comment_id : pipeCommentId
			  },
		dataType: 'json',
		success :function(result){
			$("#pipeCommentDivProject"+pipeCommentId).remove();
		} 
	});
	
}

function likePipeProject(pipeId){
	//alert("check ajax like");
	$.ajax({
		url: "/likeProjectPipe",
		method: 'post',
		data: {pipeId : pipeId},
		dataType: 'html',
		success :function(result){
			//alert(result);
			$("#"+pipeId+"PipeLikesProject").html(result);
			$("#PreloadedPipeLikeLinkProject"+pipeId).hide();
			$("#AfterloadPipeLikeLinkProject"+pipeId).hide();
			$("#AfterloadPipeUnLikeLinkProject"+pipeId).show();
		} 
	});
	
}

function unLikePipeProject(pipeId){
	//alert("check ajax like");
	$.ajax({
		url: "/unLikeProjectPipe",
		method: 'post',
		data: {pipeId : pipeId},
		dataType: 'html',
		success :function(result){
			//alert(result);
			$("#"+pipeId+"PipeLikesProject").html(result);
			$("#PreloadedPipeUnLikeLinkProject"+pipeId).hide();
			$("#AfterloadPipeUnLikeLinkProject"+pipeId).hide();
			$("#AfterloadPipeLikeLinkProject"+pipeId).show();
		} 
	});
	
}

function addCommentProject(obj){
	// $("#pipe_comment").val($("#"+obj+"Comment").val());
	// $("#pipe_id").val(obj);
	// $("#showProjectForm").attr("action","/addProjectPipeComment");
	// $("#showProjectForm").submit();
// 	
	$.ajax({
		url: "/addProjectPipeComment",
		method: 'post',
		data: {	
				pipe_comment : $("#"+obj+"CommentProject").val(),
				pipe_id : obj
			  },
		dataType: 'json',
		success :function(result){
			//alert(result.pipe_id);
			
			htmlString ='<div id="pipeCommentDivProject'+result.project_pipe_comment_id+'">';
			htmlString = htmlString+'&nbsp;&nbsp;&nbsp;&nbsp;Comment :<span id="'+result.project_pipe_comment_id+'CommentExistingProject">'+result.comment+'</span>';
			htmlString = htmlString+'<span id="'+result.project_pipe_comment_id+'CommentUpdateButtonProject"><a href="javascript:editCommentProject('+result.project_pipe_comment_id+')">edit</a>&nbsp;<a href="javascript:deleteCommentProject('+result.project_pipe_comment_id+')">Delete</a></span>';
			htmlString = htmlString+'&nbsp;<a href="javascript:likePipeCommentProject('+result.project_pipe_comment_id+')" id="PreloadedPipeCommentLikeLinkProject'+result.project_pipe_comment_id+'">like</a>';
			htmlString = htmlString+'<a href="javascript:likePipeCommentProject('+result.project_pipe_comment_id+')" id="AfterloadPipeCommentLikeLinkProject'+result.project_pipe_comment_id+'" style="display:none">like</a>';
			htmlString = htmlString+'<a href="javascript:unLikePipeCommentProject('+result.project_pipe_comment_id+')" id="AfterloadPipeCommentUnLikeLinkProject'+result.project_pipe_comment_id+'" style="display:none">unlike</a>';			
			htmlString = htmlString+'&nbsp; No. of likes on Comments ';
			htmlString = htmlString+'<span id="'+result.project_pipe_comment_id+'PipeCommentLikesProject">'+result.noOfLikes+'</span><br>';
			htmlString = htmlString+'</div>';
			
			$("#addedPipeCommentsProject"+obj).append(htmlString);
			$("#"+obj+"commentProject").val('');
		} 
	});
	
}

function likePipeCommentProject(pipeCommentId){
	//alert("check ajax like");
	$.ajax({
		url: "/likeProjectPipeComment",
		method: 'post',
		data: {pipeCommentId : pipeCommentId},
		dataType: 'html',
		success :function(result){
			//alert(result);
			$("#"+pipeCommentId+"PipeCommentLikesProject").html(result);
			$("#PreloadedPipeCommentLikeLinkProject"+pipeCommentId).hide();
			$("#AfterloadPipeCommentLikeLinkProject"+pipeCommentId).hide();
			$("#AfterloadPipeCommentUnLikeLinkProject"+pipeCommentId).show();
		} 
	});
	
}

function unLikePipeCommentProject(pipeCommentId){
	//alert("check ajax like");
	$.ajax({
		url: "/unLikeProjectPipeComment",
		method: 'post',
		data: {pipeCommentId : pipeCommentId},
		dataType: 'html',
		success :function(result){
			//alert(result);
			$("#"+pipeCommentId+"PipeCommentLikesProject").html(result);
			$("#PreloadedPipeCommentUnLikeLinkProject"+pipeCommentId).hide();
			$("#AfterloadPipeCommentUnLikeLinkProject"+pipeCommentId).hide();
			$("#AfterloadPipeCommentLikeLinkProject"+pipeCommentId).show();
		} 
	});
	
}

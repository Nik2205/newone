/**
 * @author Rajesh
 */



function addPipe(){
	
	// $("#showProjectForm").attr("action","/addProjectPipe");
	// $("#showProjectForm").submit();
// 	
	$.ajax({
		url: "/addProjectPipe",
		method: 'post',
		data: {	
				projectId : $("#projectId").val(),
				pipeContent : $.trim($("#pipeContent").val())
			},
		dataType: 'json',
		success :function(result){
			htmlString ='<div id="myPipe'+result.project_pipe_id+'">';
			htmlString = htmlString+'<span style="color:red" id="'+result.project_pipe_id+'Content">'+result.content+'&nbsp;&nbsp;</span>';
			htmlString = htmlString+'<span id="'+result.project_pipe_id+'PipeUpdateButton"><a href="javascript:editPipe('+result.project_pipe_id+')">edit</a></span>&nbsp;';
			htmlString = htmlString+'<span id="'+result.project_pipe_id+'PipeDeleteButton"><a href="javascript:deletePipe('+result.project_pipe_id+')">delete</a></span>&nbsp;';
			htmlString = htmlString+'<a href="javascript:likePipe('+result.project_pipe_id+')" id="PreloadedPipeLikeLink'+result.project_pipe_id+'">like</a>';
			htmlString = htmlString+'<a href="javascript:likePipe('+result.project_pipe_id+')" id="AfterloadPipeLikeLink'+result.project_pipe_id+'" style="display:none">like</a>';
			htmlString = htmlString+'<a href="javascript:unLikePipe('+result.project_pipe_id+')" id="AfterloadPipeUnLikeLink'+result.project_pipe_id+'" style="display:none">unlike</a>';
			htmlString = htmlString+'&nbsp; No. of likes on Pipe<span id="'+result.project_pipe_id+'PipeLikes">0</span><br>';
			htmlString = htmlString+'<div id="addedPipeComments'+result.project_pipe_id+'"></div>';
			htmlString = htmlString+'<br><textarea rows="1" cols="35" id="'+result.project_pipe_id+'Comment" ></textarea><a href="javascript:addComment('+result.project_pipe_id+')">Add</a><br>';
			htmlString = htmlString+'</div>';
			$("#MyPipesAll").prepend(htmlString);
		} 
	});

	
}


function editPipe(pipeId)
{
	$("#"+pipeId+"Content").html("<textarea rows='3' cols='50' id='"+pipeId+"ContentText'>"+$.trim($("#"+pipeId+"Content").html())+"</textarea>");
	$("#"+pipeId+"PipeUpdateButton").html("<a href='javascript:updatePipe("+pipeId+")'>Update</a>");
}

function deletePipe(pipeId)
{
	// $("#pipe_id").val(pipeId);
	// $("#showProjectForm").attr("action","/deleteProjectPipe");
	// $("#showProjectForm").submit();
// 	
	$.ajax({
		url: "/deleteProjectPipe",
		method: 'post',
		data: {	
				pipe_id : pipeId
			  },
		dataType: 'json',
		success :function(result){
			$("#myPipe"+pipeId).remove();
		} 
	});

	
}



function updatePipe(pipeId){
	// $("#hdn_pipe_content").val($.trim($("#"+pipeId+"ContentText").val()));
	// $("#pipe_id").val(pipeId);
	// $("#showProjectForm").attr("action","/updateProjectPipe");
	// $("#showProjectForm").submit();
// 	
	$.ajax({
		url: "/updateProjectPipe",
		method: 'post',
		data: {	
				hdn_pipe_content : $.trim($("#"+pipeId+"ContentText").val()),
				pipe_id : pipeId
			  },
		dataType: 'json',
		success :function(result){
			$("#"+pipeId+"Content").html(result.content);
			$("#"+pipeId+"PipeUpdateButton").html('<a href="javascript:editPipe('+pipeId+')">edit</a>');
		} 
	});
	
}


function editComment(pipeCommentId){
	//alert(pipeCommentId);
	$("#"+pipeCommentId+"CommentExisting").html("<textarea rows='1' cols='35' id='"+pipeCommentId+"CommentContentText'>"+$.trim($("#"+pipeCommentId+"CommentExisting").html())+"</textarea>");
	//$("#"+pipeCommentId+"CommentUpdateButton").html("<a href='javascript:updateComment("+pipeCommentId+")'>Update</a>");
	
	$("#"+pipeCommentId+"CommentUpdateButton").children().eq(0).replaceWith("<a href='javascript:updateComment("+pipeCommentId+")'>Update</a>");
	
}

function updateComment(pipeCommentId){
	// $("#pipe_comment").val($.trim($("#"+pipeCommentId+"CommentContentText").val()));
	// //alert($("#pipe_comment").val());
	// $("#pipe_comment_id").val(pipeCommentId);
	// $("#showProjectForm").attr("action","/updateProjectPipeComment");
	// $("#showProjectForm").submit();
	
	$.ajax({
		url: "/updateProjectPipeComment",
		method: 'post',
		data: {	
				pipe_comment : $.trim($("#"+pipeCommentId+"CommentContentText").val()),
				pipe_comment_id : pipeCommentId
			  },
		dataType: 'json',
		success :function(result){
			$("#"+pipeCommentId+"CommentExisting").html(result.comment);
			
			$("#"+pipeCommentId+"CommentUpdateButton").children().eq(0).replaceWith('<a href="javascript:editComment('+pipeCommentId+')">edit</a>');
			
		} 
	});
	
	
}


function deleteComment(pipeCommentId)
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
			$("#pipeCommentDiv"+pipeCommentId).remove();
		} 
	});
	
}

function likePipe(pipeId){
	//alert("check ajax like");
	$.ajax({
		url: "/likeProjectPipe",
		method: 'post',
		data: {pipeId : pipeId},
		dataType: 'html',
		success :function(result){
			//alert(result);
			$("#"+pipeId+"PipeLikes").html(result);
			$("#PreloadedPipeLikeLink"+pipeId).hide();
			$("#AfterloadPipeLikeLink"+pipeId).hide();
			$("#AfterloadPipeUnLikeLink"+pipeId).show();
		} 
	});
	
}

function unLikePipe(pipeId){
	//alert("check ajax like");
	$.ajax({
		url: "/unLikeProjectPipe",
		method: 'post',
		data: {pipeId : pipeId},
		dataType: 'html',
		success :function(result){
			//alert(result);
			$("#"+pipeId+"PipeLikes").html(result);
			$("#PreloadedPipeUnLikeLink"+pipeId).hide();
			$("#AfterloadPipeUnLikeLink"+pipeId).hide();
			$("#AfterloadPipeLikeLink"+pipeId).show();
		} 
	});
	
}

function addComment(obj){
	// $("#pipe_comment").val($("#"+obj+"Comment").val());
	// $("#pipe_id").val(obj);
	// $("#showProjectForm").attr("action","/addProjectPipeComment");
	// $("#showProjectForm").submit();
// 	
	$.ajax({
		url: "/addProjectPipeComment",
		method: 'post',
		data: {	
				pipe_comment : $("#"+obj+"Comment").val(),
				pipe_id : obj
			  },
		dataType: 'json',
		success :function(result){
			//alert(result.pipe_id);
			
			htmlString ='<div id="pipeCommentDiv'+result.project_pipe_comment_id+'">';
			htmlString = htmlString+'&nbsp;&nbsp;&nbsp;&nbsp;Comment :<span id="'+result.project_pipe_comment_id+'CommentExisting">'+result.comment+'</span>';
			htmlString = htmlString+'<span id="'+result.project_pipe_comment_id+'CommentUpdateButton"><a href="javascript:editComment('+result.project_pipe_comment_id+')">edit</a>&nbsp;<a href="javascript:deleteComment('+result.project_pipe_comment_id+')">Delete</a></span>';
			htmlString = htmlString+'&nbsp;<a href="javascript:likePipeComment('+result.project_pipe_comment_id+')" id="PreloadedPipeCommentLikeLink'+result.project_pipe_comment_id+'">like</a>';
			htmlString = htmlString+'<a href="javascript:likePipeComment('+result.project_pipe_comment_id+')" id="AfterloadPipeCommentLikeLink'+result.project_pipe_comment_id+'" style="display:none">like</a>';
			htmlString = htmlString+'<a href="javascript:unLikePipeComment('+result.project_pipe_comment_id+')" id="AfterloadPipeCommentUnLikeLink'+result.project_pipe_comment_id+'" style="display:none">unlike</a>';			
			htmlString = htmlString+'&nbsp; No. of likes on Comments ';
			htmlString = htmlString+'<span id="'+result.project_pipe_comment_id+'PipeCommentLikes">'+result.noOfLikes+'</span><br>';
			htmlString = htmlString+'</div>';
			
			$("#addedPipeComments"+obj).append(htmlString);
			$("#"+obj+"comment").val('');
		} 
	});
	
}

function likePipeComment(pipeCommentId){
	//alert("check ajax like");
	$.ajax({
		url: "/likeProjectPipeComment",
		method: 'post',
		data: {pipeCommentId : pipeCommentId},
		dataType: 'html',
		success :function(result){
			//alert(result);
			$("#"+pipeCommentId+"PipeCommentLikes").html(result);
			$("#PreloadedPipeCommentLikeLink"+pipeCommentId).hide();
			$("#AfterloadPipeCommentLikeLink"+pipeCommentId).hide();
			$("#AfterloadPipeCommentUnLikeLink"+pipeCommentId).show();
		} 
	});
	
}

function unLikePipeComment(pipeCommentId){
	//alert("check ajax like");
	$.ajax({
		url: "/unLikeProjectPipeComment",
		method: 'post',
		data: {pipeCommentId : pipeCommentId},
		dataType: 'html',
		success :function(result){
			//alert(result);
			$("#"+pipeCommentId+"PipeCommentLikes").html(result);
			$("#PreloadedPipeCommentUnLikeLink"+pipeCommentId).hide();
			$("#AfterloadPipeCommentUnLikeLink"+pipeCommentId).hide();
			$("#AfterloadPipeCommentLikeLink"+pipeCommentId).show();
		} 
	});
	
}


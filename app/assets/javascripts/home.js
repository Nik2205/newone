/**
 * @author Rajesh
 */

$(document).ready(function(){
	$(".tag").click(function(){
		//alert($(this).val());
		if($("#tags").val()=""){
			$("#tags").val($(this).val());
		}else{
			$("#tags").val($("#tags").val()+"#"+$(this).val());	
		}
	});
	
	
	// (function poll(){
// 		
   // setTimeout(function(){
//    	
      // $.ajax({ 
      	// url: "/checkNotifications",
      	// type: 'get',
      	// data : {timestamp : Date.now}, 
      	// success: function(data){
      		// if(data != 0){
//       			
	      		// if($.trim($("#notificationLink").html()) != data)
	      			// {
	      				// $("#notificationLink").show();
	      				// $("#notificationLink").attr("href","javascript:showNotifications()");
	      				// $("#notificationLink").html(data);
// 	      				
	      			// }
// 	     	   
	     	 // }else{
	     	 	// $("#notificationLink").empty();
	     	 	// $("#notificationLink").hide();
	     	 // }
	     	 // poll();
      // }, dataType: "json"});
  // }, 10000);
// })();

});



function showNotifications(){
	$.ajax({
		url: "/showNotifications",
		method: 'post',
		data: {},
		dataType: 'html',
		success :function(result){
			$("#notificationLink").empty();
			$("#notificationLink").hide();
			$("#notificationArea").html(result);
		} 
	});
}

function notificationAction(notification_id,notificationType , affectedId){
	$("#notification_id").val(notification_id);
	if(notificationType ==1 || notificationType ==2 || notificationType ==3)
		$("#homeForm").attr("action","showPipe/"+affectedId);
	else if (notificationType ==4 || notificationType ==5 || notificationType ==6)
		$("#homeForm").attr("action","showProjectPipe/"+affectedId);
	else if (notificationType ==7 || notificationType ==8 || notificationType ==9)
		$("#homeForm").attr("action","/show_project_notification/"+affectedId);	
	$("#homeForm").submit();	
}

function notificationFollowerAction(){
	$("#homeForm").attr("action","followerNotification");
	$("#homeForm").submit();
}

function notificationProjectFollowerAction(project_id){
	$("#homeForm").attr("action","/projectFollowerNotification/"+project_id);
	$("#homeForm").submit();
}

function findFriend(){
	
	$("#homeForm").attr("action","findFriend");
	$("#homeForm").submit();
}


function showUser(user_id){
	$("#homeForm").attr("action","showUser/"+user_id);
	$("#homeForm").submit();
}

function pipeSuggester(){
	
	$.ajax({
		url: "/pipesuggestor",
		method: 'post',
		dataType: 'html',
		success :function(result){
			
			$("#SuggestedPipeDiv").html(result);
			
		} 
	});
	
}


function createProject(){
	$("#homeForm").attr("action","createProject");
	$("#homeForm").submit();	
}

function showNotificationDiv(){
	$("#notifications").show();
}

function approveCollab(project_collaborator_id){
	$.ajax({
		url: "/approveCollab",
		method: 'post',
		data: {project_collaborator_id : project_collaborator_id},
		dataType: 'html',
		success :function(result){
			$("#CollabRequest"+project_collaborator_id).remove();
		} 
	});
}

function rejectCollab(project_collaborator_id){
	$.ajax({
		url: "/rejectCollab",
		method: 'post',
		data: {project_collaborator_id : project_collaborator_id},
		dataType: 'html',
		success :function(result){
			$("#CollabRequest"+project_collaborator_id).remove();
		} 
	});
}

function approveDeCollab(project_collaborator_id){
	$.ajax({
		url: "/approveDeCollab",
		method: 'post',
		data: {project_collaborator_id : project_collaborator_id},
		dataType: 'html',
		success :function(result){
			$("#DeCollabRequest"+project_collaborator_id).remove();
		} 
	});
}

function rejectDeCollab(project_collaborator_id){
	$.ajax({
		url: "/rejectDeCollab",
		method: 'post',
		data: {project_collaborator_id : project_collaborator_id},
		dataType: 'html',
		success :function(result){
			$("#DeCollabRequest"+project_collaborator_id).remove();
		} 
	});
}


function openHelpTab() {
	$("#homeForm").attr("action","helpTab");
	$("#homeForm").submit();  
}

function showProject(projectId){
	$("#homeForm").attr("action","/show_project/"+projectId);
	$("#homeForm").submit();  
}


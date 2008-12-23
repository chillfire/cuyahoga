﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Manager/Views/Shared/Admin.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="Cuyahoga.Web.Manager.Views.Pages.Index" %>
<%@ Import Namespace="Cuyahoga.Core.Domain"%>
<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
	<link rel="stylesheet" type="text/css" href="<%= Url.Content("~/Manager/Content/Css/Pagegrid.css") %>" />
	<script type="text/javascript" src="<%= Url.Content("~/manager/Scripts/ui.core.js") %>"></script>
	<script type="text/javascript" src="<%= Url.Content("~/manager/Scripts/ui.sortable.js") %>"></script>
	<script type="text/javascript" src="<%= Url.Content("~/manager/Scripts/ui.droppable.js") %>"></script>
	<script type="text/javascript" src="<%= Url.Content("~/manager/Scripts/jquery.scrollfollow.js") %>"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphTasks" runat="server">
	<div id="selectedpage">
	<% if (ViewData["ActiveNode"] != null) {
		Node activeNode = (Node) ViewData["ActiveNode"];
		if (activeNode.IsExternalLink)
		{
			Html.RenderPartial("SelectedLink", activeNode, ViewData);
		}
		else
		{
			Html.RenderPartial("SelectedPage", activeNode, ViewData);
		}
	} %>
	</div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphMain" runat="server">
	<div id="pagegrid">
		<div id="pagegrid-head">
			<div class="fr" style="width:120px">Last modified</div>
			<div class="fr" style="width:80px">Culture</div>
			<div class="fr" style="width:120px">Template</div>
			<div class="fr" style="width:160px">Page url</div>
			<div>Page title</div>
		</div>
		<div id="pagegrid-body">
			<% Html.RenderPartial("PageListItems", ViewData.Model, ViewData); %>
		</div>
	</div>
	<script type="text/javascript"> 
		var selectedPageDiv;
		
		$(document).ready(function() {
			
			$('#taskarea').scrollFollow({
				container : 'contentarea'
			});
			
			$('#pagegrid').click($.delegate({
				'.children-visible' : function(e) { 
					toggleHide(e.target); 
				},
				'.children-hidden' : function(e) { 
					toggleShow(e.target);
				},
				'.pagerow div' : function(e) {
					selectPage(e.target);
				},
				'span' : function(e) {
					selectPage(e.target);
				}
			}))
			
			addDroppable('.page');
			addSortable('.pagegroup .pagegroup');
					
			selectedPageDiv = $('#pagegrid div.selected').parent();			
		})	
				
		function toggleHide(expander) {
			$(expander).attr('src', '<%= Url.Content("~/manager/Content/Images/expand.png") %>');
			$(expander).removeClass('children-visible').addClass('children-hidden');
			var nodeId = $(expander).parents('.pagerow').parent().attr('id').substring(5);
			hidePages(nodeId);
		}
		
		function toggleShow(expander) {
			$(expander).attr('src', '<%= Url.Content("~/manager/Content/Images/collapse.png") %>');
			$(expander).removeClass('children-hidden').addClass('children-visible');
			var nodeId = $(expander).parents('.pagerow').parent().attr('id').substring(5);
			showPages(nodeId);	
		}
		
		function hidePages(parentNodeId) {
			$('.parent-' + parentNodeId).hide().each(function(i) {
				hidePages($(this).attr('id').substring(5));
			});
		}
		
		function showPages(parentNodeId) {
			if ($('.parent-' + parentNodeId).length == 0) {
				$.get('<%= Url.Action("GetChildPageListItems", "Pages") %>', { 'nodeid' : parentNodeId }, function(data) {
					$('#page-' + parentNodeId).append(data);
					addSortable('#page-' + parentNodeId + ' .pagegroup');
					addDroppable('#page-' + parentNodeId + ' .page')
				})
			}
			else {
				$('.parent-' + parentNodeId).fadeIn();
				// only recurse pages that have their children visible
				$('.parent-' + parentNodeId + ':has(img.children-visible)').each(function(i) {
					showPages($(this).attr('id').substring(5));
				});
			}
		}
		
		function selectPage(pageCell) {
			$('#pagegrid .selected').removeClass('selected');
			
			selectedPageDiv = $(pageCell).parents('.pagerow').parent();
			var nodeId = selectedPageDiv.attr('id').substring(5);
			$('#selectedpage').load('<%= Url.Action("SelectPage", "Pages") %>', { 'nodeid' : nodeId });
			selectedPageDiv.find('.pagerow:first').addClass('selected');
		}
		
		function addSortable(container) {
			$(container).sortable({
				opacity : 0.5,
				placeholder : "pageplaceholder",
				delay : 50,
				distance : 30
			});
		}
		
		function addDroppable(elementToDrop) {
			$(elementToDrop).droppable({
				accept : "li",
				hoverClass : "droppablepage",
				tolerance : "pointer",
				drop : function(ev, ui) {
					var nodeIdToDropOn = $(this).parents('li').attr('id').substring(5);
					var nodeIdToDrop = $(ev.target).parents('li').attr('id').substring(5);
					alert('Adding node ' + nodeIdToDrop + ' to ' + nodeIdToDropOn);
				}
			});
		}
		
		
	</script>
</asp:Content>

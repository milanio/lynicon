﻿<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<%@ Import Namespace="Lynicon.Utility" %>
<%= Html.RegisterCss("/Lynicon/Embedded/Content/jquery.jstreelist.css/") %>
<%= Html.RegisterCss("/Lynicon/Embedded/Content/jquery.contextMenu.css/") %>
<%= Html.RegisterHtmlBlock("lyn_fileeditor",
@"<div id='_L24FileMgrContainer' style='display:none'>
    <div id='outer'>
        <div id='treeContainer' class='treeContainer ui-layout-west'></div>
        <div id='listContainer' class='listContainer ui-layout-center'></div>
    </div>
    <div id='filenameBox'>
        <input id='filename' class='filename' type='text' />
        <div id='fileDetails' class='fileDetails'></div>
    </div>
</div>
<script id='fileListTemplate' type='text/x-jquery-tmpl'>
    <table style='width:300px'>
    <tr><th></th><th>Name</th><th>Size</th></tr>
    {{each dirs}}<tr title='${dir}${name}/'><td class='dir jstree-default'><ins style='width:16px;height:16px;display:inline-block' class='ext ext_dir'/></td><td><span>${name}</span></td><td></td></tr>{{/each}}
    {{each files}}<tr title='${dir}${name}'><td><ins style='width:16px;height:16px;display:inline-block' class='ext ext_${ext}'/></td><td><span>${name}</span></td><td>${size}</td></tr>{{/each}}
    </table>
</script>") %>
<%= Html.RegisterScript("jstree", "/Lynicon/Embedded/Scripts/jquery.jstree.js/", new List<string> { "jquery" }) %>
<%= Html.RegisterScript("contextMenu", "/Lynicon/Embedded/Scripts/jquery.contextMenu.js/", new List<string> { "jquery" }) %>
<%= Html.RegisterScript("fileuploader", "/Lynicon/Embedded/Scripts/fileuploader.js/", new List<string> { "jquery" }) %>
<%= Html.RegisterScript("layout", "/Lynicon/Embedded/Scripts/jquery.layout.js/", new List<string> { "jquery" }) %>
<%= Html.RegisterScript("jstreelist", "/Lynicon/Embedded/Scripts/jquery.jstreelist.js/", new List<string> { "jstree", "contextMenu", "fileuploader" }) %>
<%= Html.RegisterScript("lyn_fileeditor_script",
@"javascript:$(document).ready(function() {
    $('#_L24FileMgrContainer').jstreelist({ rootPath: '" + (ViewBag.FileManagerRoot as string) + @"' });
});
function getFile(current, updateFile) {
    var $fm = $('#_L24FileMgrContainer').css('display', 'block');
    $fm.find('#outer').layout();
    $fm.css({ 'z-index': '1010', position: 'fixed' });
    $(""<div id='modalPlaceholder' style='background-color: White;'></div>"")
        .width($fm.width()).height($fm.height())
        .modal({
            overlayClose: true,
            onClose: function(dialog) {
                var msg = updateFile($('#filename').val());
                if (msg) {
                    alert(msg);
                    this.bindEvents();
                    this.occb = false;
                } else {
                    $('#_L24FileMgrContainer').css('display', 'none');
                    $.modal.getContainer().unbind('move.modal');
                    $.modal.close();
                }
            }
        });

    $('.simplemodal-close').css({
        'z-index': '1003', position: 'fixed', display: 'block',
        'background-image': 'url(/lynicon/embedded/Content/Images/close-white.png/)',
        width: '16px', height: '16px'
    });
    positionTool('#_L24FileMgrContainer');
    $.modal.getContainer().bind('move.modal', function() { positionTool('#_L24FileMgrContainer'); });
            
}", new List<string> { "jstreelist" })%>

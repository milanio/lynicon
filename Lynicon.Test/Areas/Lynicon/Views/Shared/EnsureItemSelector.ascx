﻿<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<%@ Import Namespace="Lynicon.Utility" %>
<% ViewData.Add("popup", true); %>
<% if (!Html.HtmlBlockIsRegistered("lyn_itemselector"))
       Html.RegisterHtmlBlock("lyn_itemselector", Html.Partial("LyniconItems", ViewData)); %>
<%= Html.RegisterScript("lyn_itemselector_script",
@"javascript:function getItem(current, updateItem) {
    var $sel = $('#lyn-item-selector').css('display', 'block');
    if (current)
        $sel.find('a[title=""' + current + '""]').addClass('item-selected');
    $sel.css({ 'z-index': '1010', position: 'fixed', width: '400px' });
    $sel.height($sel.height() + 200);
    $(""<div id='modalPlaceholder' style='background-color: White;'></div>"")
        .width($sel.width()).height($sel.height())
        .modal({
            overlayClose: true,
            onClose: function(dialog) {
                    var $sel = $('#lyn-item-selector a.item-selected');
                    updateItem({
                        id: $('#lyn-item-selected').val(),
                        title: $sel.text(),
                        datatype: $sel.closest('.lyn-type-items').prev('h2').find('input').val()
                    });
                    $('#lyn-item-selector').css('display', 'none');
                    $.modal.getContainer().unbind('move.modal');
                    $.modal.close();
                }
        });

    $('.simplemodal-close').css({
        'z-index': '1003', position: 'fixed', display: 'block',
        'background-image': 'url(/lynicon/embedded/Content/Images/close-white.png/)',
        width: '16px', height: '16px'
    });
    positionTool('#lyn-item-selector');
    $.modal.getContainer().bind('move.modal', function() { positionTool('#lyn-item-selector'); });
}
$(document).ready(function () {
    $('#lyn-item-selector').on('click', 'a.item-link', function (ev) {
        ev.preventDefault();
        $('#lyn-item-selected').val($(this).prop('title'));
        $('#lyn-item-selector a.item-selected').removeClass('item-selected');
        $(this).addClass('item-selected');
    });
});", new List<string> { "simplemodal-script" })%>

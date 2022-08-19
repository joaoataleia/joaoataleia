<%@ control language="C#" autoeventwireup="true" inherits="TstQuestionario, App_Web_tstquestionario.ascx.eb34a1f9" %>
<%@ Register Assembly="RM.Lib.WebForms" Namespace="RM.Lib.WebForms" TagPrefix="RMWF" %>

<table cellpadding="0" cellspacing="0" style="width: 95%" align="center">
    <tr>
        <td style="height: 20px" colspan="3">
        </td>
    </tr>
    <tr>
        <td colspan="3">
            <asp:PlaceHolder ID="phTestClientStruct" runat="server" 
              onprerender="phTestClientStruct_PreRender"></asp:PlaceHolder>
        </td>
    </tr>
    <tr style="padding-top: 10px; padding-bottom: 30px">
        <td align="right">
            &nbsp;
            <asp:PlaceHolder ID="phSaveButton" runat="server"></asp:PlaceHolder>
            <asp:PlaceHolder ID="phFinishButton" runat="server"></asp:PlaceHolder>
            <asp:PlaceHolder ID="phCancelButton" runat="server"></asp:PlaceHolder>
        </td>
    </tr>
</table>

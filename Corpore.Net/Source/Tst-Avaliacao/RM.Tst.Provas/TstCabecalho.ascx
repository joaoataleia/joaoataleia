<%@ control language="C#" autoeventwireup="true" inherits="TstCabecalho, App_Web_tstcabecalho.ascx.eb34a1f9" %>
<%@ Register Assembly="RM.Lib.WebForms" Namespace="RM.Lib.WebForms" TagPrefix="RMWF" %>

<table cellpadding="0" cellspacing="0" border="0" style="width: 95%">
  <tr>
    <td style="width: 2%">
      <img src="Images/TesteCenterMenu.GIF" />&nbsp;</td>
    <td style="width: 93%" valign="middle">
      <RMWF:RMWLabel ID="lblNome" runat="server" CssClass="Label"></RMWF:RMWLabel>&nbsp;&nbsp;
    </td>
    <td style="width: 98%" valign="middle">
      <img id="imgClock" alt="" height="22" src="Images/sp_animated_clock.gif"
        width="22" />
    </td>
    <td style="width: 5%" valign="middle">
      <input id="expireTime" size="2" style="font-size: 10px; width: 45px; border-top-style: none;
        font-family: Verdana, Arial; border-right-style: none; border-left-style: none;
        height: 14px; background-color: transparent; border-bottom-style: none" type="text" />
    </td>
  </tr>
  <tr>
    <td style="width: 2%">
      <img src="Images/Requisicao.gif" />
    </td>
    <td style="width: 98%" valign="middle" colspan=6>
      <RMWF:RMWLabel ID="lblProva" runat="server" CssClass="Label"></RMWF:RMWLabel></td>
  </tr>
</table>

<input type="hidden" id="hdNomeCandidato" runat="server"/>
<input type="hidden" id="hdAviso" runat="server"/>
<input type="hidden" id="hdRepeticaoAviso" runat="server"/>
<input type="hidden" id="hdTempoRestante" runat="server"/>
<input type="hidden" id="hdAvisoAux" runat="server"/>
<input type="hidden" id="hdRepeticaoAvisoAux" runat="server"/>
<input type="hidden" id="hdPeriodicidadeGravacaoAutomatica" runat="server"/>
<input type="hidden" id="posicaoScroll" runat="server"/>

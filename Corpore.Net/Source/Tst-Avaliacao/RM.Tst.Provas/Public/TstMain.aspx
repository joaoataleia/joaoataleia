<%@ page language="C#" autoeventwireup="true" inherits="TstMain, App_Web_tstmain.aspx.e95fadbb" %>

<%@ Register Src="~/Source/Tst-Avaliacao/RM.Tst.Provas/TstCabecalho.ascx" TagName="TstCabecalho"
  TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<script language="javascript">
  function acertaDiv()
  {
    if(window.name == '') return;
    
    var div = window.document.getElementById('divplaceHolder');
    try
    {
        div.style.height = document.documentElement.clientHeight - div.parentElement.offsetTop;
    }
    catch(e)
    {}
  }
</script>

<head runat="server">
  <title>Gestão de Conhecimento</title>
  <link href="Styles/TstGeneral.css" rel="stylesheet" type="text/css" />  
</head>
<body class="TstFundoTela" onload="acertaDiv();" scroll="auto">
  <form id="form1" runat="server">
    <table cellpadding="0" border="0" cellspacing="0" style="width: 100%" align="center"
      height="1px">
      <tr>
        <td colspan="3" height="1px">
          &nbsp;</td>
      </tr>
      <tr runat="server" id="trTitulo" visible="false">
        <td align="left" style="width: 23%;" valign="middle">
          <img src="Images/Barra-Superior-01.jpg" /></td>
        <td style="width: 100%;" valign="middle" align="right" background="Images/Barra-Superior-Fundo.jpg">
        </td>
      </tr>
      <tr runat="server" id="trDadosProva" height="1px">
        <td align="left" valign="middle" style="width: 100%" colspan="5">
          <div>
            <asp:PlaceHolder ID="phTitulo" runat="server"></asp:PlaceHolder>
          </div>
        </td>
      </tr>
      <tr>
        <td align="center" valign="top" style="width: 100%" colspan="5">
          <div align="left" style="overflow: auto; width: 90%" id="divplaceHolder">
            <asp:PlaceHolder ID="phConteudo" runat="server"></asp:PlaceHolder>
          </div>
        </td>
      </tr>
    </table>
  </form>
</body>
</html>

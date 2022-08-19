<%@ page language="C#" autoeventwireup="true" inherits="TstImagemQuestao, App_Web_tstimagemquestao.aspx.e95fadbb" meta:resourcekey="PageResource1" %>

<%@ Register assembly="RM.Lib.WebForms" namespace="RM.Lib.WebForms" tagprefix="RMWF" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

<script type="text/javascript" language="javascript">
    var questionName;
    var txtClientId;
    function GetTexto() {
        questionName = window.opener.questionName;
        txtClientId = window.opener.txtRetorno;        
        var ownerTxt = window.opener.document.getElementById(txtClientId);        
    }

    function fechar() {
        window.close();
    }
    
</script>

<head runat="server">
  <title>Figura</title>
  <link href="Styles/TstGeneral.css" type="text/css" rel="stylesheet" />
  <link href="/Corpore.net/sharedservices/styles/caption.css" type="text/css" rel="stylesheet" />
  <link href="/Corpore.net/sharedservices/styles/default.css" type="text/css" rel="stylesheet" />
</head>
<body onload="GetTexto();" class="TstFundoTela">
    <form id="form1" runat="server">
    &nbsp;&nbsp;&nbsp;
    <table style="width: 95%; height: 313px;" border="0" cellpadding="3" cellspacing="3">
      <tr>
        <td style="width: 100%" align="left" colspan="2">
          <span id="lblComentario" class="LabelPergunta">Questão</span> <span id="lblQuestao" class="LabelResposta">
            <script language="javascript" type="text/javascript">document.write(window.opener.questionName);</script>
          </span><br /><br />
        </td>
      </tr>
      <tr>
        <td style="width: 100%" align="center" colspan="2">
          
                        <RMWF:RMWFormView ID="fvImagem" runat="server" 
                            meta:resourcekey="RMWFormView1Resource1">
                            <ItemTemplate>
                                <RMWF:RMWDataImage ID="RMWDataImage1" runat="server" FieldName="IMAGEM"
                                Mode="RecordView" meta:resourcekey="RMWDataImage1Resource2" CssClass="DataImageRecordView"
                                    EnableViewState="False" ImageData='<%# Eval("IMAGEM") %>' />
                            </ItemTemplate>
                        </RMWF:RMWFormView>
          
        </td>
      </tr>
      <tr>        
        <td align="left" style="width: 50%; height: 36px;">
          <input id="btnCancelar" type="button" value="Cancelar" onclick="fechar();" class="TstBtn"/></td>
      </tr>
    </table>
    <!--<div style="left: 372px; width: 421px; position: absolute; top: 339px; height: 200px;
    background-color: #ffffcc; border-right: #000000 thin groove; border-top: #000000 thin groove;
    overflow: auto; border-left: #000000 thin groove; border-bottom: #000000 thin groove;
    clear: none;">-->
    </form>
</body>
</html>

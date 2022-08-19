<%@ page autoeventwireup="true" inherits="TstNewMain, App_Web_tstnewmain.aspx.e95fadbb" language="C#" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Gestão de Conhecimento</title>
    <link href="Styles/TstGeneral.css" rel="stylesheet" type="text/css" />
    <link href="../CSS/estilo.css" rel="stylesheet" type="text/css" />
</head>
<body class="TstFundoTela" onload="acertaDiv();" scroll="auto">
    <form id="form1" runat="server">
        <div class="header zindex999">
            <table class="tableHeader">
                <tr runat="server" id="trTitulo" visible="false">
                    <td>
                        <img src="Images/totvs_h_pos_grafite.png" alt="TOTVS" />
                    </td>
                    <td>
                        <div class="divAvaliacaoOnline">
                            <asp:Label ID="lblAvaliacaoOnline" runat="server" Text="Avaliação Online" CssClass="labelInstrucoes" />
                        </div>
                    </td>
                </tr>
            </table>
        </div>

        <table cellpadding="0" border="0" cellspacing="0" style="width: 100%" align="center" height="1px">
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
                       
                    </div>
                </td>
            </tr>
        </table>

        <%--Modal PopUp Instruções--%>
        <div id="modalPopUpEntrar" class="modalPopUp modalPopUpEntrar">
            <div class="modalPopUp-Space" style="max-width: 800px;">
                <div class="modalBody">
                    <asp:PlaceHolder ID="phConteudo" runat="server"></asp:PlaceHolder>
                </div>
            </div>
        </div>
    </form>
</body>
<script type="text/javascript">
    window.onload = function () {
        initModalEntrar("modalPopUpEntrar");
    }

    function removeSpaces() {
        var inputCodProva = document.getElementById("txtCodigoProva");
        inputCodProva.value(inputCodProva.trim());
        alert(inputCodProva);
    }

    function initModalEntrar(idModal) {
        var modal = document.getElementById(idModal);
        modal.style.display = "block";
        return false;
    }

    function acertaDiv() {
        if (window.name === '') return;

        var div = window.document.getElementById('divplaceHolder');
        try {
            div.style.height = document.documentElement.clientHeight - div.parentElement.offsetTop;
        }
        catch (e) { }
    }
</script>
</html>

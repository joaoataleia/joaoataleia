<%@ page language="C#" autoeventwireup="true" inherits="TstExecProva, App_Web_tstexecprova.aspx.eb34a1f9" %>
<%@ Register Assembly="RM.Lib.WebForms" Namespace="RM.Lib.WebForms" TagPrefix="RMWF" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <title>Executor de avaliações WEB</title>
  <link rel="stylesheet" type="text/css" href="CSS/estilo.css" />
  <script src="ClientScripts/TstExecProva.js"></script>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <script>
      var tempoExecucaoAvalicao = <%=TempoExecucaoAvaliacao%>;
      var tempoRestanteAvalicao = <%=TempoRestanteAvaliacao%>;
      var tempoAvisoEncerramentoAvaliacao = <%=AvisoEncerramentoAvaliacao%>;
      var tempoAvisoEncerramentoAvaliacaoIntervalo = <%=AvisoEncerramentoAvaliacaoIntervalo%>;
      var tempoSalvamentoAutomaticoAvalicao = <%=TempoSalvamentoAutomaticoAvalicao%>;
      var totalQuestoesDisponiveis = <%=TotalQuestoesDisponiveis%>;
      var indiceQuestaoAtual = <%=IndiceQuestaoAtual%>;
      var totalQuestoesaAvaliacao = <%=TotalQuestoesaAvaliacao%>;
      var descricaoNumeroQuestao = <%=DescricaoNumeroQuestao%>;
      var strMsgAlertaMsgObrigatorio = '<%=strMsgAlertaMsgObrigatorio%>';

      validaIndiceParaInicioProva();

      //Bloqueia a tecla F5
      window.onload = function () {
          document.onkeydown = function (e) {
              return (e.which || e.keyCode) != 116;
          };

          var mostarInstrucoesDeInicio = '<%= Page.IsPostBack%>' == 'False';
        if (mostarInstrucoesDeInicio) {
            OpenModalInstrucoes(true);
        }

        var exibirBotaoSalvar = '<%=ExibirBotaoSalvar%>' == 'True';
          if (exibirBotaoSalvar == true)
              ConfiguraBotaoSalvar();

          var nomePrimeiraQuestao = "questao_" + indiceQuestaoAtual;
          var componentePrimeiraQuestao = document.querySelector('#' + nomePrimeiraQuestao);

          if ((componentePrimeiraQuestao != null) && (componentePrimeiraQuestao.style.display == "none")) {
              QuestaoProxima();
          }
      };

      function validaIndiceParaInicioProva() {
          //Indica que não foi armazenado nenhum valor no campo BEXECPROVA.ULTIMAQUESTAOACESSADA
          if (indiceQuestaoAtual == 0) {
              indiceQuestaoAtual = 1;
          }
      }
  </script>
</head>
<body>
  <form id="form1" runat="server">
    <div id="headerMain" class="header zindex999" style="display: none;">
      <table class="tableHeader">
        <tr runat="server" id="trTitulo">
          <td>
            <img src="Public/Images/totvs_h_pos_grafite.png" alt="TOTVS" />
          </td>
          <td>
            <div class="divAvaliacaoOnline">
              <asp:Label ID="lblAvaliacaoOnline" runat="server" Text="Avaliação Online" CssClass="labelInstrucoes" />
            </div>
          </td>
        </tr>
      </table>
    </div>
    <div id="headerExecProva" class="header">
      <table class="tableHeader">
        <tr>
          <td>
            <img src="Public/Images/totvs_h_pos_grafite.png" alt="TOTVS" /></td>
          <td>
            <div class="divComponentesCabecalho">
              <img id="imgInstrucoes" src="Public/Images/Instrucao.png" class="imgInstrucoes" onclick="OpenModalInstrucoes(false);" />
            </div>
            <div class="divComponentesCabecalho">
              <asp:HyperLink ID="lblInstrucoes" runat="server" Text="Instruções" onclick="OpenModalInstrucoes(false);" CssClass="labelAzulCabecalho labelInstrucoes cursorPointer" />
            </div>
          </td>
          <td>
            <div class="divComponentesCabecalho">
              <img id="imgRespondidas" src="Public/Images/Respondidas.png" class="imgRespondidas" />
            </div>
            <%--Label de questões da prova e respondidas--%>
            <div class="divComponentesCabecalho">
              <asp:Label ID="lblRespondidasTitulo" runat="server" Text="" CssClass="labelAzulCabecalho labelRespondidas" />
              <span id="lblRespondidas" class="labelAzulCabecalho"></span>
            </div>
          </td>
          <td style="width: 25px;">
            <img id="imgLoaderSalvarAutomatico" src="Public/Images/loader.gif" class="loaderSalvarAutomatico" />
          </td>
          <td>
            <div class="divComponentesCabecalho">
              <img id="imgTempoProva" src="Public/Images/Relogio.png" class="imagemTempoProva" />
            </div>
            <%--Tempo da prova--%>
            <div class="divComponentesCabecalho">
              <span id="lblTempo" class="labelTempo">00:00</span>
            </div>
          </td>
          <td></td>
          <td>
            <div style="float: right;">
              <input type="button" id="btnSalvar" value="Salvar" onclick="OpenModalPopUpSalvarAvalicao()" class="botao botaoSalvar" />
              <input type="button" id="btnFinalizar" value="Finalizar" onclick="OpenModalPopUpFinalizarAvaliacao()" class="botao botaoFinalizar" />
            </div>
          </td>
        </tr>
      </table>
    </div>

    <div class="alert alert-secondary alertUser" role="alert">
      <img id="iconUser" src="Public/Images/Candidato.png" class="iconUser" alt="IconUser" />
      <asp:Label runat="server" ID="lblNomeAluno"></asp:Label>
    </div>
    <div class="divBotoesProva">
      <input type="button" id="btnQuestaoAnterior" value="Anterior" onclick="QuestaoAnterior()" class="botao botaoAvancarVoltar" />
      <input type="button" id="btnQuestaoProxima" value="Próximo" onclick="QuestaoProxima()" class="botao botaoAvancarVoltar" />
    </div>

    <%--Questões da prova--%>
    <asp:PlaceHolder ID="placeHolderQuestoes" runat="server" EnableViewState="true"></asp:PlaceHolder>
    <asp:Button ID="btnFinalizarAutomatico" ClientIDMode="Static" runat="server" OnClick="btnFinalizarAutomatico_Click" Text="Finalizar" Style="display: none" />
    <asp:Button ID="btnSalvarAutomatico" ClientIDMode="Static" runat="server" OnClick="btnSalvarAutomatico_Click" Text="Salvar" Style="display: none" />

    <%--Controles de apoio--%>
    <asp:HiddenField ID="hdComentario" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdComentarioOriginal" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdComentarioMensagem" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="imagemAnexoQuestao" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdTempoRestante" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdIndiceCorrente" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdSalvarAutomatico" runat="server" ClientIDMode="Static" Value="0" />
    <input type="hidden" id="__EVENTTARGET" name="__EVENTTARGET" value="" />
    <input type="hidden" id="__EVENTARGUMENT" name="__EVENTARGUMENT" value="" />

    <!-- Modal PopUp Salvar-->
    <div id="modalPopUpSalvar" class="modalPopUp">
      <span class="closemodalPopUpImagem" onclick="CloseModalPopUpSalvarAvalicao()">&times;</span>
      <div class="modalPopUp-Space">
        <table class="modalBody">
          <tr>
            <td>
              <h2>Salvar avaliação</h2>
            </td>
          </tr>
          <tr>
            <td>
              <h3>
                <asp:Label ID="lblSalvarAvaliacao" runat="server" /></h3>
            </td>
          </tr>
          <tr>
            <td>
              <asp:Label ID="lblSalvarTempo" runat="server" /></td>
          </tr>
          <tr>
            <td>
              <asp:Label ID="lblSalvarTempoRestate" runat="server" /></td>
          </tr>
          <tr>
            <td>
              <asp:Label ID="lblSalvarMensagem" runat="server" /></td>
          </tr>
        </table>
        <div class="divBotoesProva">
          <asp:Button ID="btnSalvarAvaliacao" runat="server" Text="Salvar" CssClass="botao botaoCor2" OnClick="btnSalvarAvaliacao_Click" />
          <asp:Button ID="btnSalvarAvaliacaoFechar" runat="server" Text="Cancelar" CssClass="botao botaoCor3" OnClientClick="CloseModalPopUpSalvarAvalicao()" />
        </div>
      </div>
    </div>

    <!-- Modal PopUp Finalizar -->
    <div id="modalPopUpFinalizar" class="modalPopUp">
      <span class="closemodalPopUpImagem" onclick="CloseModalPopUpFinalizarAvaliacao()">&times;</span>
      <div class="modalPopUp-Space">
        <table class="tablePopUpInstrucoes">
          <tr>
            <td>
              <h2>Finalizar avaliação</h2>
            </td>
          </tr>
          <tr>
            <td>
              <h3>
                <asp:Label ID="lblFinalizarAvalicao" runat="server" /></h3>
            </td>
          </tr>
          <tr>
            <td>
              <asp:Label ID="lblFinalizarTempo" runat="server" /></td>
          </tr>
          <tr>
            <td>
              <asp:Label ID="lblFinalizarTempoRestate" runat="server" /></td>
          </tr>
          <tr>
            <td>
              <asp:Label ID="lblFinalizarMensagem" runat="server" /></td>
          </tr>
        </table>
        <br />
        <div class="divBotoesProva">
          <asp:Button ID="btnFinalizarAvaliacao" runat="server" Text="Finalizar" CssClass="botao botaoCor2" OnClientClick="LimpaQuestoesCondicionaisOcultas()" OnClick="btnFinalizarAvaliacao_Click" />
          <asp:Button ID="btnFinalizarAvaliacaoFechar" runat="server" Text="Cancelar" CssClass="botao botaoCor3" OnClientClick="CloseModalPopUpFinalizarAvaliacao()" />
        </div>
      </div>
    </div>

    <%--Modal PopUp Instruções--%>
    <div id="modalPopUpInstrucoes" class="modalPopUp">
      <div class="modalPopUp-Space">
        <div class="modalPopUpInstrucoes">
          <table class="tablePopUpInstrucoes">
            <tr>
              <td>
                <div class="divIconeCandidato">
                  <img id="imgCandidato" src="Public/Images/Candidato.png" class="imagemCandidato" />
                  <asp:Label ID="lblNomePessoa" CssClass="marginTop5" runat="server" />
                </div>
              </td>
            </tr>
            <tr>
              <td>
                <h2>
                  <asp:Label ID="lblNomeProva" runat="server" /></h2>
              </td>
            </tr>
            <tr>
              <td>
                <p>
                  <asp:Label ID="lblAlertaIniciarProva" runat="server" Visible="false" Font-Size="20px" ForeColor="Red" /></p>
              </td>
            </tr>
            <tr>
              <td>
                <div class="instrucaoProva">
                  <asp:Label ID="lblInstrucoesProva" runat="server" />
                </div>
              </td>
            </tr>
            <tr>
              <td>
                <asp:Label ID="lblInstrucaoTempo" runat="server" /></td>
            </tr>
            <tr>
              <td>
                <asp:Label ID="lblInstrucaoRestante" runat="server" /></td>
            </tr>
          </table>
        </div>
        <div class="divBotoesProva">
          <asp:Button ID="btnFecharInstrucoes" runat="server" Text="Cancelar" CssClass="botao botaoCor3" OnClick="btnFecharInstrucoes_Click" />
          <asp:Button ID="btnInicarIntrucoes" runat="server" Text="Iniciar" CssClass="botao botaoCor2" OnClick="btnInicarIntrucoes_Click" OnClientClick="TratarMenu();" />
          <asp:Button ID="btnVoltarAvaliacao" runat="server" Text="Voltar para avaliação" CssClass="botao botaoComentarioAnexo" OnClick="btnInicarIntrucoes_Click" />
        </div>
      </div>
    </div>

    <!-- Modal PopUp alerta tempo -->
    <div id="modalPopUpAlertaTempo" class="modalPopUp">
      <span class="closemodalPopUpImagem" onclick="CloseModalPopUpAlertaTempo()">&times;</span>
      <div class="modalPopUp-Space">
        <table class="modalBody">
          <tr>
            <td>
              <h2>Alerta de tempo</h2>
            </td>
          </tr>
          <tr>
            <td>
              <p>Fique atento com a duração da prova, o tempo está passando!</p>
            </td>
          </tr>
        </table>
        <div class="divBotoesProva">
          <input type="button" id="btnFecharAlerta" value="Fechar" onclick="CloseModalPopUpAlertaTempo()" class="botao botaoCor2" />
        </div>
      </div>
    </div>

  </form>

  <!-- Modal PopUp imagem anexo -->
  <div id="modalPopUpImagem" class="modalPopUp">
    <span class="closemodalPopUpImagem" onclick="FecharModalPopUpImagem()">&times;</span>
    <div class="modalPopUp-content">
      <div class="modalPopUp-content">
        <p class="classQuestaoAnexoComentario">Anexo da questão</p>
        <br />
        <input type="hidden" id="hdImagemTemp" />
        <img alt="Imagem Anexo" id="imgModalPopUpImagem" class="imgAnexo" />
        <br />
        <div class="divBotoesProva">
          <input type="button" value="Fechar" onclick="FecharModalPopUpImagem()" class="botao botaoCor2" />
        </div>
      </div>
    </div>
  </div>

  <!-- Modal PopUp comentário questão -->
  <div id="modalPopUpComentario" class="modalPopUp">
    <span class="closemodalPopUpImagem" onclick="FecharModalPopUpComentario('txtComentario', 'hdComentarioTemp')">&times;</span>
    <div class="modalPopUp-content">
      <p class="classQuestaoAnexoComentario">Comentário</p>
      <input type="hidden" id="hdTextoFecharComentario" />
      <input type="hidden" id="hdComentarioTemp" />
      <textarea id="txtComentario" name="txtComentario" rows="10" cols="80" class="textAreaComentario"></textarea>
      <br />
      <div class="divBotoesProva">
        <input type="button" value="Salvar" onclick="SalvarComentario()" class="botao botaoCor2" />
        <input type="button" value="Cancelar" onclick="FecharModalPopUpComentario()" class="botao botaoCor3" />
      </div>
    </div>
  </div>

</body>
</html>

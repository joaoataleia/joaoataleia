function TemporizadorProva() {
  var duracao = 60 * tempoExecucaoAvalicao;
  var display = document.querySelector('#lblTempo');

  if (tempoExecucaoAvalicao <= 0) {
    display.style.display = "none";
    document.getElementById("imgTempoProva").style.visibility = "hidden";
    duracao = 60 * 480;
  }
  else {
    display.style.display = "block";
    document.getElementById("imgTempoProva").style.visibility = "visible";
  }

  var tempo = duracao, hora, minutos, segundos;
  var intervalorMostraMensagem = 0;
  var intervalorMostraAutoSave = 0;
  var tempoSalvamentoAutomaticoAvalicaoIntervalo = tempoSalvamentoAutomaticoAvalicao;

  if (tempoAvisoEncerramentoAvaliacaoIntervalo == 0)
    tempoAvisoEncerramentoAvaliacaoIntervalo = tempoAvisoEncerramentoAvaliacao;

  setInterval(function () {
    hora = Math.floor(tempo / 60 / 60)
    minutos = Math.floor((tempo / 60) % 60)
    segundos = parseInt(tempo % 60, 10);

    hora = hora < 10 ? "0" + hora : hora;
    minutos = minutos < 10 ? "0" + minutos : minutos;
    segundos = segundos < 10 ? "0" + segundos : segundos;

    display.textContent = hora + ":" + minutos;

    //INICIO: Mensagem de alerta de tempo restante:
    if (tempoAvisoEncerramentoAvaliacao > 0) {
      if (tempo <= tempoAvisoEncerramentoAvaliacao) {
        tempoAvisoEncerramentoAvaliacao = tempoAvisoEncerramentoAvaliacao - tempoAvisoEncerramentoAvaliacaoIntervalo;
        intervalorMostraMensagem = 7;
        OpenModalPopUpAlertaTempo();
      }
    }

    intervalorMostraMensagem--;
    if (intervalorMostraMensagem == 0)
      CloseModalPopUpAlertaTempo();

    //INICIO: AutoSave:
    if (tempoSalvamentoAutomaticoAvalicao > 0) {
      if (tempoSalvamentoAutomaticoAvalicaoIntervalo == 0) {
        intervalorMostraAutoSave = 7;

        tempoSalvamentoAutomaticoAvalicaoIntervalo = tempoSalvamentoAutomaticoAvalicao;
        ExibirIconeAutoSave(true);
        document.getElementById("hdSalvarAutomatico").value = 0;
        document.getElementById('btnSalvarAutomatico').click();
      }

      if (tempoSalvamentoAutomaticoAvalicaoIntervalo >= 0)
        tempoSalvamentoAutomaticoAvalicaoIntervalo--;

      intervalorMostraAutoSave--;
      if (intervalorMostraAutoSave == 0) {
        ExibirIconeAutoSave(false);
        tempoSalvamentoAutomaticoAvalicaoIntervalo = tempoSalvamentoAutomaticoAvalicao;
        document.getElementById("hdSalvarAutomatico").value = tempoSalvamentoAutomaticoAvalicao;
      }
    }
    else {
      ExibirIconeAutoSave(false);
    }

    ContaQuestoesRespondidas();
    ValidaExibicaoBotaoVoltarEAvancar();

    if (tempoExecucaoAvalicao > 0) {
      tempoExecucaoAvalicao = Math.round(tempo / 60);
      DefineTempoRestante();
    }

    //Tempo do timer geral
    if (--tempo < 0) {
      //salvar automaticoao final 
      document.getElementById('btnFinalizarAutomatico').click();
      tempo = duracao;
    }
  }, 1000);
}

function ValidaExibicaoBotaoVoltarEAvancar() {
  if (totalQuestoesDisponiveis == 1) {
    document.getElementById("btnQuestaoAnterior").disabled = true;
    document.getElementById("btnQuestaoProxima").disabled = true;
  }
  else if (indiceQuestaoAtual <= 1 && totalQuestoesDisponiveis > 1) {
    document.getElementById("btnQuestaoAnterior").disabled = true;
    document.getElementById("btnQuestaoProxima").disabled = false;
  }
  else if (indiceQuestaoAtual > 1 && indiceQuestaoAtual < totalQuestoesDisponiveis) {
    document.getElementById("btnQuestaoAnterior").disabled = false;
    document.getElementById("btnQuestaoProxima").disabled = false;
  }
  else if (indiceQuestaoAtual > 1 && indiceQuestaoAtual >= totalQuestoesDisponiveis) {
    if (TemQuestaoProximaDisponivel(indiceQuestaoAtual)) {
          document.getElementById("btnQuestaoAnterior").disabled = false;
          document.getElementById("btnQuestaoProxima").disabled = false;
    }
    else {
      document.getElementById("btnQuestaoAnterior").disabled = false;
      document.getElementById("btnQuestaoProxima").disabled = true;
    }
  }
  else
    document.getElementById("btnQuestaoAnterior").disabled = false;
}

function DefineTempoRestante() {
  localStorage['tempoExecucaoAvalicao'] = tempoExecucaoAvalicao;
  document.getElementById("hdTempoRestante").value = tempoExecucaoAvalicao;
}

function TemQuestaoProximaDisponivel(indiceProximaQuestao) {
  var idsQuestoesAvaliacao = document.getElementById('IDsQuestoesAvaliacao');
  var questoesAvaliacaoList = idsQuestoesAvaliacao.value.split('#');

  var temProximaQuestaoDisponivel = false;
  for (var indexQuestao = indiceProximaQuestao; indexQuestao < questoesAvaliacaoList.length; indexQuestao++) {
    var componenteQuestao = document.getElementById(questoesAvaliacaoList[indexQuestao]);
    if (componenteQuestao != null && componenteQuestao.style.display != "none") {
      temProximaQuestaoDisponivel = true;
      break;
    }        
  }

    return temProximaQuestaoDisponivel;
}

function ContaQuestoesRespondidas() {
  var idsQuestoesAvaliacao = document.getElementById('IDsQuestoesAvaliacao');

  if (idsQuestoesAvaliacao == null)
    return;

  var questoesAvaliacaoList = idsQuestoesAvaliacao.value.split('#');

  var totalQuestoesRespondidas = 0;
  totalQuestoesDisponiveis = 0;
  
  for (var indexQuestao = 0; indexQuestao < questoesAvaliacaoList.length; indexQuestao++) {
    var componenteQuestao = document.getElementById(questoesAvaliacaoList[indexQuestao]);

    if (componenteQuestao == null)
      continue;

    if (componenteQuestao.style.display == "none")
      continue;

    totalQuestoesDisponiveis++;
    var opcoesRespostasComponenteQuestao = componenteQuestao.getElementsByTagName("input");

    if (opcoesRespostasComponenteQuestao != null && opcoesRespostasComponenteQuestao.length > 0) {
      for (var indexOpcaoRespostas = 0; indexOpcaoRespostas < opcoesRespostasComponenteQuestao.length; indexOpcaoRespostas++) {
        if (opcoesRespostasComponenteQuestao[indexOpcaoRespostas].type == "radio" || opcoesRespostasComponenteQuestao[indexOpcaoRespostas].type == "checkbox") {
          if (opcoesRespostasComponenteQuestao[indexOpcaoRespostas].checked == true) {
            totalQuestoesRespondidas++;
            break;
          }
        }
      }
    }
    else if (opcoesRespostasComponenteQuestao.length == 0) {
      var campoTexto = document.getElementById(questoesAvaliacaoList[indexQuestao]);
      if (campoTexto != null) {
        if (campoTexto.type == "textarea") {
          if (campoTexto.value != "") {
            totalQuestoesRespondidas++;
            continue;
          }
        }
      }
    }
  }

  var labelQuestoesResponsidas = document.querySelector('#lblRespondidas');
  labelQuestoesResponsidas.textContent = totalQuestoesRespondidas + " de " + totalQuestoesDisponiveis;
}

function ExibirIconeAutoSave(exibir) {
  if (exibir == true)
    document.getElementById("imgLoaderSalvarAutomatico").style.display = "block";
  else
    document.getElementById("imgLoaderSalvarAutomatico").style.display = "none";
}

function QuestaoProxima() {
  var indiceProximaQuestao = indiceQuestaoAtual + 1;
  var encontrouProximaQuestao = false;

  while (!encontrouProximaQuestao) {

    var divAtualQuestao = "divQuestao_" + indiceQuestaoAtual + "qst";
    var divProximaQuestao = "divQuestao_" + indiceProximaQuestao + "qst";
    var nomeProximaQuestao = "questao_" + indiceProximaQuestao;
    var componenteProximaQuestao = document.querySelector('#' + nomeProximaQuestao);

    if (componenteProximaQuestao == null) {
      return;
    }

    if (componenteProximaQuestao.style.display != "none") {
      document.getElementById(divProximaQuestao).style.display = "block";
      document.getElementById(divAtualQuestao).style.display = "none";

      indiceQuestaoAtual = indiceProximaQuestao;

      var lblCodigo = "lblCodigoQuestao_" + indiceProximaQuestao;
      document.getElementById(lblCodigo).innerHTML = "Questão " + indiceQuestaoAtual;

      encontrouProximaQuestao = true;
    }
    else {
      indiceProximaQuestao++;
    }
  }

  ValidaExibicaoBotaoVoltarEAvancar();
  DefineIndiceCorrente();
}

function QuestaoAnterior() {
  var indiceQuestaoAnterior = indiceQuestaoAtual - 1;
  var encontrouQuestaoAnterior = false;

  if (indiceQuestaoAnterior <= 0)
    return;

  while (!encontrouQuestaoAnterior) {
    if (indiceQuestaoAnterior <= 0)
      return;

    var nomeQuestaoAnterior = "questao_" + indiceQuestaoAnterior;
    var componenteAnteriorQuestao = document.querySelector('#' + nomeQuestaoAnterior);

    if (componenteAnteriorQuestao != null && componenteAnteriorQuestao.style.display != "none") {
      var divQuestaoAtual = "divQuestao_" + indiceQuestaoAtual + "qst";
      var divQuestaoAnterio = "divQuestao_" + indiceQuestaoAnterior + "qst";
  
      document.getElementById(divQuestaoAnterio).style.display = "block";
      document.getElementById(divQuestaoAtual).style.display = "none";

      indiceQuestaoAtual = indiceQuestaoAnterior;
      
      var lblCodigo = "lblCodigoQuestao_" + indiceQuestaoAnterior;
      document.getElementById(lblCodigo).innerHTML = "Questão " + indiceQuestaoAtual;

      encontrouQuestaoAnterior = true;
    }
    else {
      indiceQuestaoAnterior--;
    }
  }

  ValidaExibicaoBotaoVoltarEAvancar();
  DefineIndiceCorrente();
}

function DefineIndiceCorrente() {
  localStorage['indiceQuestao'] = indiceQuestaoAtual;
  document.getElementById("hdIndiceCorrente").value = indiceQuestaoAtual;
}

function TratarMenu() {
  var headerMain = document.getElementById("headerMain");
  var headerExecProva = document.getElementById("headerExecProva");
  headerMain.style.display = "none";
  headerExecProva.style.display = "block";
}

//Modal de instruções
function OpenModalInstrucoes(chamadaInicioProva) {
  var modal = document.getElementById("modalPopUpInstrucoes");
  var headerMain = document.getElementById("headerMain");

  modal.style.display = "block";
  headerMain.style.display = "block";

  if (chamadaInicioProva) {
    var botaoVoltar = document.getElementById("btnVoltarAvaliacao");
    botaoVoltar.style.display = "none";
  }
  else {
    var botaoIniciar = document.getElementById("btnInicarIntrucoes");
    var botaoFechar = document.getElementById("btnFecharInstrucoes");
    var lblAlertaIniciar = document.getElementById("lblAlertaIniciarProva");

    botaoIniciar.style.display = "none";
    botaoFechar.style.display = "none";
    lblAlertaIniciar.style.display = "none";
  }

  return false;
}

/*Modal de comentário*/
function AbrirModalPopUpComentario(componente) {
  document.getElementById('txtComentario').value = document.getElementById(componente).value;
  document.getElementById('hdComentarioTemp').value = componente;
  var modal = document.getElementById("modalPopUpComentario");
  modal.style.display = "block";
}

function FecharModalPopUpComentario() {
  var modal = document.getElementById("modalPopUpComentario");
  modal.style.display = "none";

  document.getElementById('hdComentarioTemp').value = null;
  document.getElementById('txtComentario').value = null;
}

function SalvarComentario() {
  var componente = document.getElementById('hdComentarioTemp').value;
  document.getElementById(componente).value = document.getElementById('txtComentario').value;

  var modal = document.getElementById("modalPopUpComentario");
  modal.style.display = "none";
}

/*Modal de imagem*/
function AbrirModalPopUpImagem(componente) {
  var modalImg = document.getElementById("imgModalPopUpImagem");
  document.getElementById('hdImagemTemp').value = componente;
  var img = document.getElementById(componente);
  modalImg.src = img.value;

  document.getElementById('hdImagemTemp').value = componente;
  var modal = document.getElementById("modalPopUpImagem");
  modal.style.display = "block";
}

function FecharModalPopUpImagem() {
  var modal = document.getElementById("modalPopUpImagem");
  modal.style.display = "none";

  document.getElementById('hdImagemTemp').value = null;
  document.getElementById('imgModalPopUpImagem').value = null;
}

//Modal de finalizar a prova
function OpenModalPopUpFinalizarAvaliacao() {

  if (ValidaObrigatorias()) {
    var modal = document.getElementById("modalPopUpFinalizar");
    modal.style.display = "block";
  }
}

function CloseModalPopUpFinalizarAvaliacao() {
  var modal = document.getElementById("modalPopUpFinalizar");
  modal.style.display = "none";
}

//Modal de salvar a prova
function OpenModalPopUpSalvarAvalicao() {
  var modal = document.getElementById("modalPopUpSalvar");
  modal.style.display = "block";
}

function CloseModalPopUpSalvarAvalicao() {
  var modal = document.getElementById("modalPopUpSalvar");
  modal.style.display = "none";
}

//Modal de alerta de tempo
function OpenModalPopUpAlertaTempo() {
  var modal = document.getElementById("modalPopUpAlertaTempo");

  if (document.getElementById("modalPopUpImagem").style.display != "block")
    modal.style.display = "block";
}

function CloseModalPopUpAlertaTempo() {
  var modal = document.getElementById("modalPopUpAlertaTempo");
  modal.style.display = "none";
}

function ConfiguraBotaoSalvar() {
  document.getElementById("btnSalvar").style.visibility = "visible";
}

/*Tratamento para questoes condicionais*/
function Habilitar(idHidden) {
  var Component = document.getElementById(idHidden);

  if (Component == null)
    return;
  else {
    if (Component.style.display != "block") {
      Component.style.display = "block";
    }
  }
}

function Desabilitar(idHidden) {
  var Component = document.getElementById(idHidden);

  if (Component == null)
    return;
  else {
    if (Component.style.display != "none") {
      Component.style.display = "none";
    }
  }
}

function ValidaObrigatorias() {
  var idsQuestoesObrigatorias = document.getElementById('IDsQuestoesObrigatorio');
  if (idsQuestoesObrigatorias == null)
    return;

  var encontrouResposta = 0;
  var totalObrigatoriasVisiveis = 0;
  var questoesObrigatoriasList = new Array();

  questoesObrigatoriasList = idsQuestoesObrigatorias.value.split('#');

  for (var i = 0; i < questoesObrigatoriasList.length; i++) {
    var componenteQuestaoObrigatoria = document.getElementById(questoesObrigatoriasList[i]);
    if (componenteQuestaoObrigatoria == null)
      continue;

    if (componenteQuestaoObrigatoria.style.display == "none")
      continue;

    totalObrigatoriasVisiveis++;

    var ListaComponentes = componenteQuestaoObrigatoria.getElementsByTagName("input");

    if (ListaComponentes != null && ListaComponentes.length > 0) {
      for (var j = 0; j < ListaComponentes.length; j++) {
        if (ListaComponentes[j].type == "radio" || ListaComponentes[j].type == "checkbox") {
          if (ListaComponentes[j].checked == true) {
            encontrouResposta++;
            break;
          }
        }
      }
    }
    else if (ListaComponentes.length == 0) {
        var campoTexto = document.getElementById(questoesObrigatoriasList[i]);
      if (campoTexto != null) {
        if (campoTexto.type == "textarea") {
          if (campoTexto.value != "") {
            encontrouResposta++;
            continue;
          }
        }
      }
    }
  }

  if (encontrouResposta < totalObrigatoriasVisiveis) {
    alert(strMsgAlertaMsgObrigatorio);
    return false;
  }
  else
    return true;
}

function LimpaQuestoesCondicionaisOcultas() {
  var IDsQuestoesAvaliacao = document.getElementById('IDsQuestoesAvaliacao');
  if (IDsQuestoesAvaliacao == null) {
    return;
  }    

  var condicionaisOcultas = "";
  var controlsClientID = IDsQuestoesAvaliacao.value;
  var arrayControlsClientID = new Array();

  arrayControlsClientID = controlsClientID.split('#');

  for (var i = 0; i < arrayControlsClientID.length; i++) {
    var Componente = document.getElementById(arrayControlsClientID[i]);
    if (Componente == null)
      continue;

    if (Componente.style.display == "none") {
      condicionaisOcultas = condicionaisOcultas + arrayControlsClientID[i] + "#";
      var ListaComponentes = Componente.getElementsByTagName("input");

      if (ListaComponentes != null && ListaComponentes.length > 0) {
        for (var j = 0; j < ListaComponentes.length; j++) {
          if (ListaComponentes[j].type == "radio" || ListaComponentes[j].type == "checkbox") {
            ListaComponentes[j].checked == false;
          }
        }
      }
      else if (ListaComponentes.length == 0) {
        var campoTexto = document.getElementById(arrayControlsClientID[i]);
        if (campoTexto != null) {
          if (campoTexto.type == "textarea") {
            campoTexto.value != "";
          }
        }
      }
    }
  }

  document.getElementById('hdCondicionaisOcultas').value = condicionaisOcultas;
}
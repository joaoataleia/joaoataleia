/*<RMJSDep>...;...;...;...;...;Source/Tst-Avaliacao/RM.Tst.Provas/TstQuestionario.js.aspx</RMJSDep>*/

var txtRetorno;
var questionName;
var readonly;

var ModalWindow = null;
var ModalWindowOnClick = null;
var ModalWindowOnFocus = null;
var ModalWindowOnUnload = null;
var ModalWindowOnMouseMove = null;
var ModalDoRefresh = false;

function showReadOnly(objRetorno, question, somenteleitura) {
    questionName = question;
    txtRetorno = objRetorno;
    readonly = somenteleitura
    ShowModalWindow(urlFormComment, 'Comentario', 'height=350, width=600, left=10, top=10, resizable=yes, status=yes', true);
}

function show(objRetorno, question) {
    questionName = question;
    txtRetorno = objRetorno;
    ShowModalWindow(urlFormComment, 'Comentario', 'height=350, width=600, left=10, top=10, resizable=yes, status=yes', true);
}


function showFigura(objRetorno, question, idFigura) {
    questionName = question;
    txtRetorno = objRetorno;

    var urlParams = new URLSearchParams(window.location.search);
    var portalOrigem = urlParams.get('OWNERDATA');

    if (portalOrigem == 'novoPortal')
        ShowModalFiguraWindowPortalNovo(urlFormFigura + idFigura, 'Figura', 'height=350, width=600, left=10, top=10, resizable=yes, status=yes, scrollbars=yes', true);
    else
        ShowModalWindow(urlFormFigura + idFigura, 'Figura', 'height=350, width=600, left=10, top=10, resizable=yes, status=yes, scrollbars=yes', true);
}

function showAction(name, params) {
    ShowModalWindow(urlBase + name + '&' + params, 'pop', 'height=350, width=600, left=10, top=10, resizable=yes, status=yes');
}

function setBodyOnUnloadEvent(value) {
    window.document.body.onunload = function () {
        eval(value);
    }
}

function ShowModalFiguraWindowPortalNovo(Url, WindowName, WindowFeatures, NoCache) {
    SetFiguraWindowEventsBlockedPortalNovo(true);
    ModalWindow = OpenWindow(Url, WindowName, WindowFeatures);
    ModalWindow.focus();
}

function SetFiguraWindowEventsBlockedPortalNovo(Blocked) {
    if (Blocked) {

        //Guardar eventos para nao perder
        if (window.document.onclick != ModalWindowOnClick)
            ModalWindowOnClick = window.document.onclick;

        if (!isIE()) {
            window.document.captureEvents(Event.CLICK | Event.FOCUS);
        }

        window.document.onclick = ModalWindowIgnoreEvents;

        if (window.document.onfocus != ModalWindowOnFocus)
            ModalWindowOnFocus = window.document.onfocus;
        if (window.document.onmousemove != ModalWindowOnMouseMove)
            ModalWindowOnMouseMove = window.document.onmousemove;
        if (window.onunload != ModalWindowOnUnload)
            ModalWindowOnUnload = window.onunload;

        window.document.onfocus = ModalWindowHandleFocusPortalNovo;
        window.document.onmousemove = ModalWindowHandleFocusPortalNovo;
        window.onunload = GetEventHandlerFunction(window.onunload, "CloseModalWindow()");
    }
    else {
        if (!isIE()){
            window.document.releaseEvents(Event.CLICK | Event.FOCUS);
        }

        window.document.onclick = ModalWindowOnClick;

        window.document.onfocus = ModalWindowOnFocus;
        window.document.onmousemove = ModalWindowOnMouseMove;
        window.onunload = ModalWindowOnUnload;
    }

    SetWindowImageEventsBlocked(Blocked);

    if ((!Blocked) &&
        (ModalDoRefresh)) {
        SubmitWindow(window);
    }
}

//Retorna true se focou na janela modal
function ModalWindowHandleFocusPortalNovo() {
    if (ModalWindow) {
        var disableModalWindow = false;
        try {
            disableModalWindow = ModalWindow.closed;
        }
        catch (E) {
            disableModalWindow = true;
        }

        if (!disableModalWindow) {
            try {
                ModalWindow.focus();
            }
            catch (e) {
            }

            return true;
        }
        else {
            SetFiguraWindowEventsBlockedPortalNovo(false);
            return false;
        }
    }

    return false;
}

function setBotaoFinalizarEvent() {
    window.onbeforeunload = null;
}

function OrganizarNumeracao(idHidden, TstCaptionQuestao) {
    var controlsClientID = document.getElementById(idHidden).value;

    if (controlsClientID != null) {

        var arrayControlsClientID = new Array();
        arrayControlsClientID = controlsClientID.split('#');

        var numQuestVisivel = 0;

        for (var i = 0; i < arrayControlsClientID.length; i++) {
            var Component = document.getElementById(arrayControlsClientID[i]);

            if (Component != null) {
                if (Component.style.display != 'none') {
                    numQuestVisivel++;
                    Component.value = TstCaptionQuestao + ' ' + numQuestVisivel;
                }
            }
        }
    }
}

function Habilitar(idHidden) {

    var controlsClientID = document.getElementById(idHidden).value;

    if (controlsClientID != null) {

        var arrayControlsClientID = new Array();
        arrayControlsClientID = controlsClientID.split('#');

        for (var i = 0; i < arrayControlsClientID.length; i++) {
            var Component = document.getElementById(arrayControlsClientID[i]);

            if (Component == null)
                continue;
            else
                Component.style.display = 'inline';
        }
    }
}

function Desabilitar(idHidden) {
    var controlsClientID = document.getElementById(idHidden).value;

    if (controlsClientID != null) {

        var arrayControlsClientID = new Array();
        arrayControlsClientID = controlsClientID.split('#');

        for (var i = 0; i < arrayControlsClientID.length; i++) {
            var Component = document.getElementById(arrayControlsClientID[i]);

            if (Component == null)
                continue;
            else
                Component.style.display = 'none';
        }
    }
}

function desabilitarBotaoFinalizar() {
    document.querySelectorAll("[id$='btFinish']")[0].style.visibility = 'hidden';
}

_controleFechar = false;
window.onbeforeunload = function (e) {
    _controleFechar = true;
    var e = e || window.event;
    var mensagem = STstJSMensagemSairSemSalvar;

    //Para IE e Firefox
    if (e)
        e.returnValue = mensagem;

    //Para outros navegadores
    return mensagem;
};
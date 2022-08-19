<%@ control language="C#" autoeventwireup="true" inherits="TstLogin, App_Web_tstlogin.ascx.e95fadbb" %>
<%@ Register Assembly="RM.Lib.WebForms" Namespace="RM.Lib.WebForms" TagPrefix="RMWF" %>
<%@ Register Assembly="DevExpress.Web.v19.2" Namespace="DevExpress.Web" TagPrefix="dx" %>
<div>
    <table cellpadding="0" cellspacing="0" border="0" style="width: 100%">
        <tr runat="server" id="trListaProvas" visible="false" align="center">
            <td>
                <br />
                <table border="0" cellpadding="0" cellspacing="0" style="width: 90%" align="center" class="table-grid-view">
                    <tr align="center">
                        <td>
                            <dx:ASPxGridView ID="gvAvaliacao" runat="server" AutoGenerateColumns="False" ClientIDMode="AutoID"
                                Width="764px" ClientInstanceName="gvAvaliacao" KeyFieldName="PROVA" OnCustomUnboundColumnData="gvAvaliacao_CustomUnboundColumnData"
                                PreviewFieldName="CODPROVA" OnCustomCallback="gvAvaliacao_CustomCallback" OnHtmlDataCellPrepared="gvAvaliacao_HtmlDataCellPrepared"
                                ForeColor="Black" OnDataBinding="gvAvaliacao_DataBinding"
                                OnAfterPerformCallback="gvAvaliacao_AfterPerformCallback"
                                Style="margin-left: 0">
                                <Columns>
                                    <dx:GridViewDataTextColumn Caption="Avaliação" FieldName="NOME" VisibleIndex="1" Width="25%">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn Caption="Grupo" FieldName="GRUPOPROVA" VisibleIndex="2" Width="15%">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn Caption="Período" FieldName="PERIODOPROVA" VisibleIndex="3"
                                        Width="15%">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn Caption="CodProva" FieldName="CODPROVA" Visible="False"
                                        VisibleIndex="4">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn Caption="Prova" FieldName="PROVA" Visible="False" VisibleIndex="5"
                                        UnboundType="String">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn Caption="ID" FieldName="ID" Visible="False" VisibleIndex="6">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn Caption="Coligada" FieldName="CODCOLIGADA" Visible="False"
                                        VisibleIndex="7">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn Caption="Status" FieldName="STATUS" Visible="False" VisibleIndex="8">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn Caption="Código do idioma" FieldName="CODIDIOMA" Visible="False"
                                        VisibleIndex="9">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn Caption="Idiomas" FieldName="CODIDIOMASEL" Name="IdiomasProva"
                                        VisibleIndex="10" Width="20%">
                                        <PropertiesTextEdit ClientInstanceName="cbbIdiomasProva" EnableClientSideAPI="True">
                                        </PropertiesTextEdit>
                                        <DataItemTemplate>
                                            <dx:ASPxComboBox ID="cbbIdiomas" runat="server" ClientInstanceName="cbbIdiomas" EnableCallbackMode="True"
                                                EnableClientSideAPI="True" ShowShadow="False" ClientIDMode="AutoID" ValueType="System.String">
                                                <ClientSideEvents SelectedIndexChanged="function(s, e) {
	var val = s.GetValue();	
	var idxRow = gvAvaliacao.GetFocusedRowIndex();
	gvAvaliacao.PerformCallback(val+&quot;;&quot;+idxRow);	
}" />
                                            </dx:ASPxComboBox>
                                        </DataItemTemplate>
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn Caption="Código idioma execução" FieldName="CODIDIOMAEXEC"
                                        Visible="False" VisibleIndex="0">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn Caption="Executante" FieldName="NOMEPESSOA" Name="Executante"
                                        VisibleIndex="13" Width="25%">
                                    </dx:GridViewDataTextColumn>
                                </Columns>
                                <SettingsBehavior AllowGroup="True" AllowSort="False" AllowSelectSingleRowOnly="True"
                                    AllowSelectByRowClick="True" AllowFocusedRow="True" ProcessFocusedRowChangedOnServer="True" />

                                <SettingsBehavior AllowSort="True" AllowGroup="False" AllowFocusedRow="True" AllowSelectByRowClick="True"
                                    AllowSelectSingleRowOnly="True" ProcessFocusedRowChangedOnServer="True"></SettingsBehavior>

                                <SettingsPager Visible="True">
                                </SettingsPager>
                                <Styles>
                                    <AlternatingRow Enabled="False">
                                    </AlternatingRow>
                                    <FocusedRow BackColor="#AABBCB">
                                    </FocusedRow>
                                </Styles>
                            </dx:ASPxGridView>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <br />
                        </td>
                    </tr>
                    <tr align="center">
                        <td>
                            <br />
                            <asp:Button ID="BtnExecutar" runat="server" OnClick="BtnExecutar_Click" Text="Entrar"
                                CssClass="TstBtn" />
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:Button ID="btnVoltar" runat="server" OnClick="btnVoltarErro_Click" Text="Voltar"
                                CssClass="TstBtn" />
                        </td>
                    </tr>
                    <tr>
                        <td align="left">&nbsp;
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr runat="server" id="trLogin">
            <td style="width: 100%; height: 103px;" align="center" valign="bottom">
                <table border="0" cellpadding="0" cellspacing="0" style="width: 329px">
                    <tr>
                        <h2 class="titleEntrar">
                            <asp:Label ID="lblTitulo" runat="server" Text="Olá,"></asp:Label>
                        </h2>

                        <h6 class="subTitleEntrar">
                            <asp:Label ID="lblSubTitle" runat="server" Text="Para acessar sua avaliação, por favor insira a chave de acesso no campo abaixo:">
                            </asp:Label>
                        </h6>
                    </tr>
                    <tr>
                        <div class="marginInputs">
                            <RMWF:RMWTextBox ID="txtIDExecProva" runat="server" FieldName="" HideCaption="True" placeholder="Digite aqui..."
                                autocomplete="off" CssClass="inputEntrar"></RMWF:RMWTextBox>
                        </div>
                    </tr>
                    <tr>
                        <td>&nbsp;
                        </td>
                    </tr>
                    <tr>
                        <div class="marginInputs">
                            <asp:Button ID="btnEntrar" runat="server" OnClick="btnEntrar_Click" Text="Entrar" CssClass="botao buttonEntrar" />
                        </div>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td align="center"></td>
        </tr>
        <tr runat="server" id="trErroId" align="center" visible="false">
            <td>
                <div class="alert alert-danger" role="alert">
                    <label>Avaliação indisponível!</label>
                    <br>
                    <ul>
                        <li class="noListType">Possíveis causas:</li>
                        <li>O ID de execução pode ser inválido.</li>
                        <li>Avaliação já foi executada.</li>
                        <li>Avaliação fora do período válido para execução.</li>
                        <li>Avaliação já foi iniciada e só pode ser iniciada uma única vez.</li>
                    </ul>
                </div>
                <br />
                <asp:Button ID="btnVoltarErro" runat="server" OnClick="btnVoltarErro_Click" Text="Voltar" CssClass="botao buttonEntrar" />
            </td>
        </tr>
        <tr>
            <td align="center"></td>
        </tr>
    </table>
</div>
<RMWF:RMWObjectDataSource ID="dtsProvas" runat="server" SelectMethod="ReadViewProvas"
    TypeName="RM.Tst.Provas.TstSelecaoProvasActionWeb" OnSelecting="dtsProvas_Selecting"
    OnSelected="dtsProvas_Selected">
    <SelectParameters>
        <asp:Parameter DbType="String" Name="IDExecucao" />
    </SelectParameters>
</RMWF:RMWObjectDataSource>
<RMWF:RMWObjectDataSource ID="dtsIdiomasProva" runat="server" OnSelecting="dtsIdiomasProva_Selecting"
    SelectMethod="ReadViewIdiomasProva" TypeName="RM.Tst.Provas.TstSelecaoIdiomasProvaActionWeb"
    TableName="BIDIOMAS">
</RMWF:RMWObjectDataSource>

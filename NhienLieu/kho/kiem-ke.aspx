<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="kiem-ke.aspx.cs" Inherits="NhienLieu.lap_phieu.kiem_ke" %>

<%@ Register Src="~/lap-phieu/KiemKeControl.ascx" TagPrefix="uc1" TagName="KiemKeControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <uc1:KiemKeControl runat="server" id="KiemKeControl" />
</asp:Content>

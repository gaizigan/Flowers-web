<%@ Page Title="Магазин 3" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" 
  CodeFile="store3.aspx.cs" Inherits="store3_store3" %>


 <asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
        AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" 
        BorderStyle="None" BorderWidth="1px" CellPadding="3" 
        DataSourceID="SqlDataSource1" GridLines="Vertical" PageSize="20" 
        Width="915px">
        <AlternatingRowStyle BackColor="#DCDCDC" />
        <Columns>
            <asp:CommandField ShowEditButton="True" CancelText="Отмена" EditText="Изменить" 
                UpdateText="Обновить" />
            <asp:BoundField DataField="orders" HeaderText="Заказы" 
                SortExpression="orders" />
            <asp:BoundField DataField="name" HeaderText="Цветок" SortExpression="name" 
                ReadOnly="True" />
            <asp:BoundField DataField="counts" HeaderText="Количество" 
                SortExpression="counts" ReadOnly="True" />
            <asp:BoundField DataField="buyerPhone" HeaderText="Телефон" 
                SortExpression="buyerPhone" ReadOnly="True" />
            <asp:BoundField DataField="destination" HeaderText="Адрес" 
                SortExpression="destination" ReadOnly="True" />
            <asp:BoundField DataField="deliveringTimeTo" HeaderText="Время доставки" 
                SortExpression="deliveringTimeTo" ReadOnly="True" />
            <asp:CheckBoxField DataField="isDelivered" HeaderText="Доставлено" 
                SortExpression="isDelivered" />
            <asp:BoundField DataField="comments" HeaderText="Комментарии" 
                SortExpression="comments" />
        </Columns>
        <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
        <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
        <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
        <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
        <SortedAscendingCellStyle BackColor="#F1F1F1" />
        <SortedAscendingHeaderStyle BackColor="#0000A9" />
        <SortedDescendingCellStyle BackColor="#CAC9C9" />
        <SortedDescendingHeaderStyle BackColor="#000065" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:gaizigan_5ConnectionString %>" 
        SelectCommand="SELECT OrderedItem.orders, Item.name, OrderedItem.counts, Orders.buyerPhone, Orders.destination, Orders.deliveringTimeTo, Orders.isDelivered, Orders.comments FROM OrderedItem INNER JOIN Orders ON OrderedItem.orders = Orders.id INNER JOIN Item ON OrderedItem.item = Item.id WHERE (Orders.store = @storeID)" 
        
    
    
        UpdateCommand= "UPDATE Orders SET isDelivered = @isDelivered, comments = @comments FROM Orders INNER JOIN OrderedItem ON Orders.id = OrderedItem.orders WHERE (OrderedItem.orders = @orders)">
                <SelectParameters>
            <asp:Parameter DefaultValue="3" Name="storeID" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="isDelivered" />
            <asp:Parameter Name="comments" />
            <asp:Parameter Name="orders" />
        </UpdateParameters>
    </asp:SqlDataSource>   
</asp:Content>


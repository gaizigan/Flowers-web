<%@ Page Title="Магазин 5" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" 
  CodeFile="store5.aspx.cs" Inherits="store5_store5" %>


 <asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
     <script language=javascript type="text/javascript">
         function expandcollapse(obj, row) {
             var div = document.getElementById(obj);
             var img = document.getElementById('img' + obj);

             if (div.style.display == "none") {
                 div.style.display = "block";
                 if (row == 'alt') {
                     img.src = "../minus.gif";
                 }
                 else {
                     img.src = "../minus.gif";
                 }
                 img.alt = "Close to view other Customers";
             }
             else {
                 div.style.display = "none";
                 if (row == 'alt') {
                     img.src = "../plus.gif";
                 }
                 else {
                     img.src = "../plus.gif";
                 }
                 img.alt = "Expand to show Orders";
             }
         } 
    </script>

</asp:Content>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
      <asp:GridView ID="GridView1" AllowPaging="True" BackColor="White" 
            AutoGenerateColumns="false" DataSourceID="AccessDataSource1" DataKeyNames="id"
            Font-Names="Verdana" runat="server" GridLines="Vertical, Horizontal" OnRowDataBound="GridView1_RowDataBound" 
            OnRowUpdating = "GridView1_RowUpdating" BorderStyle=Outset
            OnRowDeleting = "GridView1_RowDeleting" OnRowDeleted = "GridView1_RowDeleted"
            OnRowUpdated = "GridView1_RowUpdated" AllowSorting=true Width="915px">
            <RowStyle BackColor="Gainsboro" />
            <AlternatingRowStyle BackColor="White" />
            <HeaderStyle BackColor="#0083C1" ForeColor="White"/>
            <FooterStyle BackColor="White" />
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <a href="javascript:expandcollapse('div<%# Eval("id") %>', 'one');">
                            <img id="imgdiv<%# Eval("id") %>" alt="Click to show/hide Orders for Customer <%# Eval("id") %>"  width="9px" border="0" src="../plus.gif"/>
                        </a>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Номер заказа" SortExpression="id">
                    <ItemTemplate>
                        <asp:Label ID="lblid" Text='<%# Eval("id") %>' runat="server"></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:Label ID="lblid" Text='<%# Eval("id") %>' runat="server"></asp:Label>
                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="txtid" Text='' runat="server"></asp:TextBox>
                    </FooterTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Телефон заказчика" SortExpression="CompanyName">
                    <ItemTemplate><%# Eval("buyerPhone")%></ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtCompanyName" Text='<%# Eval("buyerPhone") %>' runat="server"></asp:TextBox>
                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="txtCompanyName" Text='' runat="server"></asp:TextBox>
                    </FooterTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Адрес доставки" SortExpression="ContactName">
                    <ItemTemplate><%# Eval("destination")%></ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtContactName" Text='<%# Eval("destination") %>' runat="server"></asp:TextBox>
                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="txtContactName" Text='' runat="server"></asp:TextBox>
                    </FooterTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Время доставки" SortExpression="ContactTitle">
                    <ItemTemplate><%# Eval("deliveringTimeTo")%></ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtContactTitle" Text='<%# Eval("deliveringTimeTo") %>' runat="server"></asp:TextBox>
                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="txtContactTitle" Text='' runat="server"></asp:TextBox>
                    </FooterTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Доставлено" SortExpression="isDelivered">
                    <ItemTemplate>
                        <asp:CheckBox ID="chkLinked" runat="server"
                            Checked='<%#  Eval("isDelivered") == DBNull.Value ? false : Convert.ToBoolean(Eval("isDelivered")) %>'
                            OnCheckedChanged="chkLinked_CheckedChanged" AutoPostback="true"  />
                    </ItemTemplate>
                </asp:TemplateField>
                
                <asp:TemplateField HeaderText="Комментарии" SortExpression="ContactTitle">
                    <ItemTemplate><%# Eval("comments")%></ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtContactTitle" Text='<%# Eval("comments") %>' runat="server"></asp:TextBox>
                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="txtContactTitle" Text='' runat="server"></asp:TextBox>
                    </FooterTemplate>
                </asp:TemplateField>             
			    
			    <asp:CommandField HeaderText="Изменить" ShowEditButton="True" />

			    
			    <asp:TemplateField>
			        <ItemTemplate>
			            <tr>
                            <td colspan="100%">
                                <div id="div<%# Eval("id") %>" style="display:none;position:relative;left:9px; OVERFLOW: auto;WIDTH:100%" >

                                    <asp:GridView ID="GridView2" AllowPaging="True" AllowSorting="false" BackColor="White" Font-Size=Small
                                        AutoGenerateColumns=false Font-Names="Verdana" runat="server" ShowFooter=false
                                        OnPageIndexChanging="GridView2_PageIndexChanging" GridLines="Horizontal, Vertical"                                                                     
                                        BorderStyle=Double BorderColor="#0083C1">
                                        <RowStyle BackColor="Gainsboro" />
                                        <AlternatingRowStyle BackColor="White" />
                                        <HeaderStyle BackColor="#0083C1" ForeColor="White"/>
                                        <FooterStyle BackColor="White" />
                                        <Columns>                                            
                                            <asp:TemplateField HeaderText="Идентификатор" SortExpression="ShipName">
                                                <ItemTemplate><%# Eval("item")%></ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Имя" SortExpression="Freight">
                                                <ItemTemplate><%# Eval("name")%></ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Количество" SortExpression="Freight">
                                                <ItemTemplate><%# Eval("counts")%></ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                   </asp:GridView>
                                </div>
                             </td>
                        </tr>
			        </ItemTemplate>			       
			    </asp:TemplateField>			    
			</Columns>
        </asp:GridView>

         <asp:SqlDataSource ID="AccessDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:gaizigan_5ConnectionString %>" 
        SelectCommand="SELECT * FROM Orders
           WHERE (Orders.store = 2)"   
        UpdateCommand= "UPDATE Orders SET isDelivered = @isDelivered, comments = @comments
         FROM Orders INNER JOIN OrderedItem ON Orders.id = OrderedItem.orders WHERE (OrderedItem.orders = @orders)">
                <SelectParameters>
            <asp:Parameter DefaultValue="2" Name="storeID" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="isDelivered" />
            <asp:Parameter Name="comments" />
            <asp:Parameter Name="orders" />
        </UpdateParameters>
    </asp:SqlDataSource>  
</asp:Content>


using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Web.Security;
using System.Configuration;

public partial class store1_store1 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void chkLinked_CheckedChanged(Object sender, EventArgs args)
    {
        System.Diagnostics.Debug.WriteLine("SomeText");
        // get the checkbox reference
        CheckBox chk = (CheckBox)sender;
        // get the GridViewRow reference
        GridViewRow row = (GridViewRow)chk.NamingContainer;
        // assuming the primary key value is stored in a hiddenfield with ID="HiddenID"
        Label hiddenID = (Label)row.FindControl("lblid");

        string sql = "UPDATE Orders SET isDelivered = " + (chk.Checked == true ? "1" : "0") + " WHERE id = " + hiddenID.Text;

        SqlDataSource sqlDataSource = new SqlDataSource();
        sqlDataSource.ConnectionString = ConfigurationManager.ConnectionStrings["gaizigan_5ConnectionString"].ConnectionString;
        sqlDataSource.UpdateCommand = sql;
        sqlDataSource.Update();
    }

    #region Variables
    string gvUniqueID = String.Empty;
    int gvNewPageIndex = 0;
    int gvEditIndex = -1;
    string gvSortExpr = String.Empty;
    private string gvSortDir
    {

        get { return ViewState["SortDirection"] as string ?? "ASC"; }

        set { ViewState["SortDirection"] = value; }

    }
    #endregion

    //This procedure returns the Sort Direction
    private string GetSortDirection()
    {
        switch (gvSortDir)
        {
            case "ASC":
                gvSortDir = "DESC";
                break;

            case "DESC":
                gvSortDir = "ASC";
                break;
        }
        return gvSortDir;
    }

    //This procedure prepares the query to bind the child GridView
    private SqlDataSource ChildDataSource(string strCustometId, string strSort)
    {
        
        string strQRY = "";
       // strQRY = "SELECT * FROM OrderedItem WHERE orders = " + strCustometId + strSort;
        strQRY = "SELECT OrderedItem.orders, OrderedItem.item, Item.name, OrderedItem.counts FROM OrderedItem  INNER JOIN Item ON OrderedItem.orders = " + strCustometId + "AND OrderedItem.item = Item.id" + strSort;
        //SELECT OrderedItem.orders, Item.name, OrderedItem.counts, Orders.buyerPhone, Orders.destination, Orders.deliveringTimeTo, Orders.isDelivered, Orders.comments 
        //  FROM OrderedItem
        //  INNER JOIN Orders ON OrderedItem.orders = Orders.id 
        //  INNER JOIN Item ON OrderedItem.item = Item.id WHERE (Orders.store = @storeID) 
        SqlDataSource sqlDataSource = new SqlDataSource();
        sqlDataSource.ConnectionString = ConfigurationManager.ConnectionStrings["gaizigan_5ConnectionString"].ConnectionString;
   
        sqlDataSource.SelectCommand = strQRY;

        return sqlDataSource;
         
    }

    #region GridView1 Event Handlers
    //This event occurs for each row
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        GridViewRow row = e.Row;
        string strSort = string.Empty;

        // Make sure we aren't in header/footer rows
        if (row.DataItem == null)
        {
            return;
        }

        //Find Child GridView control
        GridView gv = new GridView();
        gv = (GridView)row.FindControl("GridView2");

        //Check if any additional conditions (Paging, Sorting, Editing, etc) to be applied on child GridView
        if (gv.UniqueID == gvUniqueID)
        {
            gv.PageIndex = gvNewPageIndex;
            gv.EditIndex = gvEditIndex;
            //Check if Sorting used
            if (gvSortExpr != string.Empty)
            {
                GetSortDirection();
                strSort = " ORDER BY " + string.Format("{0} {1}", gvSortExpr, gvSortDir);
            }
            //Expand the Child grid
            ClientScript.RegisterStartupScript(GetType(), "Expand", "<SCRIPT LANGUAGE='javascript'>expandcollapse('div" + ((DataRowView)e.Row.DataItem)["id"].ToString() + "','one');</script>");
        }

        //Prepare the query for Child GridView by passing the Customer ID of the parent row
        gv.DataSource = ChildDataSource(((DataRowView)e.Row.DataItem)["id"].ToString(), strSort);
        gv.DataBind();
    }

    //This event occurs on click of the Update button
    protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        //Get the values stored in the text boxes
       // string strCompanyName = ((TextBox)GridView1.Rows[e.RowIndex].FindControl("txtCompanyName")).Text;
       // string strContactName = ((TextBox)GridView1.Rows[e.RowIndex].FindControl("txtContactName")).Text;
       // string strContactTitle = ((TextBox)GridView1.Rows[e.RowIndex].FindControl("txtContactTitle")).Text;
       // string strAddress = ((TextBox)GridView1.Rows[e.RowIndex].FindControl("txtAddress")).Text;
        string strid = ((Label)GridView1.Rows[e.RowIndex].FindControl("lblid")).Text;
        string strComment = ((TextBox)GridView1.Rows[e.RowIndex].FindControl("txtComments")).Text;
        try
        {
            //Prepare the Update Command of the DataSource control
            string strSQL = "";
            strSQL = "UPDATE Orders set comments = " + "'" + strComment + "'" +
                     " WHERE id = '" + strid + "'";
            AccessDataSource1.UpdateCommand = strSQL;
            AccessDataSource1.Update();
           // ClientScript.RegisterStartupScript(GetType(), "Message", "<SCRIPT LANGUAGE='javascript'>alert('Обновление записи прошло успешно');</script>");
        }
        catch { }
    }

    //This event occurs after RowUpdating to catch any constraints while updating
    protected void GridView1_RowUpdated(object sender, GridViewUpdatedEventArgs e)
    {
        //Check if there is any exception while deleting
        if (e.Exception != null)
        {
            ClientScript.RegisterStartupScript(GetType(), "Message", "<SCRIPT LANGUAGE='javascript'>alert('" + e.Exception.Message.ToString().Replace("'", "") + "');</script>");
            e.ExceptionHandled = true;
        }
    }

    //This event occurs on click of the Delete button
    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        //Get the value        
        string strid = ((Label)GridView1.Rows[e.RowIndex].FindControl("lblid")).Text;

        //Prepare the delete Command of the DataSource control
        string strSQL = "";

        try
        {
            strSQL = "DELETE from Customers WHERE id = '" + strid + "'";
            AccessDataSource1.DeleteCommand = strSQL;
            AccessDataSource1.Delete();
            ClientScript.RegisterStartupScript(GetType(), "Message", "<SCRIPT LANGUAGE='javascript'>alert('Customer deleted successfully');</script>");
        }
        catch { }
    }

    //This event occurs after RowDeleting to catch any constraints while deleting
    protected void GridView1_RowDeleted(object sender, GridViewDeletedEventArgs e)
    {
        //Check if there is any exception while deleting
        if (e.Exception != null)
        {
            ClientScript.RegisterStartupScript(GetType(), "Message", "<SCRIPT LANGUAGE='javascript'>alert('" + e.Exception.Message.ToString().Replace("'", "") + "');</script>");
            e.ExceptionHandled = true;
        }
    }
    #endregion

    #region GridView2 Event Handlers

    protected void GridView2_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView gvTemp = (GridView)sender;
        gvUniqueID = gvTemp.UniqueID;
        gvNewPageIndex = e.NewPageIndex;
        GridView1.DataBind();
    }  


    protected void GridView2_Sorting(object sender, GridViewSortEventArgs e)
    {
        GridView gvTemp = (GridView)sender;
        gvUniqueID = gvTemp.UniqueID;
        gvSortExpr = e.SortExpression;
        GridView1.DataBind();
    }
    #endregion
}
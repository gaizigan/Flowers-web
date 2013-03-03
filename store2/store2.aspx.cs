using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Diagnostics;

public partial class store2_store2 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void checkedDelivery(Object sender, EventArgs args)
    {
        var rowIndex = ((GridViewRow)((Control)sender).Parent.Parent).DataItemIndex;

        Debug.WriteLine(rowIndex.ToString());
    }
}
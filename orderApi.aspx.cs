using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections.Specialized;
using System.Net;
using System.IO;
using System.Web.Script.Serialization;
using System.Globalization;

public class OrderObject
{
    public List<OrderedItemObject> orderedItems { get; set; }
    public string buyerPhone { get; set; }
    public string destinationAddress { get; set; }
    public string deliveringtime { get; set; }
    public string store { get; set; }
}

public class OrderedItemObject
{
    public string itemServerId { get; set; }
    public string itemCount { get; set; }
}


public partial class orderApi : System.Web.UI.Page
{
    public override void ProcessRequest(HttpContext context)
    {
        System.IO.StreamReader reader = new System.IO.StreamReader(context.Request.InputStream);
        string requestFromPost = "";
        Char[] read = new Char[256];
        // Reads 256 characters at a time.     
        int count = reader.Read(read, 0, 256);
        while (count > 0)
        {
            // Dumps the 256 characters on a string and displays the string to the console.
            String str = new String(read, 0, count);
            requestFromPost += str;
            count = reader.Read(read, 0, 256);
        }
        
        if (requestFromPost.Length > 0)
        {
            OrderObject order = new JavaScriptSerializer().Deserialize<OrderObject>(requestFromPost);
            // Получили из JSON распарсенный объект
            if (order != null)
            {
                var dataContext = DBContext.context;
                Order someOrder = new Order();
                decimal result;
                if (decimal.TryParse(order.buyerPhone, out result))
                    someOrder.buyerPhone = result;
                    // you have a valid decimal to do as you please, no exception.
                else
                {
                    context.Response.Write("Something went wrong");
                    return;
                    // uh-oh.  error message time!
                }
                someOrder.destination = order.destinationAddress;

               // someOrder.deliveringTimeTo = Convert.ToDateTime(order.deliveringtime);
                CultureInfo provider = CultureInfo.InvariantCulture;
                var dt = DateTime.ParseExact(order.deliveringtime, "dd/MM/yyyy HH:mm", provider);
                someOrder.deliveringTimeTo = dt;

                someOrder.store = Convert.ToInt32(order.store);
                dataContext.Orders.InsertOnSubmit(someOrder);
                dataContext.SubmitChanges();
                foreach (var oItem in order.orderedItems)
                {
                    int itemID = Convert.ToInt32(oItem.itemServerId);
                    Item searchedItem = dataContext.Items.First(s => s.id == itemID);
                    if (searchedItem != null)
                    {
                        OrderedItem someOrderedItem = new OrderedItem();
                        someOrderedItem.item = searchedItem.id;
                        someOrderedItem.counts = Convert.ToInt32(oItem.itemCount);
                        someOrderedItem.orders = someOrder.id;
                        dataContext.OrderedItems.InsertOnSubmit(someOrderedItem);
                    }
                }
                dataContext.SubmitChanges();
                context.Response.Write("Succsessful added new order!");
            }
            else
            {
                context.Response.Write("Something went wrong");
            }
        }
        else
        {
            context.Response.Write("Something went wrong");
        }
    }
}
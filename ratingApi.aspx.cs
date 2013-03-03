using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections.Specialized;

public partial class ratingApi : System.Web.UI.Page
{
    public override void ProcessRequest(HttpContext context)
    {
        string itemId = "";
        string newRating = "";
        NameValueCollection pColl = context.Request.Params;
        for (int i = 0; i <= pColl.Count - 1; i++)
        {
            if (pColl.GetKey(i) == "itemID")
            {
                itemId = pColl.Get("itemID");
            }
            if (pColl.GetKey(i) == "newRating")
            {
                newRating = pColl.Get("newRating");
            } 
        }
        if (itemId.Length > 0 && newRating.Length > 0)
        {
            //Давай все получил, заноси данные в базу
            foreach (Item itm in DBContext.context.Items.Where(item => item.id == Convert.ToInt32(itemId)))
            {
                int newRatingInt = Convert.ToInt32(newRating);
                if (itm.ratingCount == null)
                    itm.ratingCount = 1;
                decimal? powering = itm.rating * itm.ratingCount;
                decimal? plusNewRating = powering + newRatingInt;
                decimal? resultPlusOne = itm.ratingCount + 1;
                decimal? newNewRating = plusNewRating / resultPlusOne;
                int soTheNewRating = (int)Math.Round(newNewRating.Value);
                itm.rating = soTheNewRating;
                itm.ratingCount++;
            }
            context.Response.Write("Succsessful rating update!");
        }
        else 
            context.Response.Write("Error when getting rating info");
    }

}
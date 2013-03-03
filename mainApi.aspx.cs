using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;

public class CityObject
{    
    public string id { get; set; }
    public string name { get; set; }
    public string localizedName { get; set; }
    public List<StoreObject> stores { get; set; }
}

public class StoreObject
{
    public string id { get; set; }
    public string deliveryCost { get; set; }
    public string phone { get; set; }
}


public partial class mainApi : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        var method = Request.QueryString["method"];
        int cityId = Convert.ToInt32(Request.QueryString["cityId"]);
        int groupId = Convert.ToInt32(Request.QueryString["groupId"]);
        int itemId = Convert.ToInt32(Request.QueryString["itemId"]);
        var serializer = new JavaScriptSerializer();//Инициализация

        if (method == "getCities")
        {
            var allCities = "[";
            foreach (City c in DBContext.context.Cities)
            {

                CityObject newCityObject = new CityObject { id = c.id.ToString(), name = c.name, localizedName = c.localizedName, stores = new List<StoreObject> { } };
                foreach (Store s in c.Stores)
                {
                    newCityObject.stores.Add(new StoreObject { id = s.id.ToString(), deliveryCost = s.deliveryCost.ToString(), phone = s.phone.ToString() });
                }
                string jsonResult = serializer.Serialize(newCityObject);
                allCities += jsonResult + ", ";
            }
            allCities = allCities.Substring(0, allCities.Length - 2);
            allCities += "]";
            Response.Write(allCities);
        }
        else if (method == "getGroups")
        {
            if (cityId != 0)
            {
                var allGroups = "[";
                foreach (CityGroup cg in DBContext.context.CityGroups)
                {
                    if (cg.city == cityId)
                    {
                        Group group = cg.Group;
                        string jsonResult = serializer.Serialize(new { group.id, group.name, group.localizedName});//Сериализация
                        allGroups += jsonResult + ", ";
                    }
                }
                if (allGroups.Length > 16)
                {
                    allGroups = allGroups.Substring(0, allGroups.Length - 2);
                    allGroups += "]";
                    Response.Write(allGroups);
                }
                else
                {
                    Response.Write("No such Groups");
                }
            }
        }
        else if (method == "getItems")
        {
            if (cityId != 0 && groupId != 0)
            {
                var allItems = "[";
                foreach (Item itm in DBContext.context.Items.Where(item => item.Store1.city == cityId && item.groups == groupId))
                {
                    Image firstImage;
                    string jsonResult;
                    if (itm.Images.Count > 0)
                    {
                        firstImage = itm.Images[0];
                        jsonResult = serializer.Serialize(new { itm.id, itm.name, itm.rating, itm.ratingCount, itm.price, firstImageId = firstImage.id, firstImageFilePath = firstImage.fileName });//Сериализация
                    }
                    else
                    {
                        jsonResult = serializer.Serialize(new { itm.id, itm.name, itm.rating, itm.ratingCount, itm.price });//Сериализация
                    }
                    allItems += jsonResult + ", ";
                }
                if (allItems.Length > 15)
                {
                    allItems = allItems.Substring(0, allItems.Length - 2);
                    allItems += "]";
                    Response.Write(allItems);
                }
                else
                {
                    Response.Write("No such Items");
                }
            }
            else
            {
                Response.Write("Wrong city or group IDs");
            }
        }
        else if (method == "getItemImages")
        {
            if (itemId != 0)
            {
                var allItemImages = "[";
                foreach (Item itm in DBContext.context.Items.Where(item => item.id == itemId))
                {
                    string jsonResult;
                    foreach (Image img in itm.Images)
                    {
                        jsonResult = serializer.Serialize(new { img.id, img.fileName });//Сериализация
                        allItemImages += jsonResult + ", ";
                    }

                }
                if (allItemImages.Length > 15)
                {
                    allItemImages = allItemImages.Substring(0, allItemImages.Length - 2);
                    allItemImages += "]";
                    Response.Write(allItemImages);
                }
                else
                {
                    Response.Write("No such Items");
                }
            }
        }
        else
        {
            Response.Write("Error. Wrong method name");
        }
        //var citysList = DBContext.context.Cities.Select(c => c);
        //  var serializer = new JavaScriptSerializer();//Инициализация
        //  var s = from c in DBContext.context.Cities
        //            select c;
        //    foreach (var c in s)
        //    {
        //       string jsonResult = serializer.Serialize(DBContext.context);//Сериализация
        //       Response.Write(jsonResult + "\n");
        //    }        
    } 
}
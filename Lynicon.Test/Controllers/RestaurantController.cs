﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Lynicon.Test.Models;

namespace Lynicon.Test.Controllers
{
    public class RestaurantController : Controller
    {
        //
        // GET: /Header/

        public ActionResult Index(RestaurantContent data)
        {
            return View(data);
        }

    }
}
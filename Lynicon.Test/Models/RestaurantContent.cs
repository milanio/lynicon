﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.Routing;
using Lynicon.Attributes;
using Lynicon.Collation;
using Lynicon.Models;
using Lynicon.Relations;
using Lynicon.Utility;
using Newtonsoft.Json;

namespace Lynicon.Test.Models
{
    public class RestaurantSummary : Summary
    {
        public Image MainImage { get; set; }
        [UIHint("Multiline")]
        public string Intro { get; set; }

        public RestaurantSummary()
        {
            BaseContent.InitialiseProperties(this);
        }
    }

    public class RestaurantContent : PageContent
    {
        public RestaurantSummary Summary { get; set; }
        [UIHint("Html")]
        public string Description { get; set; }
        [UIHint("ReferenceSelect")]
        public Reference<ChefContent> Chef { get; set; }
        public List<Reference> Tags { get; set; }

        private ChefContent chefFull = null;

        [JsonIgnore, ScaffoldColumn(false)]
        public string ChefBiography
        {
            get
            {
                if (chefFull == null)
                    chefFull = Collator.Instance.GetReferenced<ChefContent>(new List<Reference> { Chef }).FirstOrDefault().Value;
                return chefFull.Biography;
            }
        }

        public RestaurantContent()
        {
            BaseContent.InitialiseProperties(this);
        }
    }
}
# to be used in unit testing and command line testing
# was in spec/support but rails command line could not load the module...
module FakePage
  def getRace()
    @html = <<ENDHTML
    <html xmlns="http://www.w3.org/1999/xhtml"> 
    <head> 
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/> 
      <title>RACE | fitness | exercise bikes </title>
        <meta name="description" content="RACE"/> 
        <meta name="keywords" content="upright bike cycle trainer cycling racing indoor spinner spin spinning free inside delivery"/>     
        <meta name="layout" content="fitness"/>
    </head> 
    <body> 
    <div id="container"> 
    <div id="header"> 
    <div class="navTop">
      <ul>
        <li> <a class="kettlerusa"  href="http://www.kettlerusa.com/" > Kettler USA </a> </li>
        <li> <a href="http://www.kettlerusa.com/bikes" title="KETTLER BIKES online sales for buy, bikes, online, touring, commuter, folding, bike, bicycles home"> bicycles </a> </li>
        <li> <a href="http://www.kettlerusa.com/fitness" class="active" title="KETTLER FITNESS online sales for exercise, equipment, buy, crosstrainers, treadmills, ellipticals, bikes, rowers, recumbent home"> fitness </a> </li>
        <li> <a href="http://www.kettlerusa.com/patio-furniture" title="KETTLER PATIO online sales for buy, patio, furniture, sets, backyard, deck, outdoor home"> patio </a> </li>
        <li> <a href="http://www.kettlerusa.com/table-tennis" title="KETTLER TABLE TENNIS online sales for table tennis, tables, ping pong, paddles, balls, accessories, indoor, outdoor home"> table tennis </a> </li>
        <li> <a href="http://www.kettlerusa.com/toys" title="KETTLER TOYS online sales for buy, toys, online, swing sets, balance bikes, tricycles, ride on, scooters, pedal powered home"> toys </a> </li>
      </ul>
      <div id="loginSearchCart"> 
        <div id="loginAndSearch"> 
                  <a href="/register/register.gsp?division=fitness" title="Click to create a Kettler account. Note you can auto-register during checkout">Register</a>
                  <a href="/register/login.gsp?division=fitness" title="Click to log in to your Kettler account with your email and password">Login</a>
          <br/>
              <form action="/shop/search" method="post" name="searchForm" id="searchForm" >
                  <input type="hidden" name="division" value="fitness"/>
                  <input type="hidden" name="mode" value=""/>
                  <input type="text" id="where" name="where" size="11" title="Key search words such as tricycle or elliptical"/> 
                  <input type="submit" name="search" value="Search" title="Click to search" />
              </form>
        </div>
        <div class="cart"> 
              <a href="/shop/cart?division=fitness" title="Click to view your shopping cart details">Cart</a>
              <br/>
                  <div id="miniCart"></div>
        </div>
      </div>
    </div>
      <div id="eightHundred">888.253.8853</div>
            <div class="navSecond"> 
        <ul>
          <li><a id="crosstrainers"    href="http://www.kettlerusa.com/fitness/crosstrainers" title="Buy Elliptical Machines & Cross Trainers Online | Kettler USA">crosstrainers</a></li>
          <li><a id="exercisebikes"    href="http://www.kettlerusa.com/fitness/exercise-bikes"  title="Exercise Bikes | Stationary Bikes, Recumbents & More | Kettler USA">exercise bikes</a></li>
                <li><a id="rowers"    href="http://www.kettlerusa.com/fitness/rowers"  title="Buy Rowers Online | Rowing Machines from Kettler USA">rowers</a></li>
          <li><a id="treadmills"    href="http://www.kettlerusa.com/fitness/treadmills"  title="Shop the Best Treadmills online including Folding Treadmills | Kettler USA">treadmills</a></li>
          <li><a id="more"    href="http://www.kettlerusa.com/fitness/more" class="" title="Bike Accessories | Bike Bags, Panniers, Bike Stands & More | Kettler USA">more</a></li>
                    <li><a id="closeouts" class="closeouts lastMenuItem"    href="http://www.kettlerusa.com/fitness/closeouts"  title="close out items">specials</a></li>
        </ul>
        <span id="socialLinks">
      <a href="http://twitter.com/#!/kettler_usa"><img src="http://www.kettlerusa.com/images/twitter24x24.png" class="socialmedia"></img></a>
      <a href="https://www.facebook.com/kettlerusa"><img src="http://www.kettlerusa.com/images/facebook24x24.png" class="socialmedia"></img></a>
      <a href="http://www.youtube.com/user/KETTLERUSA"><img src="http://www.kettlerusa.com/images/youtube24x24.png" class="socialmedia"></img></a>
    </span>
            </div> 
        </div> 
    <div id="main"> 
        <div id="buy">
            <div id="otherImages">  
                    <div>
                        <a>
                           <img class="otherImage" id="7938-189.A" 
                                src="/images/fitness/exercise bikes/7938-189.A.jpg" 
                                alt="RACE" title="RACE"/>
                        </a>
                    </div>
                <div>
                    <a><img class="otherImage" id="7938-189" src="/images/fitness/exercise bikes/7938-189.jpg" alt="RACE other image" title="RACE" /></a>
                </div>
            </div>
            <div id="mainImage">
                <div id="mainImageImg">
    <h1>RACE</h1>
    <img id="dynaMainImage" src="/images/fitness/exercise bikes/7938-189.jpg" alt="RACE" title="RACE" />
    <a href="#" id="largerImageLink">Larger Image</a>
                </div>
                    <div id="divAfter">
                            <form action="/locate/index" method="post" name="locate" id="locate" >
                                    <br/>
                                    <a href="/dealer/webDealers?division=fitness&amp;itemId=2761" class="button">
                                      Where to Buy
                                    </a>
                                    <br/>
                                    <br/>
                            </form>
                <div id="fb-root"></div>
                <div id="likeFacebook" class="iLike">
                <div class="fb-like" data-send="false" data-layout="button_count" data-width="100" data-show-faces="true"></div>
                </div>
                            <form action="/shop/buy" method="post" name="buyForm" id="buyForm" >
                                <input type="hidden" name="division" value="fitness"/>
                                            <input type="hidden" name="id" value="2761" id="id" />
                                            <dl>
                                                    <dt>Price:</dt>
                                                    <dd>$1,499.00</dd>
                                            </dl>
                                   <dl id="framesizeQty">
                                        <dt>Quantity:</dt><dd><input type="text" name="quantity" class="number" value="1" tabindex="1" id="quantity" />
                                                          </dd>
                                   </dl>
                                   <input type="submit" name="buy" id="buyId" value="Add to Cart" class="button" /><br/>
                                   <span class="emphasis">free</span>
                                        Truck Shipping and Inside Delivery
                                        <a href="#" id="questionTruckShipping"><img src="/images/question16x16.png"  /></a> 
                                      <br/><span class="fineprint">(Usually arrives in 4-10 business days)</span> 
                            </form>
                    </div>
            </div>
            <div id="largerImage"></div>
            <div id="tabs">
                <ul>
                    <li><a href="#features"><span>Features</span></a></li>
                    <li><a href="#specifications"><span>Specifications</span></a></li>
                    <li><a href="#partsAndService"><span>Parts and Service</span></a></li>
                        <li><a href="#accessories2" id="accessoriesLink"><span>Accessories</span></a></li>
                </ul>
                <div id="features">
                      <!-- 7938-189 -->
    <p>The new RACE upright cycling trainer is designed to appeal to avid cyclists as well as those seeking serious athletic training.</p>
    <li>blah</li>
    <li>blah blah</li>
                </div>
                <div id="specifications">
                   <dl>
                       <dt>Item No:</dt><dd>7938-189</dd>
                       <dt>Description:</dt><dd>RACE</dd>
                           <dt>Country of Origin:</dt><dd>Germany</dd>
                           <dt>Setup Length/Width/Height:</dt><dd>52 x 21 x 50 inches</dd>
                           <dt>Setup Weight:</dt><dd>135 lbs</dd>
                           <dt>Package Length/Width/Height:</dt><dd>45 x 43 x 13 inches</dd>
                           <dt>Package Weight:</dt><dd>145.2 lbs</dd>
                           <dt>Residential Warranty:</dt><dd>3 YEAR</dd>
                           <dt>Weight Limit:</dt><dd>285 lbs</dd>
                           <dt>Assembly Required:</dt><dd>Yes</dd>
                           <dt>Ship Via:</dt><dd>Truck</dd>
                    </dl>
                </div>
                <div id="partsAndService">
                    <ul class="pdf">
                            <li><a class="pdf" href="/manuals/fitness/exercise bikes/7938-189.A.pdf">
                                  Computer Manual 
                                </a>
                            </li>
                            <li><a class="pdf" href="/manuals/fitness/exercise bikes/7938-189.pdf">
                                  Assembly Manual 
                                </a>
                            </li>
                    </ul>
                   <dl>
                       <dt>Phone:</dt><dd>866.804.0440 Monday thru Friday 9:00 a.m. to 4:30 p.m. EST</dd>
                       <dt>Fax:</dt><dd>757.563.9273</dd>
                       <dt>email:</dt><dd>parts@kettlerusa.com</dd>
                    </dl>
                </div>
                    <div id="accessories2"></div>
            </div>
        </div> 
      <ul id="footer"> 
                   <li><a href="/homePage/termsAndConditions?division=fitness">Terms &amp; Conditions</a></li>
                <li><a href="/shop/archives?division=fitness">Archive Items</a></li>
            <li><a href="/homePage/contactUs.gsp?mode=">Contact Us</a></li>
           <li><a href="http://www.kettlerusa.com/warranty" title="Register Warranty">Register Warranty</a></li>
             <li><a href="http://www.kettlerusa.com/contract?mode=contract" title="Go to Kettler Contract">Kettler Contract</a></li>
             <li><a href="http://www.kettlerusa.com/?mode=canada" title="Go to Kettler Canada">Kettler Canada</a></li>
                <li class="lastItem">
                  <a id="whereToBuy" class="lastMenuItem" title="Click to see where to buy"
                      href="/homePage/pickWhereToBuyDiv"
                  >
                    Where To Buy
                  </a>
                </li>
        <li id="copyright" class="lastItem"> 
            &copy; 2012 Kettler
          </li>
      </ul>
    </div> 
    </div> 
    </body>
    </html>
ENDHTML
  end

  # http://bags.bcoutlet.com/product/tignanello/multi-pocket-organizer-crossbody/130799/p/1338439
  def getBcOutlet()
    @html =  <<ENDHTML
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/strict.dtd">

<html>
    <head id="ctl00_ctl00_pageHeader"><title>
	Handbags, luggage, Backpacks & More at BCO
</title><meta name="robots" content="noindex,nofollow" />
        <script src="/JavaScript/jquery-1.3.2.min.js" language="JavaScript" type="text/javascript"></script>
        <script src="/JavaScript/ajaxManager.min.js" language="javascript" type="text/javascript"></script>
        <script src="/JavaScript/eBags.min.js" language="javascript" type="text/javascript"></script>
        <script src="/JavaScript/eBagsAutoFill.js" language="javascript" type="text/javascript"></script>
        <link type="text/css" rel="stylesheet" href="/Sites/master.css" /><title>
	Plus Size Clothing &#124; Clearance Plus Size Women & Men &#124; Clearance Home Decor &#124; Bargain Catalog Outlet
</title><meta name="keywords" content="women's apparel, women's clothing, shopping, plus size, petite clothes, clearance, clothes, clothing catalog, prom dress, bathing suit, bikini, blazers, bob mackie, boots, bridal, bridal dress, catalog shopping,lane bryant, jessica london, roaman's, brylane home, woman within, casual shoes, dress shoes, coats, dress, evening dress, evening gown, fancy dress, formal dress, free catalog, jackets,denim, leather,leather boots,leather coat,leather jacket, liquidation, pierre cardin, real comfort, bagatelle, adolfo studio, pants, party dress, sale apparel, sandals, shirt, shoes, short skirt, skirt, sweater, swim wear, swimsuit, t-shirt, trousers, handbag, bags" /><meta name="description" content="BCO&amp;reg; has plus size women's and men's fashions at deep dicount prices. Visit our outlet for big deals ,bigsavings on brands from Woman Wothin, Roamans, Jessica london and King size. We also offer Home products at deep discounts. Big deals,big savings!" /><meta name="language" content="com, es" /><meta name="author" content="BCoutlet.com" />

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<meta http-equiv="X-UA-Compatible" content="IE9=EmulateIE8" />
<link href="http://www.bcoutlet.com/styles/1024_master_77437.ChmCss" rel="stylesheet" type="text/css" />   
<link href="http://www.bcoutlet.com/Microsite/FixCssFile.aspx?cssPath=/styles/1024_certona.css" rel="Stylesheet" type="text/css" /> 
<script type="text/javascript" src="http://www.bcoutlet.com/Scripts/jquery-1.7.min.js"></script>
<script src="http://www.bcoutlet.com/scripts/global.js" type="text/javascript"></script> 
<script src="http://www.bcoutlet.com/scripts/cookies_script.js" type="text/javascript"></script> 
<!--[if gte 7 ]
        <script type="text/javascript" src="http://www.bcoutlet.com/Scripts/IE7JS/IE9.js"></script>
        <script type="text/javascript" src="http://www.bcoutlet.com/Scripts/IE7JS/ie7-squish.js"></script>
<![endif]-->

<script type="text/javascript" src="http://www.bcoutlet.com/Scripts/ABTesting.js"></script>
<script type="text/javascript" src="http://www.bcoutlet.com/Scripts/mbox.js"></script>
<script type="text/javascript" src="http://www.bcoutlet.com/SiteAnalytics/Omniture/Development/s_code.js"></script>
 
  
  
  
    <script type="text/javascript" src="http://www.bcoutlet.com/Scripts/HeaderInit.js"></script>
    <script type="text/javascript">
        var elm=document.getElementById('deptid_9367Active');
        if(elm) {elm.style.display="none";}
    </script> 
  
  
 
    <link rel="canonical" href="http://www.bargaincatalogoutlet.com" />
<!-- MAXCHMB BCO_AffiliateTracking_Header -->
        <!-- MAXCHME BCO_AffiliateTracking_Header  -->
        <script type="text/javascript" src="http://www.bcoutlet.com/Scripts/newZoom.js"></script>
        
   
        <script type="text/javascript" src="http://www.bcoutlet.com/Scripts/swatch-control.js"></script>
        <script type="text/javascript" src="http://www.bcoutlet.com/Scripts/jQuery/jquery.hoverIntent.js"></script>     
    
<script type="text/javascript" src="http://www.bcoutlet.com/Scripts/Microsite.js"></script>
<script type="text/javascript">var _runningFromMicrosite = true;</script>
<link href="/Sites/BCOutlet/designer/site.css" rel="stylesheet" type="text/css" /><link href="/Sites/BCOutlet/designer/favicon.ico" rel="shortcut icon" type="image/x-icon" /><link href="/Sites/BCOutlet/designer/favicon.ico" rel="icon" type="image/x-icon" /><meta name="server" content="Assembly BuildVersion: 12.7.178.0" /><meta name="server" content="Server Name: bags.bcoutlet.com" /></head>
    <body id="ctl00_ctl00_mstrBodyTag" Onload="body_Onload();">
    <div class="mainSiteContent" id="ctl00_Header1">
    <form name="aspnetForm" method="post" action="ControlWrapper.aspx?controlName=Header" id="aspnetForm">
<input type="hidden" name="__VIEWSTATE" id="__VIEWSTATE" value="/wEPDwULLTE3NzI5ODg3NzlkZKMJcNJATBAaEtulMz8qqyI9ovJk" />

        <div id="controlWrapper">
            

<script type="text/javascript">
    if(typeof(_runningFromMicrosite) == "undefined") { this.SetVendorCookie("vendor"); }
</script>



<script type="text/javascript">
    var BaseURL = 'http://www.bcoutlet.com/'
</script>

<input type="hidden" value='0' id="hdnTopDeptId" />

<!-- MAXCHMB BCO_Header_Top --><!-- From Cache CHM3 ContentId: 79330 --><div class="bco-header-top">
        <div class="header-tabs">
            <a class="bco-tab" href="http://www.bcoutlet.com/"><em>Bargain Catalog Outlet</em></a>
            <a class="osp-tab" href="http://www.onestopplus.com/?affiliate_id=018&affiliate_location_id=01"><em>OneStopPlus.com</em></a>
        </div>

        <a class="items-in-cart removeIf openBag" href="http://www.bcoutlet.com/shopping_bag/shoppingbag.aspx">Shopping Bag <span id="ShoppingBagCount">(0)</span></a>

    </div><!-- MAXCHME BCO_Header_Top  -->

<!-- MAXCHMB BCO_Header_Main -->
    <script type="text/javascript">
        // delay before calling search auto-complete service - required!
        var autoCompleteDelay = 300;

        // default text for search and email sign-up boxes - required!
        var product_search_default_text = "Ex: Blue Blouse";
        var catalog_search_default_text = "Ex: 1311-509-186";
        var email_default_text = "First-time registrants only";
    </script> 

    <div class="bco-header-main">
        <a class="header-logo" href="http://www.bcoutlet.com/"><em>Return to BCO home page</em></a>
        
        <div class="account-options">
            <span class="account-message">
                <a href="http://www.bcoutlet.com/account/acct_main.aspx">Sign in</a> or 
                <a href="http://www.bcoutlet.com/account/acct_createprofile.aspx?ReturnUrl=/account/acct_main.aspx">Register</a>
            </span>
            <a href="http://www.bcoutlet.com/Account/Acct_Main.aspx">My Account</a>
            <a href="http://www.bcoutlet.com/Account/Guest_OrderStatus.aspx">Order Status</a>
            <a href="http://www.bcoutlet.com/Catalog/email_cat_pref_loggedin.aspx">Email/Catalog Request</a>
            <a href="http://www.bcoutlet.com/Help/Help.aspx">Customer Service</a>
        </div>

        <div class="email-sign-up">
            <div>
                <label for="ChamEmail"><em>Sign up for emails and get a coupon in your inbox for FREE SHIPPING!</em></label>
                <input id="ChamEmail" type="text" />
                <a id="ChamEmailSend"><em>Go</em></a>
            </div>
			<span id="ChamEmailResult"></span>
            <span id="ChamEmailError"></span>
        </div>

        <div class="search">
            <div class="product-search">
                <label for="product-search-field"><em>Product Search</em></label>
     	        <input type="text" maxlength="250" id="product-search-field" autocomplete="off" />
     	        <a id="product-search-button" class="go"><em>Go</em></a>
                <div class="search-suggestions"></div>
            </div>

            <div class="catalog-search">
                <label for="catalog-search-field"><em>Catalog Search</em></label>
                <input type="text" maxlength="250" id="catalog-search-field" autocomplete="off" />
     	        <a id="catalog-search-button" class="go"><em>Go</em></a>
            </div>
        </div>
    </div>
<!-- MAXCHME BCO_Header_Main  -->

<!-- MAXCHMB BCO_Header_Nav --><!-- From Cache CHM3 ContentId: 79329 --><ul class="bco-header-nav">
	<li class="dept-13847" menu="two-columns"><a href="http://www.bcoutlet.com/Discount-WOMENS-PLUS-SIZE.aspx?DeptId=13847"><em>Women's Plus Size</em></a></li>
	<li class="dept-13893"><a href="http://www.bcoutlet.com/Discount-MENS-BIG-and-TALL.aspx?DeptId=13893"><em>Men's Big &amp; Tall</em></a></li>
	<li class="dept-19145"><a href="http://www.bcoutlet.com/Discount-OUTLET-EXCLUSIVES.aspx?DeptId=19145"><em>Outlet Exclusives</em></a></li>
	<li class="dept-13869"><a href="http://www.bcoutlet.com/Discount-Shoes.aspx?DeptId=13869"><em>Shoes</em></a></li>
	<li class="dept-13924"><a href="http://www.bcoutlet.com/Discount-FOR-THE-HOME.aspx?DeptId=13924"><em>Home</em></a></li>
	<li class="dept-18379" menu="two-columns"><a href="http://www.bcoutlet.com/Discount-999-and-Under.aspx?DeptId=18379"><em>9.99 &amp; Under</em></a></li>
	<li class="dept-14941"><a href="http://www.bcoutlet.com/Discount-Recently-Reduced.aspx?DeptId=14941"><em>Recently Reduced</em></a></li>
	<li class="dept-ebags"><a href="http://bags.bcoutlet.com/"><em>Handbags &amp; More</em></a></li>
	<li class="dept-pbj"><a href="http://pbj.bcoutlet.com/"><em>Jewelry &amp; Fragrances</em></a></li>
	<li class="dept-13842"><a href="http://www.bcoutlet.com/Discount-Womens-Plus-Size.aspx?DeptId=16364"><em>What's New</em></a></li>
</ul><!-- MAXCHME BCO_Header_Nav  -->

<!-- MAXCHMB BCO_Header_Bottom -->
<!-- MAXCHME BCO_Header_Bottom  -->

<script type="text/javascript"> InitHeader(); </script>



        </div><!-- end container div -->
    </form>
    </div>
        <div id="ebagsBodyContent">
        <form name="eBagsForm" method="post" action="/product/tignanello/multi-pocket-organizer-crossbody/130799/p/1338439" id="eBagsForm">
<div>
<input type="hidden" name="__EVENTTARGET" id="__EVENTTARGET" value="" />
<input type="hidden" name="__EVENTARGUMENT" id="__EVENTARGUMENT" value="" />
<input type="hidden" name="__LASTFOCUS" id="__LASTFOCUS" value="" />
<input type="hidden" name="__VSTATE" id="__VSTATE" value="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" />
<input type="hidden" name="__VIEWSTATE" id="__VIEWSTATE" value="" />
</div>

<script type="text/javascript">
//<![CDATA[
var theForm = document.forms['eBagsForm'];
if (!theForm) {
    theForm = document.eBagsForm;
}
function __doPostBack(eventTarget, eventArgument) {
    if (!theForm.onsubmit || (theForm.onsubmit() != false)) {
        theForm.__EVENTTARGET.value = eventTarget;
        theForm.__EVENTARGUMENT.value = eventArgument;
        theForm.submit();
    }
}
//]]>
</script>


<script src="/WebResource.axd?d=Fns5NeV4DmOL0YJuWktqGGwbmvUDwd_x_y7d7Pw5BswZamRcDJ6UZ-w00ODoiNGh65nUj5G-z1tbmFAn4e7aAtqqoYg1&amp;t=634635937977110726" type="text/javascript"></script>


<script src="/WebResource.axd?d=8MN_zG0aLpseEA1_ErWYQIxRyiBwC-ZqFgNahcwFn2jIvPSgz2oEj3NWF1L8xtBhxNUyh_C6YTLk5uo1ozteXs2AFTlimjZKIwtb8GfaqPvbaIaR58IKqSDBN_7aWrfpddl_C7CYOfTG5qG0uD99kx1cCLeQkC7PS63J_aPvj8kIjtpy0&amp;t=634683806940000000" type="text/javascript"></script>
<script src="/Javascript/jquery.validate.min.js" type="text/javascript"></script>
<script type="text/javascript">
//<![CDATA[
var heroImageUrl = '//cdn1.ebags.com/is/image/im9/130799_3_1?resmode=4&op_usm=1,1,1,&qlt=95,1&hei=280&wid=280';//]]>
</script>

<script src="/ScriptResource.axd?d=YTSDL1b_5joNAMHNSA7ooj5kUgBrCmpaUgEtPRIXalkbAa8hjc42cehpA4exLXyinpq9BsAARL4SzZkKUVKdMls02ZgbHuWdnIskCjnrbED9QsoZe9jsS_oU0kXhxU-UPzrkeJ3FiETiq0qeZuZ_e4rlPtI1&amp;t=ffffffff940d030f" type="text/javascript"></script>
<script src="/ScriptResource.axd?d=PrZ1gRgesA7FtDDq22BxskMISFaGxZ1FvE-N9p1QjycG0NpzVcu4UGThfffMV-GyRysxjRc8v4ReIwuExywoIv1MF6T6VY0Rjk-znBJu5K9i3bgARCzGc3DEGEEIzXcTH3IUgHlT-P8G0fvlm_w1bqtQWlg7BQbSfQ9btah4QegVuLo10&amp;t=ffffffff940d030f" type="text/javascript"></script>
<div>

	<input type="hidden" name="__EVENTVALIDATION" id="__EVENTVALIDATION" value="/wEWDQL+raDpAgKgkPLZBQKG29/ACwKHiLGsDAKOxOiQCAL/5PCNDALiwojFAwLKt4yRDgLDqfnqCwKDuNy3CQKZ3t2/AQLh0/KuDQKh1tLiDwBujv4PLDtxIY77l3vDFEcfvfXk" />
</div>
        <script type="text/javascript">
//<![CDATA[
Sys.WebForms.PageRequestManager._initialize('ctl00$ctl00$ScriptManager1', 'eBagsForm', ['tctl00$ctl00$cphRedcatsPage$cphLayout$upnlProductDetail',''], [], [], 90, 'ctl00$ctl00');
//]]>
</script>

                <div id="ebagsMainWrap">
    <div id="ebagsTopMenuWrap"> 
        <ul id="ebagsTopMenu"> 
            <li><a href="/search/search-results/?N=70014">Handbags</a></li> 
            <li><a href="/search/search-results/?N=70018">Luggage</a></li> 
            <li><a href="/search/search-results/?N=7005">Business &amp; Laptop</a></li> 
            <li><a href="/search/search-results/?N=7002">Backpacks</a></li> 
            <li><a href="/search/search-results/?N=70026">Travel Accessories</a></li> 
        </ul> 
    </div><!-- / ebagsTopMenuWrap -->

    <div id="ebagsSearchWrap">
        <div id="ebagsSearch"><span>Search</span><input name="ctl00$ctl00$cphRedcatsPage$_ucSearchBox$_txtSearch" type="text" value="Handbags, Totes, Laptop bags" maxlength="50" id="ctl00_ctl00_cphRedcatsPage__ucSearchBox__txtSearch" class="searchfield" AUTOCOMPLETE="off" onfocus="if (this.value === &#39;Handbags, Totes, Laptop bags&#39;) { this.value = &#39;&#39;; }" onkeyup="CleanInvalidSearchBoxCharacters(ctl00_ctl00_cphRedcatsPage__ucSearchBox__txtSearch);" />
<input name="ctl00$ctl00$cphRedcatsPage$_ucSearchBox$DummyTextBoxThatMakesSubmitOnEnterWorkInIE" type="text" id="ctl00_ctl00_cphRedcatsPage__ucSearchBox_DummyTextBoxThatMakesSubmitOnEnterWorkInIE" style="visibility:hidden;display:none;" />  
<input type="image" name="ctl00$ctl00$cphRedcatsPage$_ucSearchBox$_imgbtnSearch" id="ctl00_ctl00_cphRedcatsPage__ucSearchBox__imgbtnSearch" class="searchbutton" src="//cdn2.ebags.com/images/btn-Search-BCOutlet.gif" style="border-width:0px;" />
<div id="divAutoCompleteTermList" class="autoCompleteContainer" style="display: block;"></div>
<script language="javascript" type="text/javascript">
    eBags.autoFill("#ctl00_ctl00_cphRedcatsPage__ucSearchBox__txtSearch", {
        formSelector: '#eBagsForm',
        ajaxUrl: '/WebService/SearchAutoComplete.asmx/GetAutoSuggestionsForSearch',
        resultCount: 10, 
        containerSelector: '#divAutoCompleteTermList',
        submitButton: '#ctl00_ctl00_cphRedcatsPage__ucSearchBox__imgbtnSearch'
    }
    );

    function CleanInvalidSearchBoxCharacters(searchBox) {
        var matchPattern = /[\{\}\'\v\t\r\n\f\+\*\\\|<>=~;]/g;
        var matchedValues = searchBox.value.match(matchPattern);

        if (matchedValues != null) {
            searchBox.value = searchBox.value.replace(matchPattern, "");
        }
    }
</script>

</div>
        <div id="ebagsLogo"><a href="/home/"><img src="//cdn2.ebags.com/images/partner/redcats/btn-ebags.png" width="139" height="37" alt="Powered by eBags" border="0" /></a></div>
    </div>
    <div id="ebagsMainContent">
         
    <div id="ebagsDetailWrap">
		

<div id="ebagsErrorMessage">
	<ul id="lstMessages">
		
	</ul>
</div>

		<div id="ctl00_ctl00_cphRedcatsPage_cphLayout_upnlProductDetail">
	
                <h1>Tignanello Multi Pocket Organizer Crossbody</h1>
                <div><div id="ctl00_ctl00_cphRedcatsPage_cphLayout_UcBreadcrumbs__pnlTopBreadcrumb">
		
    <h2></h2>
    <div id="ebagsBreadcrumb">
        
    </div>

	</div>
</div>
        
                <div id="ebagsDetailImageWrap">
    	            <!-- ******************* Display when user clicks add to cart button ******************* -->
                    
                    
<div id="ebagsDetailImage">
    <img id="ctl00_ctl00_cphRedcatsPage_cphLayout_UcMainImageViewer__imgStaticMainImage" src="//cdn1.ebags.com/is/image/im9/130799_3_1?resmode=4&amp;op_usm=1,1,1,&amp;qlt=95,1&amp;hei=280&amp;wid=280" style="height:280px;width:280px;border-width:0px;" />
</div>
<script language="javascript" type="text/javascript">
    function SwapHeroImage(ipsid,folder) {
        var heroImage = $get('ctl00_ctl00_cphRedcatsPage_cphLayout_UcMainImageViewer__imgStaticMainImage');
        heroImage.src = GetImage(ipsid, folder);
        return false;    
    }

    function ResetHeroImage() {
        var heroImage = $get('ctl00_ctl00_cphRedcatsPage_cphLayout_UcMainImageViewer__imgStaticMainImage');
        heroImage.src = heroImageUrl;
        return false;
    }

    function SetHeroImage(ipsid, folder) {
        heroImageUrl = GetImage(ipsid, folder);
        return false;
    }
    
    function GetImage(ipsid, folder)
    {
        return '//cdn1.ebags.com/is/image/im' + folder + '/' + ipsid + '?resmode=4&op_usm=1,1,1,&qlt=95,1&hei=280&wid=280';
    }
</script>

                    <div id="ebagsClickZoom">
                        <a id="ctl00_ctl00_cphRedcatsPage_cphLayout_lnkZoom" href="/product/product-zoom?modelid=130799&amp;selectedIpsId=130799_3_1" target="ProductDetailZoom" onclick="javascript:window.open(&#39;/product/product-zoom?modelid=130799&amp;selectedIpsId=130799_3_1&#39;, &#39;ProductDetailZoom&#39;, &#39;height=615,width=665,menubar=no,toolbar=no,location=no,directories=no,status=no,resizable=yes,scrollbars=no&#39;);return false;">Click to Zoom</a>
                    </div>
                    <div id="ctl00_ctl00_cphRedcatsPage_cphLayout_UcProductImage__pnlFeaturePhotos">
		
    
            <div id="ebagsThumbWrap" class="ebagsThumbWrap">
        
            <div class="ebagsThumb">
                <a id="ctl00_ctl00_cphRedcatsPage_cphLayout_UcProductImage__rptFeaturePhotos_ctl01__imgbtnFeatureImageLink" onmouseover="javascript: SwapHeroImage(&#39;130799_1_2&#39;,&#39;9&#39;);" onmouseout="javascript: SwapHeroImage(&#39;130799_3_1&#39;,&#39;9&#39;);" href="javascript: void(0);" style="display:inline-block;border-style:None;"><img id="ctl00_ctl00_cphRedcatsPage_cphLayout_UcProductImage__rptFeaturePhotos_ctl01__imgbtnFeaturePhotoImage" title="FeaturePhotoAltText" src="//cdn1.ebags.com/is/image/im9/130799_1_2?resmode=4&amp;op_usm=1,1,1,&amp;qlt=95,1&amp;hei=50&amp;wid=50" style="border-style:None;" /></a>
                <img id="ctl00_ctl00_cphRedcatsPage_cphLayout_UcProductImage__rptFeaturePhotos_ctl01__imgPreload" src="//cdn1.ebags.com/is/image/im9/130799_1_2?resmode=4&amp;op_usm=1,1,1,&amp;qlt=95,1&amp;hei=280&amp;wid=280" alt="Image 01" style="height:1px;width:1px;border-width:0px;display:none;" />
            </div>
        
            <div class="ebagsThumb">
                <a id="ctl00_ctl00_cphRedcatsPage_cphLayout_UcProductImage__rptFeaturePhotos_ctl02__imgbtnFeatureImageLink" onmouseover="javascript: SwapHeroImage(&#39;130799_1_3&#39;,&#39;9&#39;);" onmouseout="javascript: SwapHeroImage(&#39;130799_3_1&#39;,&#39;9&#39;);" href="javascript: void(0);" style="display:inline-block;border-style:None;"><img id="ctl00_ctl00_cphRedcatsPage_cphLayout_UcProductImage__rptFeaturePhotos_ctl02__imgbtnFeaturePhotoImage" title="FeaturePhotoAltText" src="//cdn1.ebags.com/is/image/im9/130799_1_3?resmode=4&amp;op_usm=1,1,1,&amp;qlt=95,1&amp;hei=50&amp;wid=50" style="border-style:None;" /></a>
                <img id="ctl00_ctl00_cphRedcatsPage_cphLayout_UcProductImage__rptFeaturePhotos_ctl02__imgPreload" src="//cdn1.ebags.com/is/image/im9/130799_1_3?resmode=4&amp;op_usm=1,1,1,&amp;qlt=95,1&amp;hei=280&amp;wid=280" alt="Image 01" style="height:1px;width:1px;border-width:0px;display:none;" />
            </div>
        
            <div class="ebagsThumb">
                <a id="ctl00_ctl00_cphRedcatsPage_cphLayout_UcProductImage__rptFeaturePhotos_ctl03__imgbtnFeatureImageLink" onmouseover="javascript: SwapHeroImage(&#39;130799_1_4&#39;,&#39;9&#39;);" onmouseout="javascript: SwapHeroImage(&#39;130799_3_1&#39;,&#39;9&#39;);" href="javascript: void(0);" style="display:inline-block;border-style:None;"><img id="ctl00_ctl00_cphRedcatsPage_cphLayout_UcProductImage__rptFeaturePhotos_ctl03__imgbtnFeaturePhotoImage" title="FeaturePhotoAltText" src="//cdn1.ebags.com/is/image/im9/130799_1_4?resmode=4&amp;op_usm=1,1,1,&amp;qlt=95,1&amp;hei=50&amp;wid=50" style="border-style:None;" /></a>
                <img id="ctl00_ctl00_cphRedcatsPage_cphLayout_UcProductImage__rptFeaturePhotos_ctl03__imgPreload" src="//cdn1.ebags.com/is/image/im9/130799_1_4?resmode=4&amp;op_usm=1,1,1,&amp;qlt=95,1&amp;hei=280&amp;wid=280" alt="Image 01" style="height:1px;width:1px;border-width:0px;display:none;" />
            </div>
        
            </div><!-- /ebagsThumbWrap -->
        

	</div>

                </div><!-- ebagsDetailImageWrap -->
                <div id="ebagsDetailProdInfoWrap">
                    
    <!-- Full Retail Line -->
    
    <!-- eBags Price Line -->
    
        <div id="ebagsPrice">
            <span id="ctl00_ctl00_cphRedcatsPage_cphLayout_UcPriceDisplay_lblNormalPriceLabelCaption">Our Price:</span><span id="ctl00_ctl00_cphRedcatsPage_cphLayout_UcPriceDisplay_spnNormalPrice" class="priceBold">
                <span id="ctl00_ctl00_cphRedcatsPage_cphLayout_UcPriceDisplay_lblNormalPrice">$89.00</span>
            </span><span id="ctl00_ctl00_cphRedcatsPage_cphLayout_UcPriceDisplay_lblNormalPricePercentageOff" class="priceRed"></span>
        </div>
    
    <p>&nbsp;</p>


                     
        <div id="priceForModelGroup">Available Colors at $89.00</div>
        
                <div id="ebagsThumbWrap" class="ebagsThumbWrap">
            
                <div id="ctl00_ctl00_cphRedcatsPage_cphLayout_UcColorSelect_rptModelPriceGroup_ctl00_rptProductSwatches_ctl01_ebagsThumb" class="ebagsThumb" onmouseover="javascript: SwapHeroImage(&#39;130799_3_1&#39;,&#39;9&#39;);" onmouseout="javascript: ResetHeroImage();" onmousedown="javascript: SetHeroImage(&#39;130799_3_1&#39;,&#39;9&#39;);">
                    <a id="ctl00_ctl00_cphRedcatsPage_cphLayout_UcColorSelect_rptModelPriceGroup_ctl00_rptProductSwatches_ctl01_lnkbtnSwatchImage" title="Honey" Color="Honey" href="javascript:__doPostBack(&#39;ctl00$ctl00$cphRedcatsPage$cphLayout$UcColorSelect$rptModelPriceGroup$ctl00$rptProductSwatches$ctl01$lnkbtnSwatchImage&#39;,&#39;&#39;)"><img id="ctl00_ctl00_cphRedcatsPage_cphLayout_UcColorSelect_rptModelPriceGroup_ctl00_rptProductSwatches_ctl01_lnkbtnImage" src="//cdn1.ebags.com/is/image/im9/130799_3_1?resmode=4&amp;op_usm=1,1,1,&amp;qlt=95,1&amp;hei=50&amp;wid=50" style="border-width:0px;" /></a>
                </div><img id="ctl00_ctl00_cphRedcatsPage_cphLayout_UcColorSelect_rptModelPriceGroup_ctl00_rptProductSwatches_ctl01__imgPreload" src="//cdn1.ebags.com/is/image/im9/130799_3_1?resmode=4&amp;op_usm=1,1,1,&amp;qlt=95,1&amp;hei=280&amp;wid=280" alt="Image 01" style="height:1px;width:1px;border-width:0px;display:none;" />
            
                </div><!-- /ebagsThumbWrap -->
            
    
        <div id="priceForModelGroup">Clearance at $69.99</div>
        
                <div id="ebagsThumbWrap" class="ebagsThumbWrap">
            
                <div id="ctl00_ctl00_cphRedcatsPage_cphLayout_UcColorSelect_rptModelPriceGroup_ctl01_rptProductSwatches_ctl01_ebagsThumb" class="ebagsThumb" onmouseover="javascript: SwapHeroImage(&#39;130799_6_1&#39;,&#39;9&#39;);" onmouseout="javascript: ResetHeroImage();" onmousedown="javascript: SetHeroImage(&#39;130799_6_1&#39;,&#39;9&#39;);">
                    <a id="ctl00_ctl00_cphRedcatsPage_cphLayout_UcColorSelect_rptModelPriceGroup_ctl01_rptProductSwatches_ctl01_lnkbtnSwatchImage" title="White" Color="White" href="javascript:__doPostBack(&#39;ctl00$ctl00$cphRedcatsPage$cphLayout$UcColorSelect$rptModelPriceGroup$ctl01$rptProductSwatches$ctl01$lnkbtnSwatchImage&#39;,&#39;&#39;)"><img id="ctl00_ctl00_cphRedcatsPage_cphLayout_UcColorSelect_rptModelPriceGroup_ctl01_rptProductSwatches_ctl01_lnkbtnImage" src="//cdn1.ebags.com/is/image/im9/130799_6_1?resmode=4&amp;op_usm=1,1,1,&amp;qlt=95,1&amp;hei=50&amp;wid=50" style="border-width:0px;" /></a>
                </div><img id="ctl00_ctl00_cphRedcatsPage_cphLayout_UcColorSelect_rptModelPriceGroup_ctl01_rptProductSwatches_ctl01__imgPreload" src="//cdn1.ebags.com/is/image/im9/130799_6_1?resmode=4&amp;op_usm=1,1,1,&amp;qlt=95,1&amp;hei=280&amp;wid=280" alt="Image 01" style="height:1px;width:1px;border-width:0px;display:none;" />
            
                <div id="ctl00_ctl00_cphRedcatsPage_cphLayout_UcColorSelect_rptModelPriceGroup_ctl01_rptProductSwatches_ctl02_ebagsThumb" class="ebagsThumb" onmouseover="javascript: SwapHeroImage(&#39;130799_11_1&#39;,&#39;9&#39;);" onmouseout="javascript: ResetHeroImage();" onmousedown="javascript: SetHeroImage(&#39;130799_11_1&#39;,&#39;9&#39;);">
                    <a id="ctl00_ctl00_cphRedcatsPage_cphLayout_UcColorSelect_rptModelPriceGroup_ctl01_rptProductSwatches_ctl02_lnkbtnSwatchImage" title="Glam Red" Color="Glam Red" href="javascript:__doPostBack(&#39;ctl00$ctl00$cphRedcatsPage$cphLayout$UcColorSelect$rptModelPriceGroup$ctl01$rptProductSwatches$ctl02$lnkbtnSwatchImage&#39;,&#39;&#39;)"><img id="ctl00_ctl00_cphRedcatsPage_cphLayout_UcColorSelect_rptModelPriceGroup_ctl01_rptProductSwatches_ctl02_lnkbtnImage" src="//cdn1.ebags.com/is/image/im9/130799_11_1?resmode=4&amp;op_usm=1,1,1,&amp;qlt=95,1&amp;hei=50&amp;wid=50" style="border-width:0px;" /></a>
                </div><img id="ctl00_ctl00_cphRedcatsPage_cphLayout_UcColorSelect_rptModelPriceGroup_ctl01_rptProductSwatches_ctl02__imgPreload" src="//cdn1.ebags.com/is/image/im9/130799_11_1?resmode=4&amp;op_usm=1,1,1,&amp;qlt=95,1&amp;hei=280&amp;wid=280" alt="Image 01" style="height:1px;width:1px;border-width:0px;display:none;" />
            
                </div><!-- /ebagsThumbWrap -->
            
    
<div id="ebagsColorSelect">
    <span>
        Select a color
    </span>
    <div><select name="ctl00$ctl00$cphRedcatsPage$cphLayout$UcColorSelect$_ddlProductColor" onchange="javascript:setTimeout(&#39;__doPostBack(\&#39;ctl00$ctl00$cphRedcatsPage$cphLayout$UcColorSelect$_ddlProductColor\&#39;,\&#39;\&#39;)&#39;, 0)" id="ctl00_ctl00_cphRedcatsPage_cphLayout_UcColorSelect__ddlProductColor" style="font-size:11px;">
		<option selected="selected" value="Honey">Honey $89.00</option>
		<option value="White">White $69.99</option>
		<option value="Glam Red">Glam Red $69.99</option>

	</select></div>
</div>

                    
<div id="ebagsQuantity">
    <span>Quantity</span>
    <input name="ctl00$ctl00$cphRedcatsPage$cphLayout$UcAddToCartButton$txtQuantity" type="text" value="1" maxlength="2" id="ctl00_ctl00_cphRedcatsPage_cphLayout_UcAddToCartButton_txtQuantity" style="width:40px;" />
</div>
<div id="ebagsAddtoCart">
    <a id="ctl00_ctl00_cphRedcatsPage_cphLayout_UcAddToCartButton_lnkButtonAddToCart" title="Add Tignanello Multi Pocket Organizer Crossbody to cart" href="javascript:__doPostBack(&#39;ctl00$ctl00$cphRedcatsPage$cphLayout$UcAddToCartButton$lnkButtonAddToCart&#39;,&#39;&#39;)"><img id="ctl00_ctl00_cphRedcatsPage_cphLayout_UcAddToCartButton_imgAddToCart" src="//cdn2.ebags.com/Images/btn-AddToCart-BCOutlet.gif" style="border-width:0px;" /></a>
    <strong></strong>
</div>    
<script type="text/javascript">
    eBags(function() {
        jQuery('form#eBagsForm').validate({
            errorElement: "li",
            invalidHandler: function(frm, validator) {
                if (validator.numberOfInvalids() > 0) {
                    jQuery('#ebagsErrorMessage').fadeIn('normal');
                }
            },
            errorLabelContainer: jQuery('#lstMessages'),
            onfocusout: false,
            onkeyup: false,
            onsubmit: false
        });

        jQuery('#ctl00_ctl00_cphRedcatsPage_cphLayout_UcAddToCartButton_txtQuantity').rules('add', {
            required: true,
            range: [1, 40],
            messages:
            {
                required: 'Quantity is required.',
                range: 'Quantity must be between 1 and 40.' 
            }
        });

        // keep search from causing error
        jQuery('#ctl00_ctl00_cphRedcatsPage_cphLayout_UcAddToCartButton_lnkButtonAddToCart').click(function() {
            return jQuery('form#eBagsForm').valid();
        });

        if ($.trim(jQuery('#lstMessages').text()).length > 0) {
            jQuery('#ebagsErrorMessage').show();
        }
    });
</script>

                    <div id="ebagsBrandImage">
                        <img id="ctl00_ctl00_cphRedcatsPage_cphLayout_imgBrand" src="//cdn2.ebags.com/img/logos/logo_43.gif" style="border-width:0px;" />
                    </div>
                    <div id="ebagsProdDescription">
                        <p></p>
                    </div>
                    <ul id="ebagsDetailDim">
                        <li>
                            <em></em>
                            <span></span>
                        </li>
                        <li>
                            <em>Size:</em>
                            <span>8" x 8" x 1"</span>
                        </li>
                        <li>
                            <em>Weight:</em>
                            <span>0.75 lbs</span>
                        </li>
                        <li>
                            <em>Material:</em>
                            <span>Leather</span>
                        </li>
                        <li>
                            <em>Warranty:</em>
                            <span>30 days against manufacturer's defects</span>
                        </li>
                        <li>
                            <em>Linear inches:</em>
                            <span>17"</span>
                        </li>
                    </ul>
                    
<div id="ebagsProdFeatures">
    <h2>Product Features</h2>
    
            <ul>
        
            <li>
                Top zipper closure
            </li>
        
            <li>
                Interior lining
            </li>
        
            <li>
                Two interior slide pockets
            </li>
        
            <li>
                Back wall zipper pocket
            </li>
        
            <li>
                Shoulder strap with a 23.5 inch drop length and a 50 inch strap length
            </li>
        
            <li>
                Front exterior cell phone pocket
            </li>
        
            <li>
                Front exterior zipper pocket
            </li>
        
            <li>
                Back exterior zipper compartment that has: 12 card slots, clear i.d. slot, zipper pocket
            </li>
        
</div>

                </div><!-- ebagsDetailProdInfoWrap -->
            
</div>
        
<div id="ebagsRightCertonaWrap">
    <h3>You May Also Like</h3>
    <div id="edetail">
        
                <div class="ebagsRightCertona">
                    <a id="ctl00_ctl00_cphRedcatsPage_cphLayout_rightCertonaRecommender__dataListRecommender_ctl00__hyperLink" href="/product/ebags/packing-cubes-3pc-set/13032/p/949922"><img id="ctl00_ctl00_cphRedcatsPage_cphLayout_rightCertonaRecommender__dataListRecommender_ctl00__imageSource" src="//cdn1.ebags.com/is/image/im2/13032_9_1?resmode=4&amp;op_usm=1,1,1,&amp;qlt=95,1&amp;hei=115&amp;wid=115&amp;align=0,1" style="border-width:0px;height:115px;width:115px;" />
                        <span class="ebagsBrand">eBags</span>
                        <span class="ebagsProdName">Packing Cubes - 3pc Set</span>
                        
<span class="ebagsWasPrice"></span>
<span class="ebagsPrice">$29.99</span>

</a>		
                </div>
            
                <div class="ebagsRightCertona">
                    <a id="ctl00_ctl00_cphRedcatsPage_cphLayout_rightCertonaRecommender__dataListRecommender_ctl01__hyperLink" href="/product/ebags/piazza-day-bag/94553/p/1318670"><img id="ctl00_ctl00_cphRedcatsPage_cphLayout_rightCertonaRecommender__dataListRecommender_ctl01__imageSource" src="//cdn1.ebags.com/is/image/im3/94553_8_1?resmode=4&amp;op_usm=1,1,1,&amp;qlt=95,1&amp;hei=115&amp;wid=115&amp;align=0,1" style="border-width:0px;height:115px;width:115px;" />
                        <span class="ebagsBrand">eBags</span>
                        <span class="ebagsProdName">Piazza Day Bag</span>
                        
<span class="ebagsWasPrice"></span>
<span class="ebagsPrice">$39.99</span>

</a>		
                </div>
            
                <div class="ebagsRightCertona">
                    <a id="ctl00_ctl00_cphRedcatsPage_cphLayout_rightCertonaRecommender__dataListRecommender_ctl02__hyperLink" href="/product/tignanello/zip-top-x-body-organizer/210996/p/10157105"><img id="ctl00_ctl00_cphRedcatsPage_cphLayout_rightCertonaRecommender__dataListRecommender_ctl02__imageSource" src="//cdn1.ebags.com/is/image/im6/210996_7_1?resmode=4&amp;op_usm=1,1,1,&amp;qlt=95,1&amp;hei=115&amp;wid=115&amp;align=0,1" style="border-width:0px;height:115px;width:115px;" />
                        <span class="ebagsBrand">Tignanello</span>
                        <span class="ebagsProdName">Item Zip Top Cross-Body Organizer</span>
                        
<span class="ebagsWasPrice">Was: $89.00</span>
<span class="ebagsPrice">Now: $69.99</span>

</a>		
                </div>
            
                <div class="ebagsRightCertona">
                    <a id="ctl00_ctl00_cphRedcatsPage_cphLayout_rightCertonaRecommender__dataListRecommender_ctl03__hyperLink" href="/product/ebags/villa-cross-body/204598/p/10109635"><img id="ctl00_ctl00_cphRedcatsPage_cphLayout_rightCertonaRecommender__dataListRecommender_ctl03__imageSource" src="//cdn1.ebags.com/is/image/im8/204598_5_1?resmode=4&amp;op_usm=1,1,1,&amp;qlt=95,1&amp;hei=115&amp;wid=115&amp;align=0,1" style="border-width:0px;height:115px;width:115px;" />
                        <span class="ebagsBrand">eBags</span>
                        <span class="ebagsProdName">Villa Cross Body</span>
                        
<span class="ebagsWasPrice"></span>
<span class="ebagsPrice">$29.99</span>

</a>		
                </div>
            
    </div>
</div>
        
<div id="ebagsBottomCertonaWrap">
    <h3>Customers Who Viewed This Also Viewed</h3>
    <div id="edetail_ai">
        
                <div class="ebagsBottomCertona">
                    <a id="ctl00_ctl00_cphRedcatsPage_cphLayout_bottomCertonaRecommender__dataListRecommender_ctl00__hyperLink" href="/product/baggallini/triple-zip-bagg/127324/p/1330217"><img id="ctl00_ctl00_cphRedcatsPage_cphLayout_bottomCertonaRecommender__dataListRecommender_ctl00__imageSource" src="//cdn1.ebags.com/is/image/im4/127324_6_1?resmode=4&amp;op_usm=1,1,1,&amp;qlt=95,1&amp;hei=115&amp;wid=115&amp;align=0,1" style="border-width:0px;height:115px;width:115px;" />
                        <span class="ebagsBrand">baggallini</span>
                        <span class="ebagsProdName">Triple Zip Bagg</span>
                        
<span class="ebagsWasPrice">Was: $39.95</span>
<span class="ebagsPrice">Now: $29.99</span>

</a>		
                </div>
            
                <div class="ebagsBottomCertona">
                    <a id="ctl00_ctl00_cphRedcatsPage_cphLayout_bottomCertonaRecommender__dataListRecommender_ctl01__hyperLink" href="/product/baggallini/sydney-bagg-silver-hardware/143936/p/10146856"><img id="ctl00_ctl00_cphRedcatsPage_cphLayout_bottomCertonaRecommender__dataListRecommender_ctl01__imageSource" src="//cdn1.ebags.com/is/image/im6/143936_12_1?resmode=4&amp;op_usm=1,1,1,&amp;qlt=95,1&amp;hei=115&amp;wid=115&amp;align=0,1" style="border-width:0px;height:115px;width:115px;" />
                        <span class="ebagsBrand">baggallini</span>
                        <span class="ebagsProdName">Sydney Bagg Silver Hardware</span>
                        
<span class="ebagsWasPrice">Was: $89.95</span>
<span class="ebagsPrice">Now: $69.99</span>

</a>		
                </div>
            
                <div class="ebagsBottomCertona">
                    <a id="ctl00_ctl00_cphRedcatsPage_cphLayout_bottomCertonaRecommender__dataListRecommender_ctl02__hyperLink" href="/product/the-sak/iris-crossbody/144187/p/10163431"><img id="ctl00_ctl00_cphRedcatsPage_cphLayout_bottomCertonaRecommender__dataListRecommender_ctl02__imageSource" src="//cdn1.ebags.com/is/image/im7/144187_21_1?resmode=4&amp;op_usm=1,1,1,&amp;qlt=95,1&amp;hei=115&amp;wid=115&amp;align=0,1" style="border-width:0px;height:115px;width:115px;" />
                        <span class="ebagsBrand">The Sak</span>
                        <span class="ebagsProdName">Iris Crossbody</span>
                        
<span class="ebagsWasPrice"></span>
<span class="ebagsPrice">$59.00</span>

</a>		
                </div>
            
                <div class="ebagsBottomCertona">
                    <a id="ctl00_ctl00_cphRedcatsPage_cphLayout_bottomCertonaRecommender__dataListRecommender_ctl03__hyperLink" href="/product/the-sak/iris-crossbody/144187/p/10002223"><img id="ctl00_ctl00_cphRedcatsPage_cphLayout_bottomCertonaRecommender__dataListRecommender_ctl03__imageSource" src="//cdn1.ebags.com/is/image/im7/144187_8_1?resmode=4&amp;op_usm=1,1,1,&amp;qlt=95,1&amp;hei=115&amp;wid=115&amp;align=0,1" style="border-width:0px;height:115px;width:115px;" />
                        <span class="ebagsBrand">The Sak</span>
                        <span class="ebagsProdName">Iris Crossbody</span>
                        
<span class="ebagsWasPrice"></span>
<span class="ebagsPrice">$59.00</span>

</a>		
                </div>
            
                <div class="ebagsBottomCertona">
                    <a id="ctl00_ctl00_cphRedcatsPage_cphLayout_bottomCertonaRecommender__dataListRecommender_ctl04__hyperLink" href="/product/relic/organizer-item/205691/p/10113174"><img id="ctl00_ctl00_cphRedcatsPage_cphLayout_bottomCertonaRecommender__dataListRecommender_ctl04__imageSource" src="//cdn1.ebags.com/is/image/im1/205691_3_1?resmode=4&amp;op_usm=1,1,1,&amp;qlt=95,1&amp;hei=115&amp;wid=115&amp;align=0,1" style="border-width:0px;height:115px;width:115px;" />
                        <span class="ebagsBrand">Relic</span>
                        <span class="ebagsProdName">Organizer Item</span>
                        
<span class="ebagsWasPrice"></span>
<span class="ebagsPrice">$48.00</span>

</a>		
                </div>
            
    </div>
</div>
    </div><!-- eBagsDetailWrap -->
        <input id="hidReload" type="hidden" value="initialvalue"/>
<script type="text/javascript">
    function body_Onload() {
        var hidReload = $get('hidReload');
        if (hidReload.value != "initialvalue") {
            window.navigate(document.location.href);
        } else {
            hidReload.value = "newvalue"
        }
    } 

</script>

    </div>
</div>
            <div style="margin:0;padding:0;clear:both;"></div>
        </form>
        </div>
        <div class="mainSiteContent" id="ctl00_Footer1">
    <form name="aspnetForm" method="post" action="ControlWrapper.aspx?controlName=Footer" id="aspnetForm">
<input type="hidden" name="__VIEWSTATE" id="__VIEWSTATE" value="/wEPDwULLTE3NzI5ODg3NzlkZKMJcNJATBAaEtulMz8qqyI9ovJk" />

        <div id="controlWrapper">
            

<div class="bco-footer">
    <!-- MAXCHMB BCO_Footer_Top --><!-- From Cache CHM3 ContentId: 79118 --><div class="communication">
            <ul class="social">
                <li><a class="facebook" href="https://www.facebook.com/pages/BCOutlet/111232588933342?sk=app_208195102528120"><em>Like us on Facebook</em></a></li>
                <li><a class="twitter" href="http://twitter.com/#!/BCOutlet"><em>Follow us on Twitter</em></a></li>
                <li><a class="blog" href="http://bcoutlet.blogspot.com/"><em>Plus size blog for women, men's big and tall. Let's talk. </em></a></li>

            </ul>

            <ul class="promotion">
                <li class="email-sign-up">
                    <p>
                        <span id="AsyncEmailResult"></span>
                        <span id="AsyncEmailError"></span>
                    </p>
                    <input id="AsyncEmail" type="text" />

                    <a id="AsyncEmailSend"><em>Go</em></a>
                </li>
                <li><a class="friend-referral" href="http://www.bcoutlet.com/account/referfriendlogin.aspx?ReturnUrl=/account/referafriend.aspx"><em>Refer a friend and get a $10 e-coupon each!</em></a></li>
                <li><a class="e-gift-cards" href="http://www.bcoutlet.com/Landing_Pages/GiftCardLandingPage.aspx"><em>E-gift cards. Give someone the perfect gift!</em></a></li>
            </ul>

            <div class="clear"></div>
        </div>

        <div class="footer-links">
            <ul>
                <li><h3>HELP</h3></li>
                <li><a href="http://www.bcoutlet.com/Help/Help.aspx">Customer Service</a></li>
                <li><a href="http://www.bcoutlet.com/Help/Help.aspx">(888) 355-3099</a></li>
                <li><a href="http://www.bcoutlet.com/Account/Acct_Login.aspx?ReturnUrl=/Account/Acct_Main.aspx">My Account</a></li>

                <li><a href="http://www.bcoutlet.com/Account/Guest_OrderStatus.aspx">Order Status</a></li>
                <li><a href="http://www.bcoutlet.com/Help/Help_billingpayment.aspx">Billing and Payment</a></li>
                <li><a href="http://www.bcoutlet.com/Help/Help_ShippingHandling.aspx">Shipping Information</a></li>
                <li><a href="http://www.bcoutlet.com/Help/Help_ReturnsExchanges.aspx">Return Center</a></li>
                <li><a href="http://www.bcoutlet.com/catalog/cat_unsub_not_loggedin.aspx">Catalog Unsubscribe</a></li>
                <li><a href="http://www.bcoutlet.com/Account/Email_Unsubscribe.aspx">E-mail Unsubscribe</a></li>

            </ul>

            <ul>
                <li><h3>ABOUT US</h3></li>
                <li><a href="http://www.bcoutlet.com/Help/Help_AboutUs.aspx">About BCOutlet.com</a></li>
                <li><a href="http://www.bcoutlet.com/ContactUs/ContactUs.aspx">Contact Us</a></li>
                <li><a href="http://www.bcoutlet.com/Help/PrivacySecurity.aspx">Privacy and Security</a></li>

                <li><a href="http://www.bcoutlet.com/Help/SecureShopping.aspx">Secure Shopping</a></li>
                <li><a href="https://www.connectcommerce.com/secure/partner_app.html?ccmid=K66088">Affiliate Network</a></li>
                <li><a href="http://www.redcats.com/eng#/eng/Talents">Careers</a></li>
            </ul>

            <ul>
                <li><h3>SHOPPING</h3></li>

                <li><a href="http://www.bcoutlet.com/Catalog/rdcts_brnd_main_no_lgin.aspx">Catalog Request</a></li>
                <li><a href="http://www.bcoutlet.com/Help/Help_SizeCharts.aspx">Size Charts</a></li>
                <li><a href="http://www.bcoutlet.com/Landing_Pages/GiftCardLandingPage.aspx">E-Gift Cards</a></li>
                <li><a href="http://www.bcoutlet.com/Product/ProductGlossaryDefault.aspx">Fashion Glossary</a></li>
            </ul>

            <ul>

                <li><h3>FAMILY BRANDS</h3></li>
                <li><a href="http://www.onestopplus.com/?affiliate_id=018&affiliate_location_id=02">OneStopPlus.com&reg;</a></li>
                <li><a href="http://www.womanwithin.com/?affiliate_id=018&affiliate_location_id=02">Woman Within&reg;</a></li>
                <li><a href="http://www.roamans.com/?affiliate_id=018&affiliate_location_id=02">Roaman's&reg;</a></li>
                <li><a href="http://www.jessicalondon.com/?affiliate_id=018&affiliate_location_id=02">Jessica London&reg;</a></li>
                <li><a href="http://www.kingsizedirect.com/?affiliate_id=018&affiliate_location_id=02">King Size Direct&reg;</a></li>

                <li><a href="http://www.brylanehome.com/?affiliate_id=018&affiliate_location_id=02">Brylane Home&reg;</a></li>
                <li><a href="http://www.fullbeauty.com/?affiliate_id=018&affiliate_location_id=02">fullbeauty.com&reg;</a></li>
            </ul>

            <ul class="partners">
                <li><a target="_blank" href="http://www.paypal.com"><img width="98" height="31" src="//secureimages.redcatsusa.com/images/site_images/bco/bnr_nowAccepting_98x31.png"></a></li>
                <li><a target="_blank" href="http://www.bizrate.com/ratings_guide/cust_reviews__mid--118151.html"><img align="top" width="125" border="0" height="73" alt="BizRate Customer Certified (GOLD) Site - Bargain Catalog Outlet Reviews at Bizrate" src="//medals.bizrate.com/medals/dynamic/118151_medal.gif" /></a></li>
                <li><img width="72" height="72" alt="UPS" src="//secureimages.redcatsusa.com/images/site_images/bco/cco_UPS_logo.gif"></li>

            </ul>

            <div class="clear"></div>
        </div><!-- MAXCHME BCO_Footer_Top  -->
        
     <!-- MAXCHMB BCO_Footer_Bottom --><!-- From Cache CHM3 ContentId: 83094 --><p class="copyright">*Here's how to redeem your promo code:<br />
        1. Place one or more eligible items in your Shopping Cart.<br />
        2. Type promo code <strong>BC16280</strong> into the Promotion Code Box, then click apply.<br />
        3. The $1.99 standard shipping charge will be automatically applied, if eligible*.<br />
        4. Continue shopping or begin checkout.<br />  <br />
        
        <strong>*Promo code restrictions:</strong> offer ends 11:59PM E.S.T. TUESDAY, 7/03/12. Heavy weight items may incur additional freight costs.  
        May not be redeemed for cash or combined with other offers. Not applicable to payment of bills or charges. Discount may not be applied to 
        prior purchases, or E-Gift cards. Limited to one offer per customer. 
<br /><br />
          
          Add BCOutlet@email.BCOutlet.com to your email address book and keep the deals coming!<br /> 
        Be the first to know about online deals and special promotions. <br /><br />
        
          <br /><br />Register with us to access all of our convenient site features!<a href="http://www.bcoutlet.com/Account/Acct_CreateProfile.aspx?mid=%%MASTER_PID%%">Click Here</a> It's fast, easy and secure. To reply to this email, please use our  <a href="http://www.bcoutlet.com/ContactUs/ContactUs.aspx?mid=%%MASTER_PID%%">Customer Contact Form.</a> ScanAlert(tm) Hacker Safe BCOutlet.com respects your privacy.<a href="https://www.scanalert.com/RatingVerify?ref=www.bcoutlet.com">Click Here</a> We Ship UPS(r) 
UPS and the UPS brandmark are registered trademarks used with permission by its owner, United Parcel Service of America, Inc. All rights reserved.To <a href="https://www.bcoutlet.com/Account/Email_Unsubscribe.aspx?mid=%%MASTER_PID%%">unsubscribe</a> from our email list Please read about our <a href="http://www.bcoutlet.com/Help/PrivacySecurity.aspx">Privacy Policy</a> and <a href="http://www.bcoutlet.com/Help/PrivacySecurity.aspx?mid=%%MASTER_PID%%">Terms of Use</a> (last updated on 4-11-11)  <a target="_blank" href="http://www.redcats.com/eng#/eng">&copy;2012 Redcats USA, L.P</a>. All Rights Reserved.
 </p><!-- MAXCHME BCO_Footer_Bottom  -->

    <!-- MAXCHMB BCO_AffiliateTracking_Footer --><!-- From Cache CHM3 ContentId: 75485 --><!--Start :: Google-->
<script type="text/javascript">
 var _gaq = _gaq || [];
				_gaq.push(['_setAccount', 'UA-18783293-1']);
				_gaq.push(['_trackPageview']);

				(function() {
					var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
					ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
					var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
				})();
</script>
<!--End :: Google-->

<!--Start :: Mercent-->
<script type="text/javascript" src="//cdn.mercent.com/js/tracker.js"></script>
<script type="text/javascript">
	mr_merchantID = "BCO";
	mr_Track();
</script>
<!--End:Mercent--><!-- MAXCHME BCO_AffiliateTracking_Footer  -->

    <!-- MAXCHMB BCO_Common_JavaScript -->
        <script type="text/javascript" src="http://www.bcoutlet.com/Scripts/ChameleonEmail.js"></script>

        <script type="text/javascript">
            $(document).ready(function () {
                FooterEmailSignUp();
            });

            function FooterEmailSignUp() {
                var footer_email_default = 'Enter email address';
                var footer_email_field = $('#AsyncEmail');
                footer_email_field.val(footer_email_default);

                footer_email_field.blur(function () {
                    if (footer_email_field.val() == '') { footer_email_field.val(footer_email_default); footer_email_field.css('color', '#999'); }
                }).focus(function () {
                    if (footer_email_field.val() == footer_email_default) { footer_email_field.val(''); footer_email_field.css('color', '#333'); }
                }).keypress(function (event) {
                    if (event.keyCode == '13') { event.preventDefault(); AsyncEmail(); }
                });

                $('#AsyncEmailSend').click(function () { AsyncEmail(); });
            }
        </script>
    <!-- MAXCHME BCO_Common_JavaScript  -->

    
 
</div>
 


        </div><!-- end container div -->
    </form>
    </div><script type="text/javascript" id="ctl00_Footer1_scripts">
repopulateFooterUIFromCookies("vendor", "ctl00_Footer1")


var ctl00_Footer1_replacementEntries = [
	{
		tagName:"a",
		matchCriteria:{ attribute:"id", value:"hlCreditCardInfo(1)?" },
		replacementFunction:"makeLinkAbsolute"
	},
	{
		tagName:"ul",
		matchCriteria:{ attribute:"id", value:"shopping" },
		replacementFunction:"fixFashionGlossary"
	},
	{
		tagName:"a",
		matchCriteria:{ attribute:"id", value:"lbtnEmailSignUp" },
		replacementFunction:"replaceEmailSignupButton"
	}
];
performClientSideContentReplacements("ctl00_Footer1", ctl00_Footer1_replacementEntries, "http://www.bcoutlet.com");
</script>

        <script type="text/javascript">
var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
</script>
<script type="text/javascript">
try {
var pageTracker = _gat._getTracker("UA-218344-11");
pageTracker._trackPageview();
} catch(err) {}</script>

        <!-- SiteCatalyst code version: H.11. Copyright 1997-2005 Omniture, Inc. More info available at http://www.omniture.com -->
<script language='JavaScript' src='http://www.bcoutlet.com/SiteAnalytics/Omniture/Production/s_code.js'></script>
<script language='JavaScript'><!--

if (typeof s != 'undefined') {
s.pageName = 'US:BCO:eBags:Product Page';
s.prop1 = 'USA';
s.prop2 = 'RedCats USA';
s.prop3 = 'Clearance';
s.prop5 = 'Bargain Catalog Outlet:eBags';
s.prop13 = '1338439(9)';
s.prop14 = '13032,94553,210996,204598,127324,143936,144187,144187,205691';
s.eVar1 = 'USA';
s.eVar2 = 'RedCats USA';
s.eVar3 = 'Clearance';
s.eVar5 = 'Bargain Catalog Outlet:eBags';
s.events = 'prodView';
s.products = ';1338439;;;;eVar12=Browse';

if (typeof GetSubCookieValue === 'function') {
var encMasterId = GetSubCookieValue('vendor.User', 'vendor.MasterId');
if (encMasterId != null) { s.prop10 = decode(encMasterId); }
}

/********** DO NOT ALTER ANYTHING ELSE BELOW THIS LINE! *************/
var s_code=s.t();if(s_code)document.write(s_code)//-->
}
</script>
<script language="JavaScript"><!--
if(navigator.appVersion.indexOf('MSIE')>=0)document.write(unescape('%3C')+'\!-'+'-')
//--></script>
<noscript><img src="//redcatsusabcoprod.122.207.net/b/ss/redcatsusabcoprod/1/H.1--NS/0" height="1" width="1" border="0" alt="" /></noscript><!--/DO NOT REMOVE/-->
<!-- End SiteCatalyst code version: H.1. -->

        <!-- Resonance code resxclsa.js v2.x Copyright 2004-2008 Certona Corporation www.certona.com -->
<script language='JavaScript'><!--

var resx = new Object();
resx.appid = 'bcoutlet';
resx.top1 = '100000';
resx.top2 = '100000';
resx.lkmatch = '/skuid%3D\d+|modelid%3D\d+|\/p\/\d+/i';
resx.rrelem = 'edetail;edetail_ai;';
resx.rrnum = '4;5;';
resx.pageid = 'res12062006809351026457432';
resx.event = 'eproduct';
resx.itemid = '1338439';
</script>
<script language='JavaScript' src='/Javascript/Certona/resxclsa.js'></script>
<!-- Resonance -->

    </body>
</html>
ENDHTML
  end
  def getBloomingdales()
    @html = <<ENDHTML
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-us" lang="en-us" xmlns:og='http://ogp.me/ns#' xmlns:fb='http://www.facebook.com/2008/fbml'>
<head>
<title>Theodora &amp; Callum Flats - Primaballet with Ankle Strap | Bloomingdale&#039;s</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" /> 
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta property="og:title" content="Theodora & Callum Flats - Primaballet with Ankle Strap | Bloomingdale's" />
<meta property="og:type" content="product" />
<meta property="og:url" content="http://www1.bloomingdales.com/shop/product/theodora-callum-flats-primaballet-with-ankle-strap?ID=596838&cm_mmc=FrPL-_-fb-_-n-_-n" />
<meta property="og:image" content="http://images.bloomingdales.com/is/image/BLM/products/4/optimized/1281004_fpx.tif?wid=325&amp;qlt=90,0&amp;layer=comp&amp;op_sharpen=0&amp;resMode=sharp2&amp;op_usm=0.7,1.0,0.5,0&amp;fmt=jpeg" />
<meta property="og:site_name" content="Bloomingdale's" />
<meta property="fb:app_id" content="253137974703583" />
<link rel="canonical" href="http://www1.bloomingdales.com/shop/product/theodora-callum-flats-primaballet-with-ankle-strap?ID=596838" />
<meta name="description" content="Shop for Theodora &amp; Callum Flats - Primaballet with Ankle Strap online at Bloomingdales.com. In culture-rich prints, these Theodora &amp; Callum flats lend a bohemian look. A natural pairing to floating dresses, they exude a vibe that&#039;s both eye-catching and effortless." />
<link href="http://assets.bloomingdales.com/navapp/web20/assets/combo/global.tiles.base_css-201206140340-min-2.css" type="text/css" rel="stylesheet"/>
<link href="http://assets.bloomingdales.com/navapp/web20/assets/combo/global.tiles.base_css-201206140340-min-4.css" type="text/css" rel="stylesheet"/>
<link href="/favicon.ico" rel="SHORTCUT ICON" />
<link type='text/css' href='http://assets.bloomingdales.com/navapp/web20/assets/style/quickBag/quickBag.css' rel='stylesheet'/>
<link href="http://assets.bloomingdales.com/navapp/web20/assets/combo/catalog.pdp.css-201206140340-min-3.css" type="text/css" rel="stylesheet"/>
<link href="http://assets.bloomingdales.com/navapp/web20/assets/combo/catalog.pdp.css-201206140340-min-4.css" type="text/css" rel="stylesheet"/>
<link href="http://bloomingdales.ugc.bazaarvoice.com/static/7130aa/bazaarvoice.css" rel="stylesheet" type="text/css" />
<style type="text/css">
/*------------- Generic ------------------*/
.addToBagBtn{
background:url('http://assets.bloomingdales.com/navapp/img/buttons/b_addtoshoppingbag.gif') no-repeat;
}
.updateBtn{
background:url('http://assets.bloomingdales.com/navapp/img/buttons/b_item_added.gif') no-repeat;
}
.coach_pdp_add_to_bag input.pdp_add_to_bag_right{
background: url('http://assets.bloomingdales.com/navapp/web20/assets/img/coach/add_to_shoppingBag_btn.gif') no-repeat scroll 0 0 transparent;
}
.coach_pdp_add_to_bag input.pdp_add_to_bag_right.updateBtn{
background: url('http://assets.bloomingdales.com/navapp/web20/assets/img/coach/addToBag/coach_itemAddedButton.gif') no-repeat;
}
#pdp_main {
background: url('http://assets.bloomingdales.com/navapp/img/nav/r09/bg_pdp.gif') top repeat-y;
}
input.pdp_add_to_bag_left{
background:url('http://assets.bloomingdales.com/navapp/img/buttons/addToRegBtn.gif') no-repeat;
}
div.bl_gwp_container{
background:url('http://assets.bloomingdales.com/navapp/img/nav/r09/bg_pdp.gif') repeat-y scroll center top transparent;
}
.yui-panel-container #largeImageOverlay .container-close,
.yui-panel-container #sampleEmailOverlay .container-close {
background-image: url("http://assets.bloomingdales.com/navapp/web20/assets/img/faceted/closeBtn.gif");
}
/*------------- CMIO ------------------*/
div.bl_gwp_right{
background:url('http://assets.bloomingdales.com/navapp/img/nav/r09/bg_pdp_cmio.gif') no-repeat scroll center top transparent;
}
div.cmio_PDPZ1 {
background:url('http://assets.bloomingdales.com/navapp/img/nav/r09/bg_pdp_cmio.gif') no-repeat scroll center top transparent;
}
/*------------- Find It In Store ------------------*/
.error-msg-outer-img {
background: url("http://assets.bloomingdales.com/navapp/web20/assets/img/findItInStore/fiis-error-pdp.gif") no-repeat scroll left top transparent;
}
.overlay > .png-hack {
background:url('http://assets.bloomingdales.com/navapp/img/shadow3.png') repeat 100% 100%;
}
.ovr-hdr {
background: url("http://assets.bloomingdales.com/navapp/web20/assets/img/findItInStore/dottedBorder.gif") repeat-x scroll center bottom transparent;
}
.ovr-infrmc {
background:url("http://assets.bloomingdales.com/navapp/web20/assets/img/findItInStore/or.png") no-repeat 50%;
}
.container-close {
background:red url('http://assets.bloomingdales.com/navapp/img/icons/icon_close_atb.gif') no-repeat;
}
#dottedseperator {
background: url("http://assets.bloomingdales.com/navapp/web20/assets/img/findItInStore/dottedBorder.gif") repeat-x scroll center bottom transparent;
}
.error-msg-img {
background: url("http://assets.bloomingdales.com/navapp/web20/assets/img/findItInStore/overlay_error.png") no-repeat scroll left -1px transparent;
}
.error-msg-storelist {
background: url("http://assets.bloomingdales.com/navapp/web20/assets/img/findItInStore/fiis-error-pdp.gif") no-repeat scroll left -1px transparent;
}
/*------------- PDP ------------------*/
.pdp_atb_dotted_line {
background: url("http://assets.bloomingdales.com/navapp/img/catalog/dotted_line.gif") repeat-x 0 5px
}
.pdp_darken {
background: url("http://assets.bloomingdales.com/navapp/web20/assets/img/catalog/product/darken.png") repeat transparent;
}
.closeSampleEmail{
background: url("http://assets.bloomingdales.com/navapp/web20/assets/img/findItInStore/dottedBorder.gif") repeat-x scroll center bottom transparent;
}
</style>
<script type="text/javascript">
var assetsServer = "http://assets.bloomingdales.com/navapp",
assetsURL = "http://assets.bloomingdales.com/navapp/web20/assets/",
secureServer = "https://www.bloomingdales.com",
unsecureServer = "http://www1.bloomingdales.com",
baseServerURL = "http://www1.bloomingdales.com";
pdpAssetServer = "http://images.bloomingdales.com/is/image/BLM",
isYAQF = true;
</script>
<script type="text/javascript" src="http://assets.bloomingdales.com/navapp/web20/assets/combo/global.tiles.base_script-201206140340-min.js"></script>
<script type="text/javascript">
var YUI_Version = "";
</script>
<script type="text/javascript" src="http://assets.bloomingdales.com/navapp/web20/assets/combo/global.tiles.base_script-201206140340-min-3.js"></script>
<script type="text/javascript" src="http://assets.bloomingdales.com/navapp/web20/assets/combo/global.tiles.base_script-201206140340-min-5.js"></script>
<script type="text/javascript" src="http://assets.bloomingdales.com/navapp/web20/assets/combo/global.tiles.base_script-201206140340-min-7.js"></script>
<script type="text/javascript" src="http://assets.bloomingdales.com/navapp/web20/assets/combo/global.tiles.base_script-201206140340-min-8.js"></script>
<script type="text/javascript" src="http://assets.bloomingdales.com/navapp/web20/assets/combo/global.tiles.base_script-201206140340-min-9.js"></script>
<script type="text/javascript" src="http://assets.bloomingdales.com/navapp/web20/assets/combo/catalog.pdp.script-201206140340-min.js"></script>
<script type="text/javascript" src="http://assets.bloomingdales.com/navapp/web20/assets/combo/catalog.pdp.script-201206140340-min-3.js"></script>
<script type="text/javascript" src="http://assets.bloomingdales.com/navapp/web20/assets/combo/catalog.pdp.script-201206140340-min-5.js"></script>
<script type="text/javascript" src="http://assets.bloomingdales.com/navapp/web20/assets/combo/catalog.pdp.script-201206140340-min-6.js"></script>
<script type="text/javascript" src="http://admin.brightcove.com/js/BrightcoveExperiences.js" ></script>
<script type="text/javascript" src="http://bloomingdales.ugc.bazaarvoice.com/static/7130aa/bvapi.js"></script>
<script type="text/javascript" src="http://assets.bloomingdales.com/navapp/web20/assets/combo/catalog.pdp.script-201206140340-min-8.js"></script>
<script type="text/javascript">
BLOOMIES.cmZoneId = 'PDPZ1';
var isRegistryModeA = false;
if(isRegistryModeA){
var cmAddToRegistryPageID = "Add_to_Registry_BWEDD";
}else{
var cmAddToRegistryPageID = "Add_to_Registry_BCOM";
}
var CMcategoryID = "";
</script>
<script type="text/javascript" src="http://assets.bloomingdales.com/navapp/web20/assets/combo/catalog.pdp.script-201206140340-min-9.js"></script>
<script type="text/javascript">
setCookie('FORWARDPAGE_KEY', this.location);
</script>
</head>
<body class="yui-skin-sam yui3-skin-sam">
<div class="outOfScreen">
<a href="#skipToContent">Skip to Content</a>
</div>
<script type="text/javascript" src="http://assets.bloomingdales.com/navapp/web20/assets/combo/global.tiles.analytics-201206140340-min.js"></script>
<script type="text/javascript">
cmSetProduction();
</script>
<script type="text/javascript" >
BLOOMIES.coremetrics.pageViewExploreAttributes = new BLOOMIES.coremetrics.exploreAttributes();
if (BLOOMIES.iShip.internationalMode) {
var countryName = BLOOMIES.coremetrics.countryName();
BLOOMIES.coremetrics.pageViewExploreAttributes.add({15:"International_" + countryName});
}
</script>
<script type="text/javascript">
var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
</script>
<script type="text/javascript">
var pageTracker = _gat._getTracker("UA-4092090-1");
pageTracker._setDomainName("bloomingdales.com");
pageTracker._setCookieTimeout("2592000"); 
pageTracker._initData();
pageTracker._trackPageview();
</script>
<input type="hidden" id="categoryID" value="17367"/>
<script type="text/javascript">
BLOOMIES.pdp.CMCategoryId = "17367"; //Used explicitly by Coremetrics Shop5 tag
BLOOMIES.pdp.CMLinkType = ''; //Used
BLOOMIES.coremetrics.pageViewExploreAttributes.add({18:'SINGLE ITEM'});
BLOOMIES.coremetrics.pageViewExploreAttributes.add({12:getCookie('SL')});
YAHOO.util.Event.onDOMReady( function() {
addFacetSelections(BLOOMIES.coremetrics.pageViewExploreAttributes);
updateCMExplore();
var productID = YAHOO.util.Dom.get("productId").value;
BLOOMIES.coremetrics.cmCreateProductviewTag(productID,'Theodora &amp; Callum Flats - Primaballet with Ankle Strap',"17367");
});
</script>
<div id="bl_main_container">
<a name="top"></a>
<script type="text/javascript">
var rightNowDomainName = 'https://customerservice.bloomingdales.com';
</script>
<div id="bl_nav_top_container_tiles" class="bl_nav_top_container">
<!-- Loyalist wallpaper removed -->
<div class="bl_nav_top_logo">
<a href="http://www1.bloomingdales.com/index.ognc?cm_sp=NAVIGATION-_-TOP_NAV-_-TOP_BLOOMIES_ICON"><img src="http://assets.bloomingdales.com/navapp/img/nav/r09/topnav/l_mainLogo.gif" alt="Bloomingdale's" class="displayBlock" /></a>
</div>
<div id="bl_nav_top_banner" class="bl_nav_top_banner">
<script type="text/javascript">
var flMovie = "http://assets.bloomingdales.com/navapp/dyn_img/homepage_pools/0611_ongoing_global_banner.swf";
var flParams = {wmode:"transparent", allowScriptAccess: "always", quality: "high"};
var flAttr = {"class": "swfblock"};
var flWidth = "375";
var flHeight = "30";
var flMinVersion = "5";
var flContainerID = "flashContent_top_banner";
swfobject.embedSWF(flMovie, flContainerID, flWidth, flHeight, flMinVersion, "http://assets.bloomingdales.com/navapp/media/expressInstall.swf", null, flParams, flAttr); 
</script>
<div id="flashContent_top_banner">
<a href="javascript:pop(&#039;/popup.ognc?popupID=23133&amp;cm_sp=NAVIGATION-_-GLOBAL_BANNER-_-FREE_SHIPPING&#039;,&#039;myDynaPop&#039;,&#039;width=575,height=350&#039;)">
<img src="http://assets.bloomingdales.com/navapp/dyn_img/homepage_pools/0611_ongoing_global_banner.jpg" width="375" height="30" class="img_homepage" />
</a>
</div>
</div>
<a href="http://www1.bloomingdales.com/bag/index.ognc?cm_sp=NAVIGATION-_-TOP_NAV-_-MY_BROWN_BAG"><img src="http://assets.bloomingdales.com/navapp/img/nav/r09/topnav/l_loyaltyBrownBag.gif" alt="My Shopping Bag" class="nav_bag" /></a>
<div class='bl_nav_top_bag_text'>
<div class='bl_nav_top_links'>
<div id="bl_nav_account_flag">
<script type="text/javascript">
<!--//Hide from validator
(this.getSignedIn()==1) ? document.write('<' + 'a href="https://www.bloomingdales.com/signin/signout.ognc?cm_sp=NAVIGATION-_-TOP_NAV-_-SIGN_IN" class="top_nav_link" >SIGN OUT<\/a>'): document.write('<' + 'a href="https://www.bloomingdales.com/signin/index.ognc?cm_sp=NAVIGATION-_-TOP_NAV-_-SIGN_IN" class="top_nav_link">SIGN IN<\/a>');
//-->
</script>
&nbsp;|&nbsp;
<a href='https://www.bloomingdales.com/myinfo/index.ognc?cm_sp=NAVIGATION-_-TOP_NAV-_-MY_ACCOUNT' class='top_nav_link'>MY ACCOUNT</a>
&nbsp;|&nbsp;	
<a href="https://customerservice.bloomingdales.com/app/" class="top_nav_link">HELP</a>
</div>
<div class="clearBoth"></div>	
<div id="qb_headerCheckoutLink"><a href="http://www1.bloomingdales.com/bag/index.ognc" class="top_nav_link">CHECKOUT</a></div>
<div id="qb_headerItemContainer">
<div id="qb_showBagItems" class="yui-skin-sam">
<a href="http://www1.bloomingdales.com/bag/index.ognc" id="qb_addToBagOverlayLabel" class="qb_closedOverlayLabel">
<script type="text/javascript">thisUser.qb_writeWelcome();</script> 
BROWN BAG: 
<span id="brownBagItemsTotal">
<script type="text/javascript">
thisUser.writeCartItems();
document.write(thisUser.getCartItemTotal()==="1"? " ITEM" : " ITEMS");
</script>
</span>
</a>
</div>
</div>
<div class="clearBoth"></div>
</div>
</div>
<div class='clearBoth'></div>
<div class="bl_nav_top_contain_outer">
<div class="bl_nav_top_contain" id="bl_nav_top_menu">
<div class="bl_nav_top_section_navigation_options"><a class="white" onmouseout="rollMouseOut(this);" onmouseover="rollMouseOver(this);" href="http://www1.bloomingdales.com/search/index.ognc?designer=Women&amp;Action=designer&amp;cm_sp=NAVIGATION-_-TOP_NAV-_-DESIGNERS"><img height="9" width="63" class="displayBlock" alt="Designers" src="http://assets.bloomingdales.com/navapp/img/nav/r09/topnav/topnav_designers_off.gif"/></a></div>
<div class="bl_nav_top_section_navigation_options"><a class="white" onmouseout="rollMouseOut(this);" onmouseover="rollMouseOver(this);" href="http://www1.bloomingdales.com/catalog/index.ognc?CategoryID=2910&amp;cm_sp=NAVIGATION-_-TOP_NAV-_-WOMEN"><img class="displayBlock" alt="Women" src="http://assets.bloomingdales.com/navapp/img/nav/r09/topnav/topnav_women_off.gif"/></a></div>
<div class="bl_nav_top_section_navigation_options"><a class="white" onmouseout="rollMouseOut(this);" onmouseover="rollMouseOver(this);" href="http://www1.bloomingdales.com/catalog/index.ognc?CategoryID=2911&amp;cm_sp=NAVIGATION-_-TOP_NAV-_-CONTEMPORARY"><img class="displayBlock" alt="Contemporary" src="http://assets.bloomingdales.com/navapp/img/nav/r09/topnav/topnav_contemporary_off.gif"/></a></div>
<div class="bl_nav_top_section_navigation_options"><a class="white" href="http://www1.bloomingdales.com/catalog/index.ognc?CategoryID=16961&amp;cm_sp=NAVIGATION-_-TOP_NAV-_-SHOES"><img class="displayBlock" alt="Shoes" src="http://assets.bloomingdales.com/navapp/img/nav/r09/topnav/topnav_shoes_on.gif"/></a></div>
<div class="bl_nav_top_section_navigation_options"><a class="white" onmouseout="rollMouseOut(this);" onmouseover="rollMouseOver(this);" href="http://www1.bloomingdales.com/catalog/index.ognc?CategoryID=16958&amp;cm_sp=NAVIGATION-_-TOP_NAV-_-HANDBAGS"><img class="displayBlock" alt="Handbags" src="http://assets.bloomingdales.com/navapp/img/nav/r09/topnav/topnav_handbags_off.gif"/></a></div>
<div class="bl_nav_top_section_navigation_options"><a class="white" onmouseout="rollMouseOut(this);" onmouseover="rollMouseOver(this);" href="http://www1.bloomingdales.com/catalog/index.ognc?CategoryID=3376&amp;cm_sp=NAVIGATION-_-TOP_NAV-_-JEWELRY_AND_ACCESSORIES"><img class="displayBlock" alt="Jewelry &amp; Accessories" src="http://assets.bloomingdales.com/navapp/img/nav/r09/topnav/topnav_jewelry_accessories_off.gif"/></a></div>
<div class="bl_nav_top_section_navigation_options" id="bl_nav_top_beauty"><a class="white" onmouseout="rollMouseOut(this);" onmouseover="rollMouseOver(this);" href="http://www1.bloomingdales.com/catalog/index.ognc?CategoryID=2921&amp;cm_sp=NAVIGATION-_-TOP_NAV-_-BEAUTY"><img class="displayBlock" alt="Beauty" src="http://assets.bloomingdales.com/navapp/img/nav/r09/topnav/topnav_beauty_off.gif"/></a></div>
<div class="bl_nav_top_section_navigation_options"><a class="white" onmouseout="rollMouseOut(this);" onmouseover="rollMouseOver(this);" href="http://www1.bloomingdales.com/catalog/index.ognc?CategoryID=3864&amp;cm_sp=NAVIGATION-_-TOP_NAV-_-MEN"><img class="displayBlock" alt="Men" src="http://assets.bloomingdales.com/navapp/img/nav/r09/topnav/topnav_men_off.gif"/></a></div>
<div class="bl_nav_top_section_navigation_options"><a class="white" onmouseout="rollMouseOut(this);" onmouseover="rollMouseOver(this);" href="http://www1.bloomingdales.com/catalog/index.ognc?CategoryID=3866&amp;cm_sp=NAVIGATION-_-TOP_NAV-_-KIDS"><img class="displayBlock" alt="Kids" src="http://assets.bloomingdales.com/navapp/img/nav/r09/topnav/topnav_kids_off.gif"/></a></div>
<div class="bl_nav_top_section_navigation_options"><a class="white" onmouseout="rollMouseOut(this);" onmouseover="rollMouseOver(this);" href="http://www1.bloomingdales.com/catalog/index.ognc?CategoryID=3865&amp;cm_sp=NAVIGATION-_-TOP_NAV-_-HOME"><img class="displayBlock" alt="Home" src="http://assets.bloomingdales.com/navapp/img/nav/r09/topnav/topnav_home_off.gif"/></a></div>
<div class="bl_nav_top_section_navigation_options_last"><a class="white" onmouseout="rollMouseOut(this);" onmouseover="rollMouseOver(this);" href="http://www1.bloomingdales.com/catalog/index.ognc?CategoryID=3977&amp;cm_sp=NAVIGATION-_-TOP_NAV-_-SALE"><img class="displayBlock" alt="Sale" src="http://assets.bloomingdales.com/navapp/img/nav/r09/topnav/topnav_sale_off.gif"/></a></div>
<div class="clearLeft"></div>	
</div>
<div class="clearLeft"></div> 
<div class="bl_nav_top_sub">
<div class="bl_nav_top_sub_search">
<form id="keywordSearch" method="get" action="http://www1.bloomingdales.com/search/index.ognc">
<div class="bl_nav_top_sub_search_input">
<input type="hidden" value="*" name="SearchTarget" />
<input class="bl_nav_top_sub_search_box" type="text" name="Keyword" value="" title="Keyword Search" />
</div>
<div class="bl_nav_top_sub_search_go">	
<input class="bl_nav_top_sub_search_go" type="image" alt="Search Now" value="KEYWORD_GO_BUTTON" name="KEYWORD_GO_BUTTON" src="http://assets.bloomingdales.com/navapp/img/nav/r09/topnav/topnav_sub_search.gif" />
</div>
<div class="clearLeft"></div>
</form>
</div>
<div id="bl_nav_top_links" class="bl_nav_top_sub_service">
<ul>
<li class="bl_nav_top_link_right" id="bl_nav_top_link_registry"><a href="http://www1.bloomingdales.com/registry/wedding/registryhome?cm_sp=NAVIGATION-_-TOP_NAV-_-REGISTRY"><img src="http://assets.bloomingdales.com/navapp/img/nav/r09/topnav/topnav_sub_registry.gif" alt="THE REGISTRY" class="displayBlock" /></a></li>
<li class="bl_nav_top_link_right" id="bl_nav_top_link_registry_iShip"><a href="http://www1.bloomingdales.com/customerservice/international.jsp#registry?cm_sp=NAVIGATION-_-TOP_NAV-_-REGISTRY"><img src="http://assets.bloomingdales.com/navapp/img/nav/r09/topnav/topnav_sub_registry.gif" alt="THE REGISTRY" class="displayBlock" /></a></li>
<li class="bl_nav_top_link" id="bl_nav_top_link_gifts"><a href="http://www1.bloomingdales.com/catalog/index.ognc?CategoryID=3948&amp;cm_sp=NAVIGATION-_-TOP_NAV-_-GIFTS_AND_GIFTCARDS"><img src="http://assets.bloomingdales.com/navapp/img/nav/r09/topnav/topnav_sub_giftCards.gif" alt="GIFTS &amp; GIFT CARDS" class="displayBlock" /></a></li>
<li class="bl_nav_top_link" id="bl_nav_top_link_stores"><a href="http://www1.bloomingdales.com/store/index.ognc?cm_sp=NAVIGATION-_-TOP_NAV-_-STORES_EVENTS"><img src="http://assets.bloomingdales.com/navapp/img/nav/r09/topnav/topnav_sub_storesEvents.gif" alt="STORES &amp; EVENTS" class="displayBlock" /></a></li>
</ul>
<div class="bl_nav_top_sub_ad" id="bl_nav_top_seasonal_ad">	
<!-- For Legacy -->
<!-- For NavApp -->
</div>
<div id="bl_nav_back_to_bquick"></div>
</div>
<div class="clearLeft"></div>
</div>
</div>
</div>
<!-- Begin Monetate tag v6. Place at start of document head. DO NOT ALTER. -->
<script type="text/javascript">
var monetateT = new Date().getTime();
(function() {
var p = document.location.protocol;
if (p == "http:" || p == "https:") {
var m = document.createElement('script');
m.type = 'text/javascript';
m.async = true;
m.src = (p == "https:" ? "https://s" : "http://")
+ 'b.monetate.net/js/1/a-4e80f16c/p/bloomingdales.com/'
+ Math.floor((monetateT + 1604491) / 3600000)
+ "/g";
var s = document.getElementsByTagName('script')[0];
s.parentNode.insertBefore(m, s);
}
})();
</script>
<!-- End Monetate tag. -->
<div class="bl_main">
<div id="pdp_main">
<div class="pdp_container">
<div id="pdp_depthpath" class="pdp_depthpath">
<input type="hidden" id="coremetricsDepthPath" value="Shoes">
<input type="hidden" id="coremetricsDepthPath" value="Sale">
<div class="pdp_breadcrumbContainer">
<div class="bl_breadCrumbContainer">
<a href='/shop/shoes?id=16961' class="bl_breadcrumb_link">Shoes</a>&nbsp;&gt;
<span>Sale</span>
</div>
</div>
<div class="clearBoth"></div>
</div>
<div class="bannerAd">
<map name="Banner">
<area shape="rect" href="/style-guide/spring-shoe-wardrobe.jsp?cm_sp=banner-_-PDP-_-shoewardrobe" coords="1,0,756,28" alt="Explore The Shoe Wardrobe">	
</map>
<img usemap="#Banner" border="0" alt="" src="http://assets.bloomingdales.com/navapp/dyn_img/cat_splash/SW_Pdp.jpg"/>
</div>
<div class="pdp_errorMsg hidden" id="pdp_errorMsg">
<div class="pdp_errorIcon"><img alt="Error" src="http://assets.bloomingdales.com/navapp/web20/assets/img/catalog/product/i_pdp_error.gif"></div>
<div id="pdp_errorText" class="pdp_errorText">
</div>
<div class="clearBoth"></div>
</div>
<a name="skipToContent"></a>
<div class="pdp_altImages">
<div id="pdp_alt_images_container" class="pdp_alt_images_container">
<div class="bl_pdp_thumb"> 
<a href="javascript:void(0)" class="pdp_alt_image_link">
<img id="altImage_0" src="http://images.bloomingdales.com/is/image/BLM/products/4/optimized/1281004_fpx.tif?wid=52&qlt=90,0&layer=comp&op_sharpen=0&resMode=sharp2&op_usm=0.7,1.0,0.5,0&fmt=jpeg" 
class="altImage PDPImageDisplayBlackBorder">
</a> 
</div>
<div class="bl_pdp_thumb"> 
<a href="javascript:void(0)" class="pdp_alt_image_link">
<img id="altImage_1" src="http://images.bloomingdales.com/is/image/BLM/products/2/optimized/1281002_fpx.tif?wid=52&qlt=90,0&layer=comp&op_sharpen=0&resMode=sharp2&op_usm=0.7,1.0,0.5,0&fmt=jpeg" 
class="altImage PDPImageDisplay">
</a>
</div>
<div class="bl_pdp_thumb"> 
<a href="javascript:void(0)" class="pdp_alt_image_link">
<img id="altImage_2" src="http://images.bloomingdales.com/is/image/BLM/products/3/optimized/1281003_fpx.tif?wid=52&qlt=90,0&layer=comp&op_sharpen=0&resMode=sharp2&op_usm=0.7,1.0,0.5,0&fmt=jpeg" 
class="altImage PDPImageDisplay">
</a>
</div>
</div>
<div id="alt_images_scroll_down_area">	
<div id="alt_images_scroll_down_container"> 
<img src="http://assets.bloomingdales.com/navapp/img/pdp/pdp_arrowUp.gif" class="displayBlock" id="alt_images_scroll_up">
</div>
</div>
<div id="alt_images_scroll_up_area">
<div id="alt_images_scroll_up_container">
<img src="http://assets.bloomingdales.com/navapp/img/pdp/pdp_arrowDown.gif" class="displayBlock" id="alt_images_scroll_down">
</div>
</div>
<div class="clearBoth"></div>
</div>	
<div class="pdp_left">
<div id="pdp_left_image">
<div id="pdp_darken_top" class="pdp_darken" ></div>
<div id="pdp_darken_right" class="pdp_darken" ></div>
<div id="pdp_darken_bottom" class="pdp_darken" ></div>
<div id="pdp_darken_left" class="pdp_darken" ></div>
<div id="zoomerDiv">
<img id="productImage" class="PDPImageDisplayMain" src="http://images.bloomingdales.com/is/image/BLM/products/4/optimized/1281004_fpx.tif?wid=325&amp;qlt=90,0&amp;layer=comp&amp;op_sharpen=0&amp;resMode=sharp2&amp;op_usm=0.7,1.0,0.5,0&amp;fmt=jpeg" />
</div>
</div>
<div id="pdp_left_video" style="display:none;">
</div>
<div class="pdp_zoom">
<ul>
<li><img alt="Roll for Zoom" id="img_rollZoom" src="http://assets.bloomingdales.com/navapp/web20/assets/img/catalog/product/b_rollZoom.gif"/></li>
<li>
<a id="largerImgView" href="javascript:void(0);">
<img alt="Larger View" id="img_largerView" src="http://assets.bloomingdales.com/navapp/web20/assets/img/catalog/product/b_largerView.gif">
</a>
</li>
</ul>
</div>
</div>
<div class="pdp_right">
<div id="mainProductZoomerArea" class="PDPImageDisplay" >
<img id="mainProductImageZoom" src="http://images.bloomingdales.com/is/image/BLM/products/4/optimized/1281004_fpx.tif?wid=1200&amp;qlt=90,0&amp;layer=comp&amp;op_sharpen=0&amp;resMode=sharp2&amp;op_usm=0.7,1.0,0.5,0&amp;fmt=jpeg" />
</div>
<div id="productDescription">
<input type="hidden" id="productId" value="596838">
<div class="pdp_productInfo">
<div id="bonusOffer"> </div>
<div class="pdp_descriptionAndPrice">
<h1>Theodora & Callum Flats - Primaballet with Ankle Strap</h1>
<div id="PriceDisplay">
<div class="priceSale">
<div><span>Orig </span><span class="priceBig">$235.00</span></div>
<div><span>Was </span><span class="priceBig">$164.50</span></div>
<div><span class="priceSale">Now $115.15</span></div>
</div>
<input type="hidden" class="netPrice" value="$115.15" />
</div>
</div>
<div class="pdp_longDescription">
In culture-rich prints, these Theodora & Callum flats lend a bohemian look. A natural pairing to floating dresses, they exude a vibe that's both eye-catching and effortless.
</div>
<ul>
<li id="productDetailsBulletText">Linen upper, suede lining, leather sole</li>
<li id="productDetailsBulletText">Imported</li>
<li id="productDetailsBulletText">Fabric ankle wrap tie, allover print</li>
<li id="productDetailsBulletText">Available in full and half sizes</li>
<li>Web ID: 596838</li>
</ul>
<div id="BVRRSummaryContainer"></div>
</div>
<div class="error-msg-outer" style="display: none;">
<div class="error-msg-outer-img"><div class="error-msg-pdp"></div></div>
</div>
<div class="pdp_member_area">
<div class="pdp_productInfoContainer" id="productBox">
<div class="pdp_sizecolor_section1">
<div class="pdp_size">
<label for="size">	
SIZE:
</label>
<div class="pdp_size_box">
<select id="productSize" class="pdp_size_dropdown" name="productSize" value="Select Size" onChange="BLOOMIES.pdp.getSelection(); BLOOMIES.pdp.validateColorDropdown();">
<option selected="selected" value="NOSELECTION">Select Size</option>
<option value="6">6</option>
<option value="7">7</option>
<option value="7.5">7.5</option>
<option value="8">8</option>
<option value="8.5">8.5</option>
<option value="9">9</option>
<option value="9.5">9.5</option>
<option value="10">10</option>
</select>
</div>
</div>
<div id="sizeChart_596838" class="sizeChartLinkContainer">
<span class="sizeChartLink">size chart</span>	
<div class="hidden">
<!-- Generic size charts - convert to "international" - see below -->
<!-- Pick non vendor or vendor size charts -->
<!-- Non-vendor (formerly intl) -->
<div id="productSizeChart_596838_container">	
<!-- International size chart -->
<table cellpadding="0" cellspacing="0" border="0">
<tr>
<td>
<img src="http://assets.bloomingdales.com/navapp/img/intl_size/INTL_SizeChart_WOMEN_SHOES.jpg" border="0" />
</td>
</tr>
</table>
</div>
<div id="productSizeChart_596838" class="productSizeChart">
<div class="bd">
</div>
</div>
</div>
</div>
</div>
<div class="pdp_sizecolor_section2">
<div id="ColorDisplay" class="pdp_color_swatch">
<img id="swatch" class="displayBlock" alt="" src="http://assets.bloomingdales.com/navapp/web20/assets/img/catalog/product/spacer.gif" />
</div>
<div class="pdp_section_copy">
<label for="color"> COLOR: </label>
</div>
<div class="pdp_color_box">
</div> 
</div>
<div class="pdp_qty" id="pdpQty">
<span>QTY:</span>
<div class="pdp_qty_box">
<select id="productQuantity" class="pdp_dropdown_qty" name="productQuantity">
<option value="NOSELECTION">Qty</option>
<option selected="selected" value="1">1</option>
<option value="2">2</option>
<option value="3">3</option>
<option value="4">4</option>
<option value="5">5</option>
<option value="6">6</option>
</select>
</div>
</div>
<div class="clearBoth"></div>
<div id="AvailMsgDisplay" class="pdp_avail_msg">
</div>
<input type="hidden" id="price" value="115.15" />
<div class="clearBoth"></div>
<div class="pdp_add_to_bag">
<div id="pdp_atbOverlay" style="display: none">
<div class="pdp_atb_main">
<div class="pdp_atb_top_link">
<div class="floatLeft">
<a href="http://www1.bloomingdales.com/bag/index.ognc">
<img src="http://assets.bloomingdales.com/navapp/img/catalog/brown_bag.jpg" />
</a>
</div>
<div class="pdp_atb_prodDesc">
<div class="pdp_atb_got_it">
<span id="itemsAddedMessage"></span>
</div>
<div class="pdp_atb_items_in_bag">
<span id="pdp_atb_bagTotal"></span> in
Bag&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;Subtotal :
<span id="pdp_atb_bagSubTotal"></span>
</div>
</div>
<div class="clearBoth"></div>
</div>
<div class="pdp_atb_dotted_line"></div>
<div id="pdp_atb_items"></div>
<div class="pdp_atb_dotted_line"></div>
<div class="pdp_atb_offers">
<div id="pdp_atb_offer_msgs"></div>
</div>
<div id="atb_yaqfMessageContainer" class="yaqf_messageContainer">
<div id="atb_yaqfMessagePrimary" class="yaqf_messagePrimary highlightText"></div>
<div id="atb_yaqfMessageSecondary" class="yaqf_messageSecondary"></div>
</div>
<div class="pdp_atb_buttons">
<img src="http://assets.bloomingdales.com/navapp/img/checkout2/buttons/ch_b_continueShopping.gif" alt="Continue Shopping" id="pdp_atb_cont_shopping" />
<a id="pdp_atb_checkout" href="http://www1.bloomingdales.com/bag/index.ognc?CategoryID=17367">
<img src="http://assets.bloomingdales.com/navapp/img/checkout2/buttons/b_checkout.gif" alt="CHECKOUT" />
</a>
</div>
</div>
</div>
<input type="submit" id="ADDTOBAG_BUTTON" value="" class="pdp_add_to_bag_right addToBagBtn" /> 
</div>
<div class="clearBoth"></div>
<div class="clearBoth"></div>
</div>
</div>
<div id="addToWishlistToolTip" style="display:none"><div id="awtErr">There are some issues while adding some items to your wishlist</div><div class="atwMssg">Your selection has been added to your <a href="/myinfo/wishlist/index.ognc">wishlist</a></div></div>
</div>
<form>
<div class="pdp_email_wishlist_links">
<div class="pdp_emailLink_container" id="pdp_emailAFriend">	
<div class="pdp_email_copy"><a href="javascript:pop('https://www.bloomingdales.com/catalog/product/email/index.ognc?ID=596838&cm_sp=PDP-_-SiteTools-_-EmailToFriend','PDP','status,scrollbars,width=480,height=550')" class="pdp_service_link">EMAIL A FRIEND</a></div>
<div class="pdp_email_icon"><a href="javascript:pop('https://www.bloomingdales.com/catalog/product/email/index.ognc?ID=596838&cm_sp=PDP-_-SiteTools-_-EmailToFriend','PDP','status,scrollbars,width=480,height=550')"><img src="http://assets.bloomingdales.com/navapp/img/buttons/b_email_to_a_friend.gif" alt="Email A Friend" class="displayBlock"></a></div>
</div>
<div class="clearBoth"></div>
<div class="pdp_emailLink_container">
<div class="pdp_wishlist_copy">
<span class="pdp_wishlist_link" id="ADDTOWISHLIST_LINK">ADD TO WISHLIST</span>
</div>
<div class="pdp_wishlist_icon">
<img class="pdp_wishlist_link" id="addWishlistIcon" src="http://assets.bloomingdales.com/navapp/img/PlusSign.gif">
</div>
</div>
<div class="clearBoth"></div>
<div id="BVRRSecondarySummaryContainer" class="floatRight"></div>
<div class="clearBoth"></div>
</div>
<div class="pdp_policy_links">
<a id="shippingInfoLink" class="pdp_service_link" href="javascript:pop('https://customerservice.bloomingdales.com/app/answers/detail/a_id/354/theme/popup/','CustomerService','menubar,status,scrollbars,width=655,height=500');" >SHIPPING INFO</a>
<span id="iShip_span_returns"> &nbsp;&nbsp;|&nbsp;&nbsp; </span>
<a id="iShip_link_returns" class="pdp_service_link" href="javascript:pop('https://customerservice.bloomingdales.com/app/answers/detail/a_id/359/theme/popup/','CustomerService','menubar,status,scrollbars,width=450,height=350');">EASY RETURNS</a>
&nbsp;&nbsp;|&nbsp;&nbsp;
<a id="pricingPolicyLink" href="javascript:pop('https://customerservice.bloomingdales.com/app/answers/detail/a_id/366/theme/popup/','PricingPolicy','menubar,status,scrollbars,width=450,height=350,top=200,left=200,screenX=200,screenY=200');" class="pdp_pricing_policy_link">PRICING POLICY</a>
</div>
</form>
</div>
<div class="clearBoth"></div>
<div class="bizaar_ratingClickableImg">
<div id="BVRRContainer"></div>	
</div>
</div>
<div class="cmio_PDPZ1 yui-skin-sam">
<input type="hidden" id="cmio_productId" value="596838"/>
<input type="hidden" id="cmio_categoryId" value="17367"/>
<div id="cmIO_PDPZ1" class="hidden"></div>
<div class="clearBoth"></div>
<script type="text/javascript">
YAHOO.util.Event.addListener(document.body, "onunload", BLOOMIES.pdp.setPrevProd("596838","17367","4/optimized/1281004_fpx.tif","Theodora & Callum Flats - Primaballet with Ankle Strap"));
</script>
<div id="recentlyViewedContainer"></div>
<script type="text/javascript">
BLOOMIES.pdp.recentlyViewed(596838, 'http://images.bloomingdales.com/is/image/BLM');
</script>	
</div>
<div class="clearBoth"></div>
</div>
</div>
<script type="text/javascript">
BLOOMIES.pdp.upcmap = [];
BLOOMIES.pdp.upcmap[596838] = [{ "upcID": 1192759, "color": "Sand", "size": "6", "type": "","upc": "883400257232", "isAvailable": "true", "shipDays": "2","availabilityMsg": "In Stock: Usually ships within 2 business days." },{ "upcID": 1192761, "color": "Sand", "size": "7", "type": "","upc": "883400346998", "isAvailable": "true", "shipDays": "2","availabilityMsg": "In Stock: Usually ships within 2 business days." },{ "upcID": 1126793, "color": "Royal", "size": "8", "type": "","upc": "647245458212", "isAvailable": "true", "shipDays": "2","availabilityMsg": "In Stock: Usually ships within 2 business days." },{ "upcID": 1192762, "color": "Sand", "size": "7.5", "type": "","upc": "883400347001", "isAvailable": "true", "shipDays": "2","availabilityMsg": "In Stock: Usually ships within 2 business days." },{ "upcID": 1126794, "color": "Royal", "size": "8.5", "type": "","upc": "647245458229", "isAvailable": "true", "shipDays": "2","availabilityMsg": "In Stock: Usually ships within 2 business days." },{ "upcID": 1192763, "color": "Sand", "size": "8", "type": "","upc": "883400347018", "isAvailable": "true", "shipDays": "2","availabilityMsg": "In Stock: Usually ships within 2 business days." },{ "upcID": 1126795, "color": "Royal", "size": "9", "type": "","upc": "647245458236", "isAvailable": "true", "shipDays": "2","availabilityMsg": "In Stock: Usually ships within 2 business days." },{ "upcID": 1192764, "color": "Sand", "size": "8.5", "type": "","upc": "883400347025", "isAvailable": "true", "shipDays": "2","availabilityMsg": "In Stock: Usually ships within 2 business days." },{ "upcID": 1192765, "color": "Sand", "size": "9", "type": "","upc": "883400347032", "isAvailable": "true", "shipDays": "2","availabilityMsg": "In Stock: Usually ships within 2 business days." },{ "upcID": 1126797, "color": "Royal", "size": "10", "type": "","upc": "647245458250", "isAvailable": "true", "shipDays": "2","availabilityMsg": "In Stock: Usually ships within 2 business days." },{ "upcID": 1192766, "color": "Sand", "size": "9.5", "type": "","upc": "883400347049", "isAvailable": "true", "shipDays": "2","availabilityMsg": "In Stock: Usually ships within 2 business days." },{ "upcID": 1192767, "color": "Sand", "size": "10", "type": "","upc": "883400347056", "isAvailable": "true", "shipDays": "2","availabilityMsg": "In Stock: Usually ships within 2 business days." }];
BLOOMIES.pdp.bonusOffers = [];
BLOOMIES.pdp.isSuppressedForIntlShipping = false;
BLOOMIES.pdp.swatchmap = [ ];
BLOOMIES.pdp.pageType = "SINGLE ITEM";
BLOOMIES.pdp.productIDList = [];
var productNAPage = "";
var bvtoken = "";
if(MACYS.util.Cookie.get("BazaarVoiceToken","GCs")){
bvtoken = MACYS.util.Cookie.get("BazaarVoiceToken","GCs");
}
$BV.configure("global", {
userToken: bvtoken,
productId: '596838',
submissionUI: 'LIGHTBOX',
submissionContainerUrl: window.location.href,
allowSamePageSubmission: true,
doLogin: function(callback, success_url) {
MACYS.util.Cookie.set("FORWARDPAGE_KEY",success_url);
window.location = 'https://www.bloomingdales.com/signin/index.ognc?fromPage=pdpReviews';
},
doShowContent: true
});
$BV.ui('rr', 'show_reviews', {});
</script>
<div class="bl_nav_bot_container">
<div class="bl_nav_bot_section_navigation_options_first" id="bot_nav_customerService"><a class="bot_nav_link" href="https://customerservice.bloomingdales.com/app/home/?cm_sp=NAVIGATION-_-BOTTOM_NAV-_-CUSTOMER_SERVICE">
<img src="http://assets.bloomingdales.com/navapp/img/nav/r09/botnav/botnav_customer_service.gif" width="103" height="8" alt="Customer Service" class="displayBlock" /></a></div>
<div class="bl_nav_bot_section_navigation_options_first" id="bot_nav_customerService_iShip"><a class="bot_nav_link" href="http://www1.bloomingdales.com/customerservice/international.jsp?cm_sp=NAVIGATION_INTL-_-BOTTOM_NAV-_-CUSTOMER_SERVICE"><img src="http://assets.bloomingdales.com/navapp/img/nav/r09/botnav/botnav_customer_service.gif" width="103" height="8" alt="Customer Service" class="displayBlock" /></a></div>
<div class="bl_nav_bot_section_navigation_options" id="bot_nav_orderStatus"><a class="bot_nav_link" href="https://www.bloomingdales.com/service/order/index.ognc?cm_sp=NAVIGATION-_-BOTTOM_NAV-_-ORDER_STATUS"><img src="http://assets.bloomingdales.com/navapp/img/nav/r09/botnav/botnav_order_status.gif" width="73" height="8" alt="Order Status" class="displayBlock" /></a></div>
<div class="bl_nav_bot_section_navigation_options" id="bot_nav_orderStatus_iShip"><a class="bot_nav_link" href="http://www1.bloomingdales.com/customerservice/international.jsp#myorder?cm_sp=NAVIGATION_INTL-_-BOTTOM_NAV-_-ORDER_STATUS"><img src="http://assets.bloomingdales.com/navapp/img/nav/r09/botnav/botnav_order_status.gif" width="73" height="8" alt="Order Status" class="displayBlock" /></a></div>	
<div class="bl_nav_bot_section_navigation_options" id="bot_nav_iShip"><a class="bot_nav_link" href="http://www1.bloomingdales.com/internationalContext/index.ognc?cm_sp=NAVIGATION_INTL-_-BOTTOM_NAV-_-INTERNATIONAL_SHOPPING"><img src="http://assets.bloomingdales.com/navapp/img/nav/r09/botnav/botnav_international_shopping.gif" width="137" height="8" alt="International Shopping" class="displayBlock" /></a></div>
<div class="bl_nav_bot_section_navigation_options" id="bot_nav_creditServices"><a class="bot_nav_link" href="https://www.bloomingdales.com/service/credit/index.ognc?cm_sp=NAVIGATION-_-BOTTOM_NAV-_-CREDIT_SERVICES"><img src="http://assets.bloomingdales.com/navapp/img/nav/r09/botnav/botnav_credit_services.gif" width="88" height="8" alt="Credit Services" class="displayBlock" /></a></div>
<div class="bl_nav_bot_section_navigation_options" id="bot_nav_payMyBill"><a class="bot_nav_link" href="https://www.bloomingdales.com/credit/paybill/paybillhome"><img src="http://assets.bloomingdales.com/navapp/img/nav/r09/botnav/botnav_pay_bill_online.gif" width="81" height="8" alt="PAY BILL ONLINE" class="displayBlock" /></a></div>
<div class="bl_nav_bot_section_navigation_options" id="bot_nav_viewCreditAcct"><a class="bot_nav_link" href="http://www1.bloomingdales.com/loyallist?cm_sp=NAVIGATION-_-BOTTOM_NAV-_-LOYALLIST"><img src="http://assets.bloomingdales.com/navapp/img/nav/r09/botnav/botnav_loyallist.gif" width="49" height="8" alt="LOYALLIST" class="displayBlock" /></a></div>
<!-- <div class="bl_nav_bot_section_navigation_options" id="bot_nav_shoppingServices"><a class="bot_nav_link" href="http://www1.bloomingdales.com/about/shopping/index.jsp"><img src="http://assets.bloomingdales.com/navapp/img/nav/r09/botnav/botnav_shopping_services.gif" width="106" height="8" alt="Shopping Services" class="displayBlock" /></a></div> -->
<div class="bl_nav_bot_section_navigation_options" id="bot_nav_aboutUs"><a class="bot_nav_link" href="http://www1.bloomingdales.com/media/about/index.jsp?cm_sp=NAVIGATION-_-BOTTOM_NAV-_-ABOUT_US"><img src="http://assets.bloomingdales.com/navapp/img/nav/r09/botnav/botnav_about_us.gif" width="51" height="8" alt="About Us" class="displayBlock" /></a></div>
<div class="bl_nav_bot_section_navigation_options" id="bot_nav_careers"><a class="bot_nav_link" href="javascript:pop('http://www.retailology.com/bloomingdales/index_flash.asp?cm_sp=NAVIGATION-_-BOTTOM_NAV-_-CAREERS')"><img src="http://assets.bloomingdales.com/navapp/img/nav/r09/botnav/botnav_careers.gif" width="46" height="8" alt="Careers" class="displayBlock" /></a></div>
<div class="bl_nav_bot_section_navigation_options_last" id="bot_nav_email"><a class="bot_nav_link" href="https://www.bloomingdales.com/myinfo/register/index.ognc?cm_sp=NAVIGATION-_-BOTTOM_NAV-_-EMAIL_SIGNUP"><img src="http://assets.bloomingdales.com/navapp/img/nav/r09/botnav/botnav_email_sign_up.gif" width="75" height="8" alt="Email Sign-Up" class="displayBlock" /></a></div>
<div class="clearBoth"></div>
</div>
<div class="bl_nav_bot_service_like_no_other"><img src="http://assets.bloomingdales.com/navapp/img/nav/r09/botnav/like-no-other-store-in-world.gif" width="178" height="11" alt="Like No Other Store in the World" /></div>
<div class="bl_nav_bot_service_social_media">
<a href="http://www.facebook.com/Bloomingdales?cm_sp=NAVIGATION-_-BOTTOM_NAV-_-FACEBOOK" target="_blank"><img src="http://assets.bloomingdales.com/navapp/img/icons/facebook_off.gif" border="0" id="facebookIcon" onmouseover="facebookOver();" onmouseout="facebookBlur();" alt="Like Us on Facebook" title="Like Us on Facebook" /></a>&nbsp;
<a href="http://twitter.com/#!/BLOOMINGDALES?cm_sp=NAVIGATION-_-BOTTOM_NAV-_-TWITTER" target="_blank"><img src="http://assets.bloomingdales.com/navapp/img/icons/twitter_off.gif" border="0" id="twitterIcon" onmouseover="twitterOver();" onmouseout="twitterBlur();" alt="Follow Us on Twitter" title="Follow Us on Twitter" /></a>
</div>
<script type="text/javascript">
function facebookOver()
{
document.getElementById('facebookIcon').src = 'http://assets.bloomingdales.com/navapp/img/icons/facebook_on.gif';
}
function facebookBlur()
{
document.getElementById('facebookIcon').src = 'http://assets.bloomingdales.com/navapp/img/icons/facebook_off.gif';
}
function twitterOver()
{
document.getElementById('twitterIcon').src = 'http://assets.bloomingdales.com/navapp/img/icons/twitter_on.gif';
}
function twitterBlur()
{
document.getElementById('twitterIcon').src = 'http://assets.bloomingdales.com/navapp/img/icons/twitter_off.gif';
}
</script>
<div class="bl_nav_bot_service_container">
<a href="http://www1.bloomingdales.com/internationalContext/index.ognc?cm_sp=NAVIGATION-_-BOTTOM_NAV-_-INTERNATIONAL_SHOPPING" class="footer_link" id="iShip_link">International Shopping</a>&nbsp;&nbsp;&nbsp;
<a href="http://www1.bloomingdales.com/service/sitemap/index.ognc?cm_sp=NAVIGATION-_-BOTTOM_LINKS-_-SITE_MAP" class="footer_link">Site Map</a>&nbsp;&nbsp;&nbsp;
<!-- <a href="http://www1.bloomingdales.com/customerservice/international.jsp" class="footer_link" id="iShip_faq_footer_link">FAQ</a> -->
<a href="https://customerservice.bloomingdales.com/app/answers/detail/a_id/354/?cm_sp=NAVIGATION-_-BOTTOM_LINKS-_-SHIPPING_POLICY" class="footer_link" id="shipping_policy_footer_link">Shipping Policy</a>&nbsp;&nbsp;&nbsp;
<!--<a href="http://www1.bloomingdales.com/service/faq/index.jsp" class="footer_link" id="faq_footer_link">FAQ</a> &nbsp;&nbsp;&nbsp;-->
<a href="https://customerservice.bloomingdales.com/app/answers/detail/a_id/355/?cm_sp=NAVIGATION-_-BOTTOM_LINKS-_-PRODUCT_RECALL" class="footer_link">Product Recall</a>&nbsp;&nbsp;&nbsp;	
<a href="https://customerservice.bloomingdales.com/app/answers/detail/a_id/356/?cm_sp=NAVIGATION-_-BOTTOM_LINKS-_-LEGAL_NOTICES" class="footer_link">Legal Notice</a>&nbsp;&nbsp;&nbsp;
<a href="https://customerservice.bloomingdales.com/app/answers/detail/a_id/357/?cm_sp=NAVIGATION-_-BOTTOM_LINKS-_-PRIVACY_POLICY" class="footer_link">Privacy Policy</a>&nbsp;&nbsp;&nbsp;&nbsp;
<a href="https://customerservice.bloomingdales.com/app/answers/detail/a_id/358/?cm_sp=NAVIGATION-_-BOTTOM_LINKS-_-CA_PRIVACY_RIGHTS" class="footer_link" id="footer_link_CA">CA Privacy Rights</a>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="http://www1.bloomingdales.com/accessibility/start_en.html" class="footer_link">visually impaired customers</a> <a href="https://customerservice.bloomingdales.com/app/answers/detail/a_id/619" class="footer_link"><img src="http://assets.bloomingdales.com/navapp/img/nav/r09/botnav/EasyWebB.gif" alt="visually impaired customers essential accessibility" /></a> <a href="https://customerservice.bloomingdales.com/app/answers/detail/a_id/619" class="footer_link">essential accessibility</a>&trade; 
</div>
<div class="bl_nav_bot_service_container_2">
&copy; 2012 Bloomingdale's, Inc. 1000 Third Avenue New York, NY 10022. <a href="javascript:pop('http://www.macysinc.com/contact/general.aspx?cm_sp=NAVIGATION-_-BOTTOM_LINKS-_-CORP_NAME_ADDRESS')" class="footer_link">Request our corporate name and address</a>.
</div>
<script type='text/javascript'>
var _marinClientId = "qljqreuvj0";
var _marinProto = (("https:" == document.location.protocol) ? "https://" : "http://");
document.write(unescape("%3Cscript src='" + _marinProto + "tracker.marinsm.com/tracker/" +
_marinClientId + ".js' type='text/javascript'%3E%3C/script%3E"));
</script>
<script type='text/javascript'>
try {
_marinTrack.trackPage();
} catch(err) {}
</script>	
<noscript>
<div class="displayNone">
<img alt="" src="https://tracker.marinsm.com/tp?act=1&amp;cid=qljqreuvj0&amp;script=no" />
</div>
</noscript>	
</div>
<div>
<input type="hidden" id="blmCookieDomain" value=".bloomingdales.com" />
<input type="hidden" id="BLM_secureHostName" value="https://www.bloomingdales.com" />
<input type="hidden" id="BLM_baseHostName" value="http://www1.bloomingdales.com" />
<input type="hidden" id="BLM_assetsHostName" value="http://assets.bloomingdales.com/navapp" />
<input type="hidden" id="BLM_imageHostName" value="http://images.bloomingdales.com/is/image/BLM" />
</div>
<script type="text/javascript">
var pageSignature = "member";
</script>
</body>
<!--
Page: product - member
Secure: false
Request URI: /web20/catalog/tiles/pdpMemberSwitch.jsp
Server Physical Name: macyws324Node_B
Server Clone Name: bloomies-navapp_cluster1_macyws324_m02
CustomDate (Timestamp): 
Registry Type: 
JSP Page Encoding: 
Framework: Web20 (Spring/JSTL/Tiles)
Release Number: 12D
-->
<!-- 
Build Date: Thu Jun 14 15:40:20 PDT 2012 
NavApp Version:	2.7.7 
-->
</html>

ENDHTML
  end
end

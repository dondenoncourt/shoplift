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

end

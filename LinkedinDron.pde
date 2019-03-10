class LinkedinDron
  {
    WebDriver driver;
    JavascriptExecutor js;
    
    public LinkedinDron( String USERNAME, String PASSWORD )
      {
        driver = new FirefoxDriver();
        driver.manage().timeouts().setScriptTimeout( 5, TimeUnit.SECONDS );
        driver.manage().timeouts().pageLoadTimeout( 35, TimeUnit.SECONDS );
        
        js = ( JavascriptExecutor ) driver;
        
        driver.get( "https://www.linkedin.com/" );
        Sleep( 2000 );
        
        //Login to account
        try
          {
            driver.findElement( By.id( "login-email" ) ).sendKeys( USERNAME );
            
            Sleep( 4000 );
            
            driver.findElement( By.id( "login-password" ) ).sendKeys( PASSWORD );
          }
        catch( Exception e )
          {
          }
          
        ExecuteJavaScript( js, "document.getElementById( \"login-submit\" ).click();" );
      }
      
    int SearchBySchool( String SCHOOL )
      {
        char hash = ( char ) random( ( int ) 'a', ( int ) 'z' );
        driver.get( "https://www.linkedin.com/search/results/people/?facetNetwork=%5B\"S\"%5D&origin=FACETED_SEARCH&title="+hash+"&school="+SCHOOL );
        
        int s_alt = 0;
        
        try
          {
            Document doc = Jsoup.parse( driver.getPageSource() );
            
            String COMPANY_ID = ( doc.getElementsByClass( "search-result__result-link ember-view" ).get( 0 ).attr( "href" ).replace( "/company/", "" ).replace( "/", "" ) );
            
            
            Document search_result = Jsoup.parse( driver.getPageSource() );
            
            int s = search_result.getElementsByClass( "search-result__action-button search-result__actions--primary button-secondary-medium m5" ).size();
            
            for( int i = 0; i < s; i++ )
              {
                ExecuteJavaScript( js, "document.getElementsByClassName( \"search-result__action-button search-result__actions--primary button-secondary-medium m5\" )["+i+"].click()" );
                ExecuteJavaScript( js, "document.getElementsByClassName( \"button-primary-large ml1\" )[ 0 ].click()" );
                s_alt++;
              }
              
            return s;
          }
        catch( Exception e )
          {
            return s_alt;
          }
      }
      
    void AddTotalAtSchool( String SCHOOL, int total )
      {
        int current = 0;
        
        while( current < total )
          {
            current += SearchBySchool( SCHOOL );
          }
      }
      
    void SearchByCompany( String COMPANY, String TITLE )
      {
        driver.get( "https://www.linkedin.com/search/results/companies/?keywords="+COMPANY.replace( " ", "+" )+"&origin=GLOBAL_SEARCH_HEADER" );
        
        try
          {
            Document doc = Jsoup.parse( driver.getPageSource() );
            
            String COMPANY_ID = ( doc.getElementsByClass( "search-result__result-link ember-view" ).get( 0 ).attr( "href" ).replace( "/company/", "" ).replace( "/", "" ) );
            
            driver.get( "https://www.linkedin.com/search/results/people/?facetCurrentCompany=%5B%22" + COMPANY_ID + "%22%5D&facetNetwork=%5B%22S%22%5D&origin=FACETED_SEARCH&title="+TITLE );
            
            Document search_result = Jsoup.parse( driver.getPageSource() );
            
            int s = search_result.getElementsByClass( "search-result__action-button search-result__actions--primary button-secondary-medium m5" ).size();
            
            for( int i = 0; i < s; i++ )
              {
                ExecuteJavaScript( js, "document.getElementsByClassName( \"search-result__action-button search-result__actions--primary button-secondary-medium m5\" )["+i+"].click()" );
                ExecuteJavaScript( js, "document.getElementsByClassName( \"button-primary-large ml1\" )[ 0 ].click()" );
              }
          }
        catch( Exception e )
          {
          }
      }
      
    void AddConnections()
      {
        driver.get( "https://www.linkedin.com/mynetwork/" );
        Sleep( 2000 );
        ExecuteJavaScript( js, "window.scrollBy( 0, 500 )" );
        ExecuteJavaScript( js, "window.scrollBy( 0, 500 )" );
        ExecuteJavaScript( js, "window.scrollBy( 0, 500 )" );
        
        for( int i = 0; i < 20; i++ )
          {
            Sleep( 5000 );
            
            try
              {
                 Document doc = Jsoup.parse( driver.getPageSource() );
                 PrintWriter out = new PrintWriter(new BufferedWriter(new FileWriter("ConnectionsSentVladim.csv", true)));
                 out.println( doc.getElementsByClass( "mn-discovery-person-card__name--with-coverphoto t-16 t-black t-bold" ).get( 0 ).text() );
                 out.close();
              }
            catch( Exception e )
              {
              }
            
            ExecuteJavaScript( js, "document.getElementsByClassName( \"js-mn-discovery-person-card__action-btn full-width artdeco-button artdeco-button--2 artdeco-button--full artdeco-button--secondary ember-view\" )[0].click();" );
          }
      }
      
    void ScrapeConnections()
      {
        Sleep( 15000 );
        ExecuteJavaScript( js, "window.ScrollTo( 0, 2000 );" );
        //Visit My Profile
        ExecuteJavaScript( js, "document.getElementsByClassName( \"tap-target profile-rail-card__actor-link block link-without-hover-visited ember-view\" )[ 0 ].click();" );
        
        Sleep( 15000 );
        
        //View My Connections
        ExecuteJavaScript( js, "document.getElementsByClassName( \"pv-top-card-v2-section__link pv-top-card-v2-section__link--connections ember-view\" )[0].click();" );
        //pv-contact-info__hepader t-16 t-black t-bold data type
        //
        //view connections
        Sleep( 15000 );
        
        int file_count = 0;
        
        try
          {
            String URL = driver.getCurrentUrl();
            
            for( int xi = 0; xi < 66; xi++ )
              {
                try
                  {
                    driver.get( URL + "&page=" + xi );
                  }
                catch( Exception e )
                  {
                  }
                  
                try
                  {
                    Sleep( 5000 );
                    
                    try
                      {
                        Document doc_scroll2 = Jsoup.parse( driver.getPageSource() );
                        Elements divs2 = doc_scroll2.getElementsByTag( "div" );
                        driver.manage().timeouts().setScriptTimeout( 50, TimeUnit.MILLISECONDS );
                        
                        for( Element div : divs2 )
                          {
                            if( div.attr( "id" ).contains( "ember" ) )
                              {
                                ExecuteJavaScript( js, "document.getElementById( \"" + div.attr( "id" ) + "\" ).scrollIntoView();" );
                              }
                          }
                        
                        driver.manage().timeouts().setScriptTimeout( 5, TimeUnit.SECONDS );
                      }
                    catch( Exception e )
                      {
                      }
                    
                    Document doc = Jsoup.parse( driver.getPageSource() );
                    
                    int count = doc.getElementsByClass( "search-result__result-link ember-view" ).size();
                    
                    for( int i = 0; i < count; i+=2 )
                      {
                        Document doc_scroll3 = Jsoup.parse( driver.getPageSource() );
                        Elements divs3 = doc_scroll3.getElementsByTag( "div" );
                        driver.manage().timeouts().setScriptTimeout( 50, TimeUnit.MILLISECONDS );
                        
                        for( Element div : divs3 )
                          {
                            if( div.attr( "id" ).contains( "ember" ) )
                              {
                                ExecuteJavaScript( js, "document.getElementById( \"" + div.attr( "id" ) + "\" ).scrollIntoView();" );
                              }
                          }
                        
                        driver.manage().timeouts().setScriptTimeout( 5, TimeUnit.SECONDS );
                        
                        ExecuteJavaScript( js, "document.getElementsByClassName( \"search-result__result-link ember-view\" )["+i+"].click();" );
                        Thread.sleep( 10000 );
                        
                        Document doc_scroll = Jsoup.parse( driver.getPageSource() );
                        
                        Elements divs = doc_scroll.getElementsByTag( "div" );
                        driver.manage().timeouts().setScriptTimeout( 100, TimeUnit.MILLISECONDS );
                        
                        for( Element div : divs )
                          {
                            if( div.attr( "id" ).contains( "ember" ) )
                              {
                                ExecuteJavaScript( js, "document.getElementById( \"" + div.attr( "id" ) + "\" ).scrollIntoView();" );
                              }
                          }
                          
                        driver.manage().timeouts().setScriptTimeout( 5, TimeUnit.SECONDS );
                        
                        Thread.sleep( 5000 );
                        
                        Document doc_profile = Jsoup.parse( driver.getPageSource() );
                        String Name = "";
                        String Location = "";
                        String Skill1 = "";
                        String Skill2 = "";
                        String Skill3 = "";
                        String School = "";
                        String DegreeRank = "";
                        String DegreeType = "";
                        String Position = "";
                        String Company = "";
                        String DatesEmployed = "";
                        
                        try
                          {
                            Name = doc_profile.getElementsByClass( "pv-top-card-section__name inline t-24 t-black t-normal" ).get( 0 ).text();
                          }
                        catch( Exception e )
                          {
                            
                          }
                          
                        try
                          {
                            Location = doc_profile.getElementsByClass( "pv-top-card-section__location t-16 t-black--light t-normal mt1 inline-block" ).get( 0 ).text();
                          }
                        catch( Exception e )
                          {
                            
                          }
                        
                        try
                          {
                            Skill1 = doc_profile.getElementsByClass( "pv-skill-category-entity__name-text t-16 t-black t-bold" ).get( 0 ).text();
                          }
                        catch( Exception e )
                          {
                            
                          }
                          
                        try
                          {
                            Skill2 = doc_profile.getElementsByClass( "pv-skill-category-entity__name-text t-16 t-black t-bold" ).get( 1 ).text();
                          }
                        catch( Exception e )
                          {
                            
                          }
                          
                        try
                          {
                            Skill3 = doc_profile.getElementsByClass( "pv-skill-category-entity__name-text t-16 t-black t-bold" ).get( 2 ).text();
                          }
                        catch( Exception e )
                          {
                            
                          }
                          
                        try
                          {
                            School = doc_profile.getElementsByClass( "pv-entity__school-name t-16 t-black t-bold" ).get( 0 ).text();
                          }
                        catch( Exception e )
                          {
                          }
                          
                        try
                          {
                            //document.getElementsByClassName( "pv-entity__secondary-title pv-entity__degree-name pv-entity__secondary-title t-14 t-black t-normal" )[ 0 ].getElementsByClassName( "pv-entity__comma-item" )[ 0 ].textContent = degree rank
                            DegreeRank = doc_profile.getElementsByClass( "pv-entity__secondary-title pv-entity__degree-name pv-entity__secondary-title t-14 t-black t-normal" ).get( 0 ).getElementsByClass( "pv-entity__comma-item" ).get( 0 ).text();
                          }
                        catch( Exception e )
                          {
                          }
                          
                        try
                          {//document.getElementsByClassName( "pv-entity__secondary-title pv-entity__fos pv-entity__secondary-title t-14 t-black--light t-normal" )[ 0 ].getElementsByClassName( "pv-entity__comma-item" )[ 0 ].textContent = degree type
                            DegreeType = doc_profile.getElementsByClass( "pv-entity__secondary-title pv-entity__fos pv-entity__secondary-title t-14 t-black--light t-normal" ).get( 0 ).getElementsByClass( "pv-entity__comma-item" ).get( 0 ).text();
                          }
                        catch( Exception e )
                          {
                          }
                          
                        try
                          {
                            //document.getElementsByClassName( "pv-entity__summary-info pv-entity__summary-info--background-section " )[ 0 ].getElementsByClassName( "t-16 t-black t-bold" )[ 0 ].textContent = Position at company
                            Position = doc_profile.getElementsByClass( "pv-profile-section__card-item-v2 pv-profile-section pv-position-entity ember-view" ).get( 0 ).getElementsByClass( "t-16 t-black t-bold" ).get( 0 ).text();
                          }
                        catch( Exception e )
                          {
                            
                          }
                        
                        try
                          {
                            Company = doc_profile.getElementsByClass( "pv-profile-section__card-item-v2 pv-profile-section pv-position-entity ember-view" ).get( 0 ).getElementsByClass( "pv-entity__secondary-title" ).get( 0 ).text().replace( "Company Name", "" );
                          }
                        catch( Exception e )
                          {
                            
                          }
                          
                        try
                          {
                            DatesEmployed = doc_profile.getElementsByClass( "pv-profile-section__card-item-v2 pv-profile-section pv-position-entity ember-view" ).get( 0 ).getElementsByClass( "pv-entity__date-range t-14 t-black--light t-normal" ).get( 0 ).getElementsByTag( "span" ).get( 1 ).text();
                          }
                        catch( Exception e )
                          {
                            
                          }
                        
                        ExecuteJavaScript( js, "document.getElementsByClassName( \"pv-top-card-v2-section__link pv-top-card-v2-section__link--contact-info mb1 ember-view\" )[ 0 ].click()" );
                        
                        String Birthday = "";
                        String Phone = "";
                        String PhoneTapered = "";
                        String Email = "";
                        String Linkedin = driver.getCurrentUrl();
                        
                        Thread.sleep( 5000 );
                        
                        Document doc_contact = Jsoup.parse( driver.getPageSource() );
                        
                        //pv-contact-info__contact-type ci-birthday
                        //pv-contact-info__contact-type ci-phone
                        //pv-contact-info__contact-type ci-email
                        //document.getElementsByClassName( "pv-contact-info__contact-type ci-email" )[0].getElementsByClassName( "t-14 t-black t-normal" )[ 0 ].textContent
                        
                        try
                          {
                            Birthday = doc_contact.getElementsByClass( "pv-contact-info__contact-type ci-birthday" ).get( 0 ).getElementsByClass( "pv-contact-info__contact-item t-14 t-black t-normal" ).get( 0 ).text();
                          }
                        catch( Exception e )
                          {
                          }
                          
                        try
                          {
                            Phone = doc_contact.getElementsByClass( "pv-contact-info__contact-type ci-phone" ).get( 0 ).getElementsByClass( "t-14 t-black t-normal" ).get( 0 ).text();
                            
                            PhoneTapered = Phone.replaceAll("[^\\d.]", "").replace( ".", "" );
                            
                            if( PhoneTapered.length() > 10 )
                              {
                                PhoneTapered = PhoneTapered.substring( 0, 10 );
                              }
                          }
                        catch( Exception e )
                          {
                          }
                          
                        try
                          {
                            Email = doc_contact.getElementsByClass( "pv-contact-info__contact-type ci-email" ).get( 0 ).getElementsByClass( "pv-contact-info__ci-container" ).get( 0 ).text();
                          }
                        catch( Exception e )
                          {
                          }
                        
                        
                        String FIRMOGRAPHIC = "";
                        JSONObject FIRMO_;
                        //getDomainContactDetails.getConatctDetailsForSingleDomain( FIRMO_.getString( "website" ), "" )
                        
                        try
                          {
                            JSONObject TEST = loadJSONObject( "COMPANIES/"+Company.replace( ",", "" ) + ".json" );
                            FIRMOGRAPHIC = TEST.toString();
                            FIRMO_ = TEST;
                          }
                        catch( Exception e )
                          {
                            FIRMOGRAPHIC = GetCrunchBase( Company.replace( ",", "" ) );
                            FIRMO_ = parseJSONObject( FIRMOGRAPHIC );
                          }
                        
                        JSONObject SEARCH_ENGINE = getDomainContactDetails.getConatctDetailsForSingleDomain( FIRMO_.getString( "website" ), "" );
                        
                        JSONObject DEMOGRAPHIC = new JSONObject();
                        
                        try
                          {
                            DEMOGRAPHIC.setString( "Name", Name.replace( ",", "" ) );
                            DEMOGRAPHIC.setString( "Gender Estimate", GetGender( Name.replace( ",", "" ).split( " " )[ 0 ] ) );
                            DEMOGRAPHIC.setDouble( "Age Estimate", GetAge( Name.replace( ",", "" ).split( " " )[ 0 ] ) );
                          }
                        catch( Exception e )
                          {
                          }
                          
                        try
                          {
                            JSONObject CONTACT = new JSONObject();
                            CONTACT.setString( "Phone Tapered", PhoneTapered );
                            CONTACT.setString( "Phone Full", Phone.replace( ",", "" ) );
                            CONTACT.setString( "Email", Email.replace( ",", "" ) );
                            CONTACT.setString( "Email", Linkedin.replace( ",", "" ) );
                            
                            DEMOGRAPHIC.setJSONObject( "Contact", CONTACT );
                          }
                        catch( Exception e )
                          {
                          }
                          
                        try
                          {
                            try
                              {
                                JSONObject PR = GetPublicRecords( PhoneTapered );
                                String ADDRESS = PR.getJSONArray( "Past Addresses" ).getJSONObject( 0 ).getString( "Address" );
                                
                                String value = GIS.searchPosition( Position, ADDRESS.split( ", " )[ 1 ].split( " " )[ 0 ] );
                                
                                DEMOGRAPHIC.setJSONObject( "Public Records Info", PR );
                              }
                            catch( Exception e )
                              {
                                
                              }
                              
                            DEMOGRAPHIC.setString( "Birthday", Birthday );
                            DEMOGRAPHIC.setString( "Location", Location );
                          }
                        catch( Exception e )
                          {
                          }
                          
                        try
                          {
                            JSONObject SKILLS = new JSONObject();
                            
                            SKILLS.setString( "Skill #1", Skill1 );
                            SKILLS.setString( "Skill #2", Skill2 );
                            SKILLS.setString( "Skill #3", Skill3 );
                            
                            DEMOGRAPHIC.setJSONObject( "Skills", SKILLS );
                          }
                        catch( Exception e )
                          {
                          }
                          
                        try
                          {
                            JSONObject EDU = new JSONObject();
                            
                            EDU.setString( "School", School.replace( ",", "" ) );
                            EDU.setString( "Degree", DegreeRank.replace( ",", "" ) );
                            EDU.setString( "Field", DegreeType.replace( ",", "" ) );
                            
                            DEMOGRAPHIC.setJSONObject( "Education", EDU );
                          }
                        catch( Exception e )
                          {
                          }
                          
                        try
                          {
                            JSONObject EMPLOYMENT = new JSONObject();
                            
                            EMPLOYMENT.setString( "Position", Position.replace( ",", "" ) );
                            EMPLOYMENT.setString( "Company", Company.replace( ",", "" ) );
                            EMPLOYMENT.setString( "Dates Employed", DatesEmployed.replace( ",", "" ) );
                            
                            DEMOGRAPHIC.setJSONObject( "Employement", EMPLOYMENT );
                          }
                        catch( Exception e )
                          {
                          }
                          
                        try
                          {
                            JSONObject USER_DATA = new JSONObject();
                            USER_DATA.setJSONObject( "Demographic", DEMOGRAPHIC );
                            USER_DATA.setJSONObject( "Firmographic", FIRMO_ );
                            USER_DATA.setJSONObject( "SEO Data", SEARCH_ENGINE );
                            saveJSONObject( USER_DATA, "executives/" + file_count+"_record.json" );
                          }
                        catch( Exception e )
                          {
                          }
                        
                        file_count++;
                        
                        ExecuteJavaScript( js, "history.back()" );
                        ExecuteJavaScript( js, "history.back()" );
                        
                        //basic data
                        //[x] document.getElementsByClassName( "pv-top-card-section__name inline t-24 t-black t-normal" )[ 0 ].textContent = name
                        //document.getElementsByClassName( "pv-top-card-section__headline mt1 t-18 t-black t-normal" )[ 0 ].textContent = position at company
                        //[x]document.getElementsByClassName( "pv-top-card-section__location t-16 t-black--light t-normal mt1 inline-block" )[ 0 ].textContent = location
                        
                        //skills
                        //document.getElementsByClassName( "pv-skill-category-entity__name-text t-16 t-black t-bold" )[ 0 ].textContent = skill
                        //document.getElementsByClassName( "pv-skill-category-entity__name-text t-16 t-black t-bold" ).length = number of skills
                        
                        //education data
                        //document.getElementsByClassName( "pv-entity__school-name t-16 t-black t-bold" )[ 0 ].textContent = school
                        //document.getElementsByClassName( "pv-entity__secondary-title pv-entity__degree-name pv-entity__secondary-title t-14 t-black t-normal" )[ 0 ].getElementsByClassName( "pv-entity__comma-item" )[ 0 ].textContent = degree rank
                        //document.getElementsByClassName( "pv-entity__secondary-title pv-entity__fos pv-entity__secondary-title t-14 t-black--light t-normal" )[ 0 ].getElementsByClassName( "pv-entity__comma-item" )[ 0 ].textContent = degree type
                        //document.getElementsByClassName( "pv-entity__secondary-title pv-entity__fos pv-entity__secondary-title t-14 t-black--light t-normal" ) = number of degrees
                        
                        //employment history data
                        //document.getElementsByClassName( "pv-entity__summary-info pv-entity__summary-info--background-section " )[ 0 ].getElementsByClassName( "t-16 t-black t-bold" )[ 0 ].textContent = Position at company
                        //document.getElementsByClassName( "pv-entity__summary-info pv-entity__summary-info--background-section " )[ 0 ].getElementsByClassName( "pv-entity__secondary-title" )[ 0 ].textContent = Company
                        //document.getElementsByClassName( "pv-entity__summary-info pv-entity__summary-info--background-section " )[ 0 ].getElementsByClassName( "pv-entity__date-range t-14 t-black--light t-normal" )[ 0 ].getElementsByTagName( "span" )[ 1 ].textContent = dates employed at company
                        //document.getElementsByClassName( "pv-entity__summary-info pv-entity__summary-info--background-section " )[ 0 ].getElementsByClassName( "pv-entity__bullet-item-v2" )[ 0 ].textContent = times employed
                        //document.getElementsByClassName( "pv-entity__summary-info pv-entity__summary-info--background-section " )[ 0 ].getElementsByClassName( "pv-entity__location t-14 t-black--light t-normal block" )[ 0 ].getElementsByTagName( "span" )[ 1 ].textContent = location employed
                        //document.getElementsByClassName( "pv-entity__location t-14 t-black--light t-normal block" ).length = number of past postions
                        
                        //click contact info view
                        //document.getElementsByClassName( "pv-top-card-v2-section__link pv-top-card-v2-section__link--contact-info mb1 ember-view" )[ 0 ].click()
                        
                      }
                      
                    Document doc_scroll3 = Jsoup.parse( driver.getPageSource() );
                    Elements divs3 = doc_scroll3.getElementsByTag( "div" );
                    driver.manage().timeouts().setScriptTimeout( 50, TimeUnit.MILLISECONDS );
                    
                    for( Element div : divs3 )
                      {
                        if( div.attr( "id" ).contains( "ember" ) )
                          {
                            ExecuteJavaScript( js, "document.getElementById( \"" + div.attr( "id" ) + "\" ).scrollIntoView();" );
                          }
                      }
                    
                    driver.manage().timeouts().setScriptTimeout( 5, TimeUnit.SECONDS );
                    
                    ExecuteJavaScript( js, "document.getElementsByClassName( \"next\" )[0].click();" );
                  }
                catch( Exception e )
                  {
                    e.printStackTrace();
                  }
              }
          }
        catch( Exception e )
          {
            e.printStackTrace();
          }
      }
  }

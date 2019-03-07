String CheckNumber( String number )
  {
    try
      {
        Document doc = Jsoup.connect( "https://www.ivycall.com/" + number ).get();
        String name = doc.getElementsByClass( "row content-1" ).first().text().replace( "Name : ", "" );
        String addy = "";
        //.proxy( Rotate().replace( ":80", "" ), 80 )
        try
          {
            addy = doc.getElementsByClass( "col-md-12 col-sm-12 location-info" ).first().text().replace( "Address : ", "" );
          }
        catch( Exception e )
          {
          }
          
        if( name.length() > 3 )
          {
            name = name.replace( ",", "" );
            name = name.replace( "Ms", "" );
            name = name.replace( "Mr", "" );
            
            if( name.split( " " )[ 0 ].equals( "Ms" ) || name.split( " " )[ 0 ].equals( "Mr" ) )
              return (  name + "," + addy.replace( ",", "" ) );
            else
              return (  name + "," + addy.replace( ",", "" ) );
              
          }
        else
          {
            return ",";
          }
      }
    catch( Exception e )
      {
        return ",";
      }
  }
  
  
String GetGender( String name )
  {
    String Name = ( name.substring( 0, 1 ).toUpperCase()+name.substring( 1, name.length() ).toLowerCase() );
    
    try
      {
        double MaleCount = 0;
        double FemaleCount = 0;
        
        Document doc = Jsoup.connect( "https://rhiever.github.io/name-age-calculator/names/M/"+name.substring( 0, 1 ).toUpperCase()+"/"+Name+".txt" ).get();
        
        String Ages[] = doc.text().split( "," );
        
        double mean_age = 0;
        
        for( int i = 4; i < Ages.length; i+=2 )
          {
            if( Ages[ i ].contains( " " ) )
              {
                //println( Double.parseDouble( ( Ages[ i ].split( " " )[ 0 ] ) ) );
                mean_age += Double.parseDouble( Ages[ i ].split( " " )[ 0 ] );
              }
            else
              {
              }
          }
          
        MaleCount = mean_age;
          
        doc = Jsoup.connect( "https://rhiever.github.io/name-age-calculator/names/F/"+name.substring( 0, 1 ).toUpperCase()+"/"+Name+".txt" ).get();
        
        String Ages2[] = doc.text().split( "," );
        
        double mean_age2 = 0;
        
        for( int i = 4; i < Ages2.length; i+=2 )
          {
            if( Ages2[ i ].contains( " " ) )
              {
                //println( Double.parseDouble( ( Ages[ i ].split( " " )[ 0 ] ) ) );
                mean_age2 += Double.parseDouble( Ages2[ i ].split( " " )[ 0 ] );
              }
            else
              {
              }
          }
          
        FemaleCount = mean_age2;
        
        if( MaleCount > FemaleCount )
          return "M";
        else
          return "F";
      }
    catch( Exception e )
      {
        return "NULL";
      }
  }

double GetAge( String name )
  {
    String Name = ( name.substring( 0, 1 ).toUpperCase()+name.substring( 1, name.length() ).toLowerCase() );
    
    try
      {
        Document doc = Jsoup.connect( "https://rhiever.github.io/name-age-calculator/names/" +GetGender( name ) + "/"+name.substring( 0, 1 ).toUpperCase()+"/"+Name+".txt" ).get();
        
        String Ages[] = doc.text().split( "," );
        
        double mean_age = 0;
        double n = 0;
        
        for( int i = 4; i < Ages.length; i+=2 )
          {
            if( Ages[ i ].contains( " " ) )
              {
                //println( Double.parseDouble( ( Ages[ i ].split( " " )[ 0 ] ) ) );
                mean_age += Double.parseDouble( Ages[ i ].split( " " )[ 0 ] )*Double.parseDouble( Ages[ i-2 ].split( " " )[ 1 ] );
                n += Double.parseDouble( Ages[ i ].split( " " )[ 0 ] );
              }
            else
              {
              }
          }
          
        return year()-( mean_age/n );
          
      }
    catch( Exception e )
      {
        return -1;
      }
  }
  
JSONObject GetPublicRecords( String NUMB )
  {
    try
      {
        String PHONE_ = NUMB.substring( 0, 3 ) + "-" + NUMB.substring( 3, 6 ) + "-" + NUMB.substring( 6, 10 );
        
        WebDriver driver;
        JavascriptExecutor js;
        
        driver = new FirefoxDriver();
        driver.manage().timeouts().setScriptTimeout( 5, TimeUnit.SECONDS );
        driver.manage().timeouts().pageLoadTimeout( 35, TimeUnit.SECONDS );
        
        js = ( JavascriptExecutor ) driver;
        driver.get( "https://www.fastpeoplesearch.com/"+PHONE_ );
        
        JSONObject PUBLIC_RECORD = new JSONObject();
        
        try
          {
            Document doc = Jsoup.parse( driver.getPageSource() );
            String PERSON_URL = ( doc.toString().split( "\"@id\": \"" )[ 1 ].split( "\"" )[ 0 ] );
            
            driver.get( PERSON_URL );
            
            Document doc2 = Jsoup.parse( driver.getPageSource() );
            
            PUBLIC_RECORD.setString( "Name", doc2.getElementById( "details-header" ).text().split( "Age" )[ 0 ] );
            PUBLIC_RECORD.setString( "Age", doc2.getElementById( "details-header" ).text().split( "Age" )[ 1 ] );
            
            try
              {
                JSONArray PAST_ADDRESSES = new JSONArray();
                
                int i_ = 0;
                
                for( Element ADDRESS : doc2.getElementsByClass( "address-link" ) )
                  {
                    JSONObject ADDY = new JSONObject();
                    
                    try
                      {
                        println( ADDRESS.text() );
                        if( ADDRESS.text().contains( "(" ) )
                          {
                            ADDY.setString( "Address", ADDRESS.text().split( "\\(" )[ 0 ] );
                            ADDY.setString( "Move In", ADDRESS.text().split( "\\(" )[ 1 ].split( "-" )[ 0 ] );
                            ADDY.setString( "Move Out", ADDRESS.text().split( "\\(" )[ 1 ].split( "-" )[ 1 ].replace( ")", "" ) );
                          }
                        else
                          {
                            ADDY.setString( "Address", ADDRESS.text() );
                          }
                      }
                    catch( Exception e )
                      {
                      }
                    PAST_ADDRESSES.setJSONObject( i_, ADDY );
                    i_++;
                  }
                  
                //println( doc2.getElementById( "details-header" ).text() );
                //println( doc2.getElementsByClass( "address-link" ).get( 0 ).text();
                
                PUBLIC_RECORD.setJSONArray( "Past Addresses", PAST_ADDRESSES );
              }
            catch( Exception e )
              {
              }
              
            try
              {
                JSONObject PHONES_LIST = new JSONObject();
                
                Elements PHONES = doc2.getElementsByClass( "detail-box-phone" ).get( 0 ).getElementsByTag( "a" );
                
                //Elements PHONES_COLLAPSED = doc2.getElementsByClass( "collapse-phone-links" ).get( 0 ).getElementsByTag( "a" );
                
                int inc = 0;
                
                for( Element PHONE : PHONES )
                  {
                    PHONES_LIST.setString( "Phone "+inc, PHONE.text().replace( "Show More...", "" ) );
                    inc++;
                  }
                 /* 
                for( Element PHONE : PHONES_COLLAPSED )
                  {
                    PHONES_LIST.setString( "Phone "+inc, PHONE.text() );
                    inc++;
                  }
                  */
                PUBLIC_RECORD.setJSONObject( "Phone List", PHONES_LIST );
              }
            catch( Exception e )
              {
              }
              
            JSONObject EMAILS_ = new JSONObject();
                
            try
              {
                Elements EMAILS1 = doc2.getElementsByClass( "detail-box-email" ).get( 0 ).getElementsByTag( "p" );
                //Elements EMAILS2 = doc2.getElementsByClass( "collapsed-emails" ).get( 0 ).getElementsByTag( "p" );
                
                int EMAIL___ = 0;
                
                for( Element EMAIL : EMAILS1 )
                  {
                    EMAILS_.setString( "Email" + EMAIL___, EMAIL.text() );
                    EMAIL___++;
                  }
                
              }
            catch( Exception e )
              {
              }
              
            try
              {
                Elements EMAILS2 = doc2.getElementById( "collapsed-emails" ).getElementsByTag( "p" );
                int EMAIL___ = 0;
                
                
                for( Element EMAIL : EMAILS2 )
                  {
                    EMAILS_.setString( "Email" + EMAIL___, EMAIL.text() );
                    EMAIL___++;
                  }
                
              }
            catch( Exception e )
              {
                
              }
            PUBLIC_RECORD.setJSONObject( "All Emails", EMAILS_ );
          }
        catch( Exception e )
          {
          }
        driver.close();
        
        return PUBLIC_RECORD;
      }
    catch( Exception e )
      {
        return ( new JSONObject() );
      }
  }

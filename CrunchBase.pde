String GetCrunchBase( String COMPANY )
  {
    // if required from bing
    profileUrl = crunchObj.getBingSearch( COMPANY.toLowerCase(), 0 );
    if( !profileUrl.equals( "" ) && !profileUrl.equals( "BROKEN" ) )
      {
        crunchObj.openProfile(profileUrl);
        startProcess();
      }
      
    
    Gson gson = new Gson(); 
    String json = gson.toJson( result ); 
    
    JSONObject CRUNCH_PROFILE = parseJSONObject( json );
    
    saveJSONObject( CRUNCH_PROFILE, "COMPANIES/"+COMPANY.toLowerCase() + ".json" );
    
    return ( CRUNCH_PROFILE.toString() );
  }

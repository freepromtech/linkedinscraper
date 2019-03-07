
public void startProcess() {
  try {
    String catagories = crunchObj.getCatagories();
    result.put("catagories", catagories);
    String employeeCount = crunchObj.getEmployeeCount();
    result.put("employeeCount", employeeCount);
    String companyType = crunchObj.getCompanyType();
    result.put("companyType", companyType);
    String website = crunchObj.getWebsite();
    result.put("website", website);
    String facebookLink = crunchObj.getFacebookLink();
    result.put("facebookLink", facebookLink);
    String twitterLink = crunchObj.getTwitterLink();
    result.put("twitterLink", twitterLink);
    String email = crunchObj.getEmail();
    result.put("email", email);
    String phone = crunchObj.getPhone();
    result.put("phone", phone);
    
    try
      {
        List<List<String>> fundingData = crunchObj.getFundingData();
        
        JSONObject FUNDING = new JSONObject();
        
        for( List<String> FUNDINGDATA : fundingData )
          {
            FUNDING.setString( ( String ) FUNDINGDATA.get( 0 ), ( String ) FUNDINGDATA.get( 3 ) );
          }
          
        result.put("fundingData", FUNDING.toString());
      }
    catch( Exception e )
      {
      }
      
    try
      {
        List<String> techStack = crunchObj.getTechStack(profileUrl);
        
        JSONArray TECHSTACK = new JSONArray();
        
        int indd = 0;
        
        for( String TECH_ : techStack )
          {
            JSONObject TECHNOLOGY = new JSONObject();
            TECHNOLOGY.setString( "Technology", TECH_ );
            TECHSTACK.setJSONObject( indd, TECHNOLOGY );
            indd++;
          }
          
        result.put("techStack", TECHSTACK.toString());
      }
    catch( Exception e )
      {
      }
    
    try
      {
        List<String> websiteTechStackCurrent = crunchObj.getWebsiteTechStackCurrent(profileUrl);

        List<String> websiteTechStackRemoved = crunchObj.getWebsiteTechStackRemoved();
    
        JSONObject TECHSTACK = new JSONObject();
        
        int indd = 0;
        
        for( String TECHSTACK_CURRENT : websiteTechStackCurrent )
          {
            TECHSTACK.setString( "Technology " + indd, TECHSTACK_CURRENT );
            indd++;
          }
          
        JSONObject TECHSTACKPAST = new JSONObject();
        
        indd = 0;
        
        for( String TECHSTACK_CURRENT : websiteTechStackRemoved )
          {
            TECHSTACKPAST.setString( "Technology " + indd, TECHSTACK_CURRENT );
            indd++;
          }
          
        result.put("Tech Stack CURRENT", TECHSTACK.toString());
        result.put("Tech Stack Past", TECHSTACKPAST.toString());
      }
    catch( Exception e )
      {
      }
      
    JSONObject WEBSITE_DATA = new JSONObject();
    
    String monthlyWebsiteVisits = crunchObj.getMonthlyWebsiteVisits(profileUrl);
    String monthlyWebsiteVisitsGrowth = crunchObj.getMonthlyWebsiteVisitsGrowth(profileUrl);
    String monthlyWebsiteVisitDuration = crunchObj.getMonthlyWebsiteVisitDuration(profileUrl);
    String monthlyWebsiteVisitBounceRate = crunchObj.getMonthlyWebsiteVisitBounceRate();
    String monthlyWebsiteVisitPageViewsPerVisit = crunchObj.getMonthlyWebsiteVisitPageViewsPerVisit();
    
    WEBSITE_DATA.setString("monthlyWebsiteVisits", monthlyWebsiteVisits);
    WEBSITE_DATA.setString("monthlyWebsiteVisitsGrowth", monthlyWebsiteVisitsGrowth);
    WEBSITE_DATA.setString("monthlyWebsiteVisitDuration", monthlyWebsiteVisitDuration);
    WEBSITE_DATA.setString("monthlyWebsiteVisitBounceRate", monthlyWebsiteVisitBounceRate);
    WEBSITE_DATA.setString("monthlyWebsiteVisitPageViewsPerVisit", monthlyWebsiteVisitPageViewsPerVisit);
    
    
    List<String> bomboraSignals = crunchObj.getBomboraSignals();
    
    JSONObject BOMB = new JSONObject();
    
    int xxx_= 1;
    
    for( String BOMB_ : bomboraSignals )
      {
        BOMB.setString( "Intent Data "+xxx_, BOMB_ );
        xxx_++;
      }
      
    result.put("Firmographic Intent", BOMB.toString());
    String owlerRevenue = crunchObj.getOwlerRevenue(profileUrl);
    result.put("owlerRevenue", "" + StandardizeMonetaryQuantity( owlerRevenue ) );
    String iTSpend = crunchObj.getITSpend(profileUrl);
    
    JSONObject IT_SPEND_DATA = new JSONObject();
    
    String iTSpendSoftwareSpend = crunchObj.getITSpendSoftwareSpend();
    String iTSpendCommunicationsSpend = crunchObj.getITSpendCommunicationsSpend(profileUrl);
    String iTSpendServicesSpend = crunchObj.getITSpendServicesSpend();
    String iTSpendServerSpend = crunchObj.getITSpendServerSpend();
    String iTSpendPCSpend = crunchObj.getITSpendPCSpend();
    String iTSpendStorageSpend = crunchObj.getITSpendStorageSpend();
    String iTSpendOtherHardwareSpend = crunchObj.getITSpendOtherHardwareSpend();
    String iTSpendOtherITSpend = crunchObj.getITSpendOtherITSpend();
    
    IT_SPEND_DATA.setString("iTSpend", ""+StandardizeMonetaryQuantity( iTSpend ) );
    IT_SPEND_DATA.setString("iTSpendSoftwareSpend", ""+StandardizeMonetaryQuantity( iTSpendSoftwareSpend ) );
    IT_SPEND_DATA.setString("iTSpendCommunicationsSpend", ""+StandardizeMonetaryQuantity( iTSpendCommunicationsSpend ) );
    IT_SPEND_DATA.setString("iTSpendServicesSpend", ""+StandardizeMonetaryQuantity( iTSpendServicesSpend ) );
    IT_SPEND_DATA.setString("iTSpendServerSpend", ""+StandardizeMonetaryQuantity( iTSpendServerSpend ) );
    IT_SPEND_DATA.setString("iTSpendPCSpend", ""+StandardizeMonetaryQuantity( iTSpendPCSpend ) );
    IT_SPEND_DATA.setString("iTSpendStorageSpend", ""+StandardizeMonetaryQuantity( iTSpendStorageSpend ) );
    IT_SPEND_DATA.setString("iTSpendOtherHardwareSpend", ""+StandardizeMonetaryQuantity( iTSpendOtherHardwareSpend ) );
    IT_SPEND_DATA.setString("iTSpendOtherITSpend", ""+StandardizeMonetaryQuantity( iTSpendOtherITSpend ) );
    
    result.put("IT Spending Data", IT_SPEND_DATA.toString());
    
    List<String> monthlyDownloads = crunchObj.getMonthlyDownloads();
    
    int inc__ = 1;
    
    JSONObject MONTHLY_APP_DOWNLOADS = new JSONObject();
    
    for( String APP_DOWNLOADS : monthlyDownloads )
      {
        MONTHLY_APP_DOWNLOADS.setString( "APP DOWNLOADS " + inc__, APP_DOWNLOADS );
        inc__++;
      }
      
    result.put("monthlyDownloads", MONTHLY_APP_DOWNLOADS.toString() );
    
    List<String> monthlyUsers = crunchObj.getMonthlyUsers();
    
    JSONObject MONTHLY_APP_USERS = new JSONObject();
    
    inc__ = 0;
    
    for( String MONTH : monthlyUsers )
      {
        MONTHLY_APP_USERS.setString( "Monthly Users " + inc__, MONTH );
        inc__++;
      }
    
    result.put("monthlyUsers", MONTHLY_APP_USERS.toString());
    
    List<String> ratings = crunchObj.getRatings();
    JSONObject RATINGS = new JSONObject();
    
    inc__ = 0;
    
    for( String RATING : ratings )
      {
        RATINGS.setString( "USER_RATING_"+inc__, RATING );
        inc__++;
      }
      
    
    result.put("ratings", RATINGS.toString());
  } catch (Exception e) {
    System.out.println("startProcess");
  }

}

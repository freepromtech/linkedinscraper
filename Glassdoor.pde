class GlassdoorIncomeScraper {
  String loginLink = "https://www.glassdoor.co.in/profile/login_input.htm?userOriginHook=HEADER_SIGNIN_LINK";
  WebDriver driver;
  Map<String, String> stateMap = new HashMap<String, String>();
  
  public GlassdoorIncomeScraper()
    {
      
    }
  
  private void init(String loginLink) {
    driver = new FirefoxDriver();
    driver.get(loginLink);
    filStateAbbreviation();
  }

  public void loginProcess(String username, String password) {
    try {
      init(loginLink);
      List<WebElement> element = driver.findElements(By.cssSelector("input.input.med.std.fill"));
      for (WebElement webElement : element) {
        if (webElement.getAttribute("name").toLowerCase().trim().contains("username")) {
          webElement.click();
          webElement.sendKeys(username);
        } else if (webElement.getAttribute("name").toLowerCase().trim().contains("password")) {
          webElement.click();
          webElement.sendKeys(password);
        }
      }
      driver.findElement(By.cssSelector("button.gd-btn.gd-btn-1.fill")).click();
    } catch (Exception e) {
      System.out.println("login Process :" + e.getMessage());
    }
  }

  public String searchPosition(String jobtitle, String state) {
    try {
      driver.get( "https://www.glassdoor.com/Salaries/kansas-city-electrical-engineer-salary-SRCH_IL.0,11_IM437_KO12,31.htm" );
      state = state.toLowerCase() + "," + stateMap.get(state.trim());
      WebDriverWait wait1 = new WebDriverWait(driver, 50000);
      wait1.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector("input.keyword")));
      driver.findElement(By.cssSelector("input.keyword")).click();
      driver.findElement(By.cssSelector("input.keyword")).clear();
      driver.findElement(By.cssSelector("input.keyword")).sendKeys(jobtitle);
      driver.findElement(By.cssSelector("input.loc")).click();
      driver.findElement(By.cssSelector("input.loc")).clear();
      driver.findElement(By.cssSelector("input.loc")).sendKeys(state);
      driver.findElement(By.cssSelector("button.gd-btn-mkt")).click();
    } catch (Exception e) {
      System.out.println("searchPosition :" + e.getMessage());
    }
    return getSalarieValue();
  }

  private String getSalarieValue() {
    String salary = "NA";
    try {
      driver.findElement(By.cssSelector("li.salaries>a")).click();
      salary = driver.findElement(By.cssSelector("span.OccMedianBasePayStyle__payNumber"))
          .getAttribute("innerHTML").trim();
    } catch (Exception e) {
      System.out.println("get Salarie Value :" + e.getMessage());
    }

    return salary;
  }

  private void filStateAbbreviation() {
    try {
      stateMap.put("Alabama", "AL");
      stateMap.put("Alaska", "AK");
      stateMap.put("Arizona", "AZ");
      stateMap.put("Arkansas", "AR");
      stateMap.put("California", "CA");
      stateMap.put("Colorado", "CO");
      stateMap.put("Connecticut", "CT");
      stateMap.put("Delaware", "DE");
      stateMap.put("District of Columbia", "DC");
      stateMap.put("Florida", "FL");
      stateMap.put("Georgia", "GA");
      stateMap.put("Hawaii", "HI");
      stateMap.put("Idaho", "ID");
      stateMap.put("Illinois", "IL");
      stateMap.put("Indiana", "IN");
      stateMap.put("Iowa", "IA");
      stateMap.put("Kansas", "KS");
      stateMap.put("Kentucky", "KY");
      stateMap.put("Louisiana", "LA");
      stateMap.put("Maine", "ME");
      stateMap.put("Montana", "MT");
      stateMap.put("Nebraska", "NE");
      stateMap.put("Nevada", "NV");
      stateMap.put("New Hampshire", "NH");
      stateMap.put("New Jersey", "NJ");
      stateMap.put("New Mexico", "NM");
      stateMap.put("New York", "NY");
      stateMap.put("North Carolina", "NC");
      stateMap.put("North Dakota", "ND");
      stateMap.put("Ohio", "OH");
      stateMap.put("Oklahoma", "OK");
      stateMap.put("Oregon", "OR");
      stateMap.put("Maryland", "MD");
      stateMap.put("Massachusetts", "MA");
      stateMap.put("Michigan", "MI");
      stateMap.put("Minnesota", "MN");
      stateMap.put("Mississippi", "MS");
      stateMap.put("Missouri", "MO");
      stateMap.put("Pennsylvania", "PA");
      stateMap.put("Rhode Island", "RI");
      stateMap.put("South Carolina", "SC");
      stateMap.put("South Dakota", "SD");
      stateMap.put("Tennessee", "TN");
      stateMap.put("Texas", "TX");
      stateMap.put("Utah", "UT");
      stateMap.put("Vermont", "VT");
      stateMap.put("Virginia", "VA");
      stateMap.put("Washington", "WA");
      stateMap.put("West Virginia", "WV");
      stateMap.put("Wisconsin", "WI");
      stateMap.put("Wyoming", "WY");

    } catch (Exception e) {
      // TODO: handle exception
    }

  }
}

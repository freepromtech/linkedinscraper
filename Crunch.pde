import java.util.ArrayList;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.support.ui.ExpectedCondition;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

class CrunchBase {
  WebDriver driver;
  String url = "https://www.crunchbase.com/login";

  public void init() {
    try {
      driver = new FirefoxDriver();
      driver.get(url);
      waitForAll();
    } catch (Exception e) {
      System.out.println("Error in init : " + e.getMessage());
    }
  }

  public void loginToCrunchBase(String userName, String password) {
    try {
      WebDriverWait wait = new WebDriverWait(driver, 100);
      driver.findElement(By.cssSelector("input#mat-input-1")).sendKeys(userName.trim());
      driver.findElement(By.cssSelector("input#mat-input-2")).sendKeys(password.trim());
      wait.until(ExpectedConditions.visibilityOfElementLocated(
          By.cssSelector("button.cb-text-transform-upper.mat-raised-button.mat-primary")));
      WebElement clickWebElement = driver
          .findElement(By.cssSelector("button.cb-text-transform-upper.mat-raised-button.mat-primary"));
      click(clickWebElement);
      waitForAll();
    } catch (Exception e) {
      System.out.println("Error in login : " + e.getMessage());
    }
  }

  public String getBingSearch(String text, int index) {
    try {
      Document doc = Jsoup
          .connect("https://www.bing.com/search?q=site%3Acrunchbase.com%20\"" + text.replace(" ", "+") + "\"")
          .get();
      return (doc.getElementsByClass("b_algo").get(index).getElementsByTag("a").get(0).attr("abs:href"));
    } catch (Exception e) {
      return "BROKEN";
    }
  }

  public List<String> getMonthlyDownloads() {
    List<String> mdList = new ArrayList<String>();
    try {
      if (driver.findElements(By.id("section-mobile-app-metrics-by-apptopia")).size() > 0) {
        WebElement mdWebEle = driver.findElement(By.id("section-mobile-app-metrics-by-apptopia"));
        if (mdWebEle.findElements(By.cssSelector("a[aria-label='View All']")).size() > 0) {
          WebElement viewAllClick = mdWebEle.findElement(By.cssSelector("a[aria-label='View All']"));
          click(viewAllClick);
          waitForAll();
          listOfMonthlyDownloads(mdWebEle, mdList);
        } else {
          listOfMonthlyDownloads(mdWebEle, mdList);
        }
      }
    } catch (Exception e) {
      System.out.println("Error in getMonthlyDownloads : " + e.getMessage());
    }
    return mdList;
  }

  private void listOfMonthlyDownloads(WebElement mdWebEle, List<String> mdList) {
    waitForAll();
    mdWebEle = driver.findElement(By.id("section-mobile-app-metrics-by-apptopia"));
    List<WebElement> tbodyTr = mdWebEle.findElements(By.cssSelector("tbody>tr"));
    for (WebElement webElement : tbodyTr) {
      String td0Val = webElement.findElements(By.tagName("td")).get(0).getText().trim();
      String td2Val = webElement.findElements(By.tagName("td")).get(2).getText().trim();
      mdList.add(td0Val + " - " + td2Val);
    }
  }

  public List<String> getMonthlyUsers() {
    List<String> mdList = new ArrayList<String>();
    try {
      if (driver.findElements(By.id("section-mobile-app-metrics-by-apptopia")).size() > 0) {
        WebElement mdWebEle = driver.findElement(By.id("section-mobile-app-metrics-by-apptopia"));
        if (mdWebEle.findElements(By.cssSelector("a[aria-label='View All']")).size() > 0) {
          WebElement viewAllClick = mdWebEle.findElement(By.cssSelector("a[aria-label='View All']"));
          click(viewAllClick);
          waitForAll();
          listOfMonthlyUsers(mdWebEle, mdList);
        } else {
          listOfMonthlyUsers(mdWebEle, mdList);
        }
      }
    } catch (Exception e) {
      System.out.println("Error in getMonthlyDownloads : " + e.getMessage());
    }
    return mdList;
  }

  private void listOfMonthlyUsers(WebElement mdWebEle, List<String> mdList) {
    mdWebEle = driver.findElement(By.id("section-mobile-app-metrics-by-apptopia"));
    List<WebElement> tbodyTr = mdWebEle.findElements(By.cssSelector("tbody>tr"));
    for (WebElement webElement : tbodyTr) {
      String td0Val = webElement.findElements(By.tagName("td")).get(0).getText().trim();
      String td4Val = webElement.findElements(By.tagName("td")).get(4).getText().trim();
      mdList.add(td0Val + " - " + td4Val);
    }
  }

  public List<String> getRatings() {
    List<String> ratingList = new ArrayList<String>();
    try {
      if (driver.findElements(By.id("section-mobile-app-metrics-by-apptopia")).size() > 0
          && driver.findElements(By.cssSelector("span[title=\"Ratings\"]")).size() > 0) {
        WebElement mdWebEle = driver.findElement(By.id("section-mobile-app-metrics-by-apptopia"));
        WebElement reatingClick = driver.findElement(By.cssSelector("span[title=\"Ratings\"]"));
        click(reatingClick);
        waitForSimpleJavaScript(driver);
        waitForAjax(driver);
        if (mdWebEle.findElements(By.cssSelector("a[aria-label='View All']")).size() > 0) {
          WebElement viewAllClick = mdWebEle.findElement(By.cssSelector("a[aria-label='View All']"));
          click(viewAllClick);
          waitForAll();
          listOfRatings(mdWebEle, ratingList);
        } else {
          waitForAll();
          listOfRatings(mdWebEle, ratingList);
        }
      }
    } catch (Exception e) {
      System.out.println("Error in getMonthlyDownloads : " + e.getMessage());
    }
    return ratingList;
  }

  private void listOfRatings(WebElement mdWebEle, List<String> ratingList) {
    if (driver.findElements(By.cssSelector("[aria-label=\"Show More\"]")).size() > 0) {
      click(driver.findElement(By.cssSelector("[aria-label=\"Show More\"]")));
      waitForAll();
    }
    List<WebElement> tbodyTr = mdWebEle.findElements(By.cssSelector("tbody>tr"));
    for (WebElement webElement : tbodyTr) {
      String td0Val = webElement.findElements(By.tagName("td")).get(0).getText().trim();
      String td1Val = webElement.findElements(By.tagName("td")).get(1).getText().trim();
      String td3Val = webElement.findElements(By.tagName("td")).get(3).getText().trim();
      ratingList.add(td0Val + " - " + td1Val + " - " + td3Val);
    }
  }

  public String getOwlerRevenue(String url) {
    driver.get(url);
    waitForAll();
    try {
      if (driver.findElements(By.cssSelector("section-layout#section-competitors-revenue-by-owler")).size() > 0) {
        WebElement orWebEle = driver
            .findElement(By.cssSelector("section-layout#section-competitors-revenue-by-owler"));
        WebElement reveValWebEle = orWebEle.findElement(By.cssSelector(
            "big-values-card.ng-star-inserted>div>div.flex-100.flex-gt-sm-50.bigValueItem.layout-column.even.ng-star-inserted"));
        return reveValWebEle.getText().replace("Revenue", "").trim();
      }

    } catch (Exception e) {
      System.out.println("Error in getOwlerRevenue : " + e.getMessage());
    }
    return "NA";
  }

  public String getITSpend(String url) {
    driver.get(url);
    waitForAll();
    try {
      if (driver.findElements(By.id("section-it-spend-by-aberdeen")).size() > 0) {
        WebElement itSpendWebEle = driver.findElement(By.id("section-it-spend-by-aberdeen"));
        WebElement itSpendVlaEle = itSpendWebEle.findElement(By.cssSelector(
            "div.flex-100.flex-gt-sm-50.bigValueItem.layout-column.even.last.ng-star-inserted"));
        return itSpendVlaEle.getText().toLowerCase().replace("it spend", "").trim();
      }
    } catch (Exception e) {
      System.out.println("Error in getITSpend : " + e.getMessage());
    }
    return "NA";
  }

  public String getITSpendSoftwareSpend() {
    try {
      if (driver.findElements(By.id("section-it-spend-by-aberdeen")).size() > 0) {
        WebElement itSpendWebEle = driver.findElement(By.id("section-it-spend-by-aberdeen"));
        List<WebElement> listITText = itSpendWebEle.findElements(By
            .cssSelector("span.cb-text-color-medium.field-label.flex-100.flex-gt-sm-25.ng-star-inserted"));
        List<WebElement> listITVal = itSpendWebEle
            .findElements(By.cssSelector("span.field-value.flex-100.flex-gt-sm-25.ng-star-inserted"));
        for (int i = 0; i < listITText.size(); i++) {
          if (listITText.get(i).getText().trim().toLowerCase().contains("software spend")) {
            return listITVal.get(i).getText().trim();
          }
        }
      }
    } catch (Exception e) {
      System.out.println("Error in getITSpendSoftwareSpend : " + e.getMessage());
    }
    return "NA";
  }

  public String getITSpendCommunicationsSpend(String url) {
    driver.get(url);
    waitForAll();
    try {
      if (driver.findElements(By.id("section-it-spend-by-aberdeen")).size() > 0) {
        WebElement itSpendWebEle = driver.findElement(By.id("section-it-spend-by-aberdeen"));
        List<WebElement> listITText = itSpendWebEle.findElements(By
            .cssSelector("span.cb-text-color-medium.field-label.flex-100.flex-gt-sm-25.ng-star-inserted"));
        List<WebElement> listITVal = itSpendWebEle
            .findElements(By.cssSelector("span.field-value.flex-100.flex-gt-sm-25.ng-star-inserted"));

        for (int i = 0; i < listITText.size(); i++) {
          if (listITText.get(i).getText().trim().toLowerCase().contains("communications spend")) {
            return listITVal.get(i).getText().trim();
          }
        }
      }
    } catch (Exception e) {
      System.out.println("Error in getITSpendCommunicationsSpend : " + e.getMessage());
    }
    return "NA";
  }

  public String getITSpendServicesSpend() {
    try {
      if (driver.findElements(By.id("section-it-spend-by-aberdeen")).size() > 0) {
        WebElement itSpendWebEle = driver.findElement(By.id("section-it-spend-by-aberdeen"));
        List<WebElement> listITText = itSpendWebEle.findElements(By
            .cssSelector("span.cb-text-color-medium.field-label.flex-100.flex-gt-sm-25.ng-star-inserted"));
        List<WebElement> listITVal = itSpendWebEle
            .findElements(By.cssSelector("span.field-value.flex-100.flex-gt-sm-25.ng-star-inserted"));
        for (int i = 0; i < listITText.size(); i++) {
          if (listITText.get(i).getText().trim().toLowerCase().contains("services spend")) {
            return listITVal.get(i).getText().trim();
          }
        }
      }
    } catch (Exception e) {
      System.out.println("Error in getITSpendServicesSpend : " + e.getMessage());
    }
    return "NA";
  }

  public String getITSpendServerSpend() {
    try {
      if (driver.findElements(By.id("section-it-spend-by-aberdeen")).size() > 0) {
        WebElement itSpendWebEle = driver.findElement(By.id("section-it-spend-by-aberdeen"));
        List<WebElement> listITText = itSpendWebEle.findElements(By
            .cssSelector("span.cb-text-color-medium.field-label.flex-100.flex-gt-sm-25.ng-star-inserted"));
        List<WebElement> listITVal = itSpendWebEle
            .findElements(By.cssSelector("span.field-value.flex-100.flex-gt-sm-25.ng-star-inserted"));

        for (int i = 0; i < listITText.size(); i++) {
          if (listITText.get(i).getText().trim().toLowerCase().contains("server spend")) {
            return listITVal.get(i).getText().trim();
          }
        }
      }
    } catch (Exception e) {
      System.out.println("Error in getITSpendServerSpend : " + e.getMessage());
    }
    return "NA";
  }

  public String getITSpendPCSpend() {
    try {
      if (driver.findElements(By.id("section-it-spend-by-aberdeen")).size() > 0) {
        WebElement itSpendWebEle = driver.findElement(By.id("section-it-spend-by-aberdeen"));
        List<WebElement> listITText = itSpendWebEle.findElements(By
            .cssSelector("span.cb-text-color-medium.field-label.flex-100.flex-gt-sm-25.ng-star-inserted"));
        List<WebElement> listITVal = itSpendWebEle
            .findElements(By.cssSelector("span.field-value.flex-100.flex-gt-sm-25.ng-star-inserted"));
        for (int i = 0; i < listITText.size(); i++) {
          if (listITText.get(i).getText().trim().toLowerCase().contains("pc spend")) {
            return listITVal.get(i).getText().trim();
          }
        }
      }
    } catch (Exception e) {
      System.out.println("Error in getITSpendPCSpend : " + e.getMessage());
    }
    return "NA";
  }

  public String getITSpendStorageSpend() {
    try {
      if (driver.findElements(By.id("section-it-spend-by-aberdeen")).size() > 0) {
        WebElement itSpendWebEle = driver.findElement(By.id("section-it-spend-by-aberdeen"));
        List<WebElement> listITText = itSpendWebEle.findElements(By
            .cssSelector("span.cb-text-color-medium.field-label.flex-100.flex-gt-sm-25.ng-star-inserted"));
        List<WebElement> listITVal = itSpendWebEle
            .findElements(By.cssSelector("span.field-value.flex-100.flex-gt-sm-25.ng-star-inserted"));
        for (int i = 0; i < listITText.size(); i++) {
          if (listITText.get(i).getText().trim().toLowerCase().contains("storage spend")) {
            return listITVal.get(i).getText().trim();
          }
        }
      }
    } catch (Exception e) {
      System.out.println("Error in getITSpendStorageSpend : " + e.getMessage());
    }
    return "NA";
  }

  public String getITSpendOtherHardwareSpend() {
    try {
      if (driver.findElements(By.id("section-it-spend-by-aberdeen")).size() > 0) {
        WebElement itSpendWebEle = driver.findElement(By.id("section-it-spend-by-aberdeen"));
        List<WebElement> listITText = itSpendWebEle.findElements(By
            .cssSelector("span.cb-text-color-medium.field-label.flex-100.flex-gt-sm-25.ng-star-inserted"));
        List<WebElement> listITVal = itSpendWebEle
            .findElements(By.cssSelector("span.field-value.flex-100.flex-gt-sm-25.ng-star-inserted"));
        for (int i = 0; i < listITText.size(); i++) {
          if (listITText.get(i).getText().trim().toLowerCase().contains("other hardware spend")) {
            return listITVal.get(i).getText().trim();
          }
        }
      }
    } catch (Exception e) {
      System.out.println("Error in getITSpendOtherHardwareSpend : " + e.getMessage());
    }
    return "NA";
  }

  public String getITSpendOtherITSpend() {
    try {
      if (driver.findElements(By.id("section-it-spend-by-aberdeen")).size() > 0) {
        WebElement itSpendWebEle = driver.findElement(By.id("section-it-spend-by-aberdeen"));
        List<WebElement> listITText = itSpendWebEle.findElements(By
            .cssSelector("span.cb-text-color-medium.field-label.flex-100.flex-gt-sm-25.ng-star-inserted"));
        List<WebElement> listITVal = itSpendWebEle
            .findElements(By.cssSelector("span.field-value.flex-100.flex-gt-sm-25.ng-star-inserted"));
        for (int i = 0; i < listITText.size(); i++) {
          if (listITText.get(i).getText().trim().toLowerCase().contains("other it spend")) {
            return listITVal.get(i).getText().trim();
          }
        }
      }
    } catch (Exception e) {
      System.out.println("Error in getITSpendOtherITSpend : " + e.getMessage());
    }
    return "NA";
  }

  public List<String> getBomboraSignals() {
    List<String> bbsList = new ArrayList<String>();
    try {
      if (driver.findElements(By.id("section-interest-signals-by-bombora")).size() > 0) {
        WebElement bbsWebEle = driver.findElement(By.id("section-interest-signals-by-bombora"));
        if (bbsWebEle.findElements(By.cssSelector("a[aria-label=\"View All\"]")).size() > 0) {
          WebElement viewAllWebEle = bbsWebEle.findElement(By.cssSelector("a[aria-label=\"View All\"]"));
          click(viewAllWebEle);
          waitForAll();
          getListOfBomboraSignals(bbsList, bbsWebEle);
        } else {
          getListOfBomboraSignals(bbsList, bbsWebEle);
        }
      }
    } catch (Exception e) {
      System.out.println("Error in getBomboraSignals : " + e.getMessage());
    }
    return bbsList;
  }

  private void getListOfBomboraSignals(List<String> bbsList, WebElement bbsWebEle) {
    bbsWebEle = driver.findElement(By.id("section-interest-signals-by-bombora"));
    if (bbsWebEle.findElements(By.cssSelector("tbody>tr")).size() > 0) {
      List<WebElement> listStr = bbsWebEle.findElements(By.cssSelector("tbody>tr"));
      for (WebElement webElement : listStr) {
        bbsList.add(webElement.findElements(By.tagName("td")).get(0).getText().trim());
      }
    }
  }

  public String getMonthlyWebsiteVisits(String url) {
    driver.get(url);
    waitForAll();
    try {
      if (driver.findElements(By.cssSelector("section-layout#section-traffic")).size() > 0) {
        WebElement mwvWebEle = driver.findElement(By.cssSelector("section-layout#section-traffic"));
        WebElement mwvValWebEle = mwvWebEle.findElement(
            By.cssSelector("div.flex-100.flex-gt-sm-50.bigValueItem.layout-column.even.ng-star-inserted"));
        return mwvValWebEle.getText().toLowerCase().replace("monthly visits", "").trim();
      }
    } catch (Exception e) {
      System.out.println("Error in getMonthlyWebsiteVisits : " + e.getMessage());
    }
    return "NA";
  }

  public String getMonthlyWebsiteVisitsGrowth(String url) {
    driver.get(url);
    waitForAll();
    try {
      if (driver
          .findElements(By.cssSelector(
              "div.flex-100.flex-gt-sm-50.bigValueItem.layout-column.odd.last.ng-star-inserted"))
          .size() > 0) {
        WebElement mwvWebEle = driver.findElement(By.cssSelector("section-layout#section-traffic"));
        WebElement mwvgWebEle = mwvWebEle.findElement(By.cssSelector(
            "div.flex-100.flex-gt-sm-50.bigValueItem.layout-column.odd.last.ng-star-inserted"));
        return mwvgWebEle.getText().toLowerCase().replace("monthly visits growth", "").trim();
      }
    } catch (Exception e) {
      System.out.println("Error in getMonthlyWebsiteVisitsGrowth : " + e.getMessage());
    }
    return "NA";
  }

  public String getMonthlyWebsiteVisitDuration(String url) {
    driver.get(url);
    waitForAll();
    if (driver.findElements(By.cssSelector("section-layout#section-web-traffic-by-similarweb")).size() > 0) {
      WebElement mwvWebEle = driver
          .findElement(By.cssSelector("section-layout#section-web-traffic-by-similarweb"));
      WebElement engamentClick = mwvWebEle.findElements(By.cssSelector("div.mat-tab-labels>div")).get(1);
      click(engamentClick);
      waitForAll();
      List<WebElement> listOfSpanEle = mwvWebEle.findElements(
          By.cssSelector("span.cb-text-color-medium.field-label.flex-100.flex-gt-sm-25.ng-star-inserted"));

      List<WebElement> spanWebEle = mwvWebEle
          .findElements(By.cssSelector("span.field-value.flex-100.flex-gt-sm-25.ng-star-inserted"));
      for (int i = 0; i < listOfSpanEle.size(); i++) {
        if (listOfSpanEle.get(i).getText().trim().toLowerCase().contains("visit duration")) {
          return spanWebEle.get(i).getText().trim();
        }
      }
    }
    return "NA";
  }

  public String getMonthlyWebsiteVisitBounceRate() {
    try {
      if (driver.findElements(By.cssSelector("section-layout#section-web-traffic-by-similarweb")).size() > 0) {
        WebElement mwvWebEle = driver
            .findElement(By.cssSelector("section-layout#section-web-traffic-by-similarweb"));
        List<WebElement> listOfSpanEle = mwvWebEle.findElements(By
            .cssSelector("span.cb-text-color-medium.field-label.flex-100.flex-gt-sm-25.ng-star-inserted"));
        List<WebElement> spanWebEle = mwvWebEle
            .findElements(By.cssSelector("span.field-value.flex-100.flex-gt-sm-25.ng-star-inserted"));
        for (int i = 0; i < listOfSpanEle.size(); i++) {
          if (listOfSpanEle.get(i).getText().trim().toLowerCase().contains("bounce rate")) {
            return spanWebEle.get(i).getText().trim();
          }
        }
      }
    } catch (Exception e) {
      System.out.println("Error in getMonthlyWebsiteVisitBounceRate : " + e.getMessage());
    }
    return "NA";
  }

  public String getMonthlyWebsiteVisitPageViewsPerVisit() {
    try {
      if (driver.findElements(By.cssSelector("section-layout#section-web-traffic-by-similarweb")).size() > 0) {
        WebElement mwvWebEle = driver
            .findElement(By.cssSelector("section-layout#section-web-traffic-by-similarweb"));
        List<WebElement> listOfSpanEle = mwvWebEle.findElements(By
            .cssSelector("span.cb-text-color-medium.field-label.flex-100.flex-gt-sm-25.ng-star-inserted"));

        List<WebElement> spanWebEle = mwvWebEle
            .findElements(By.cssSelector("span.field-value.flex-100.flex-gt-sm-25.ng-star-inserted"));
        for (int i = 0; i < listOfSpanEle.size(); i++) {
          if (listOfSpanEle.get(i).getText().trim().toLowerCase().contains("page views / visit")) {
            return spanWebEle.get(i).getText().trim();
          }
        }
      }
    } catch (Exception e) {
      System.out.println("Error in getMonthlyWebsiteVisitPageViewsPerVisit :" + e.getMessage());
    }
    return "NA";
  }

  public List<String> getWebsiteTechStackCurrent(String url) {
    driver.get(url);
    waitForAll();
    List<String> listWebsiteTechStackCurrent = new ArrayList<String>();
    try {
      if (driver.findElements(By.cssSelector("section-layout#section-website-tech-stack-by-builtwith"))
          .size() > 0) {
        WebElement wtscWebEle = driver
            .findElement(By.cssSelector("section-layout#section-website-tech-stack-by-builtwith"));
        if (wtscWebEle.findElements(By.cssSelector("[aria-label=\"View All\"]")).size() > 0) {
          WebElement viewAll = wtscWebEle.findElement(By.cssSelector("[aria-label=\"View All\"]"));
          click(viewAll);
          waitForAll();
          listOfWebsiteTechStackCurrent(listWebsiteTechStackCurrent, wtscWebEle);
        } else {
          listOfWebsiteTechStackCurrent(listWebsiteTechStackCurrent, wtscWebEle);
        }
      }
    } catch (Exception e) {
      System.out.println("Error in getWebsiteTechStackCurrent : " + e.getMessage());
    }
    return listWebsiteTechStackCurrent;
  }

  private void listOfWebsiteTechStackCurrent(List<String> listWebsiteTechStackCurrent, WebElement wtscWebEle) {
    wtscWebEle = driver.findElement(By.cssSelector("section-layout#section-website-tech-stack-by-builtwith"));
    boolean isTrue = true;
    while (isTrue) {
      wtscWebEle = driver.findElement(By.cssSelector("section-layout#section-website-tech-stack-by-builtwith"));
      if (driver.findElements(By.cssSelector("[aria-label=\"Show More\"]")).size() > 0) {
        WebElement showMore = driver.findElement(By.cssSelector("[aria-label=\"Show More\"]"));
        click(showMore);
        waitForAll();
      } else {
        isTrue = false;
        waitForAll();
      }
    }
    List<WebElement> listOfTr = wtscWebEle.findElements(By.cssSelector("tbody>tr"));
    for (WebElement webElement : listOfTr) {
      listWebsiteTechStackCurrent.add(webElement.findElements(By.tagName("td")).get(0).getText().trim());
    }
  }

  public List<String> getWebsiteTechStackRemoved() {
    List<String> listWebsiteTechStackRemoved = new ArrayList<String>();
    try {
      if (driver.findElements(By.cssSelector("div.mat-tab-labels>div")).size() > 0) {
        WebElement wtsrClick = driver.findElements(By.cssSelector("div.mat-tab-labels>div")).get(1);
        click(wtsrClick);
        waitForAll();
      }
      if (driver.findElements(By.cssSelector("section-layout#section-website-tech-stack-by-builtwith"))
          .size() > 0) {
        WebElement wtsrWebEle = driver
            .findElement(By.cssSelector("section-layout#section-website-tech-stack-by-builtwith"));
        waitForAll();
        List<WebElement> listOfTr = wtsrWebEle.findElements(By.cssSelector("tbody>tr"));
        for (WebElement webElement : listOfTr) {
          listWebsiteTechStackRemoved.add(webElement.findElements(By.tagName("td")).get(0).getText().trim());
        }
      }
    } catch (Exception e) {
      System.out.println("Error in getWebsiteTechStackRemoved : " + e.getMessage());
    }
    return listWebsiteTechStackRemoved;
  }

  public List<List<String>> getFundingData() {
    List<List<String>> listOfFundingData = new ArrayList<List<String>>();
    WebDriverWait wait = new WebDriverWait(driver, 100);
    wait.until(
        ExpectedConditions.visibilityOfElementLocated(By.cssSelector("section-layout#section-funding-rounds")));
    try {
      if (driver.findElements(By.cssSelector("section-layout#section-funding-rounds")).size() > 0) {
        WebElement fdWebEle = driver.findElement(By.cssSelector("section-layout#section-funding-rounds"));
        if (fdWebEle.findElements(By.cssSelector("[aria-label=\"View All\"]")).size() > 0) {
          click(fdWebEle.findElement(By.cssSelector("[aria-label=\"View All\"]")));
          waitForAll();
        }
        wait.until(ExpectedConditions
            .visibilityOfElementLocated(By.cssSelector("section-layout#section-funding-rounds")));
        waitForAll();
        List<WebElement> fundingDataWebEle = fdWebEle.findElements(By.cssSelector("tbody>tr"));
        for (WebElement webElement : fundingDataWebEle) {
          List<String> listOfData = new ArrayList<String>();
          listOfData.add(webElement.findElements(By.tagName("td")).get(0).getText().trim());
          listOfData.add(webElement.findElements(By.tagName("td")).get(3).getText().trim());
          listOfFundingData.add(listOfData);
        }
      }
    } catch (Exception e) {
      System.out.println("Error in getFundingData : " + e.getMessage());
    }
    return listOfFundingData;
  }

  public List<String> getTechStack(String url) {
    driver.get(url);
    waitForAll();
    List<String> listTechStack = new ArrayList<String>();
    try {
      if (driver.findElements(By.cssSelector("section-layout#section-company-tech-stack-by-siftery"))
          .size() > 0) {
        WebElement tecgStackWebEle = driver
            .findElement(By.cssSelector("section-layout#section-company-tech-stack-by-siftery"));
        if (tecgStackWebEle.findElements(By.cssSelector("a[aria-label=\"View All\"]")).size() > 0) {
          WebElement clickViewAll = tecgStackWebEle.findElement(By.cssSelector("a[aria-label=\"View All\"]"));
          click(clickViewAll);
          waitForAll();
          getListOfTechStack(listTechStack, tecgStackWebEle);
          driver.get(url);
        } else {
          getListOfTechStack(listTechStack, tecgStackWebEle);
        }
      }
    } catch (Exception e) {
      System.out.println("Error in getTechStack : " + e.getMessage());
    }
    return listTechStack;
  }

  public void getListOfTechStack(List<String> listTechStack, WebElement tecgStackWebEle) {
    boolean isTrue = true;
    while (isTrue) {
      tecgStackWebEle = driver
          .findElement(By.cssSelector("section-layout#section-company-tech-stack-by-siftery"));
      if (driver.findElements(By.cssSelector("[aria-label=\"Show More\"]")).size() > 0) {
        WebElement showMore = driver.findElement(By.cssSelector("[aria-label=\"Show More\"]"));
        click(showMore);
        waitForAll();
      } else {
        isTrue = false;
      }
    }
    waitForSimpleJavaScript(driver);
    waitForAjax(driver);
    waitForPageLoad();
    List<WebElement> listOfTr = tecgStackWebEle.findElements(By.cssSelector("tbody>tr"));
    for (WebElement webElement : listOfTr) {
      listTechStack.add(webElement.findElements(By.tagName("td")).get(0).getText().trim());
    }

  }

  public String getEmployeeCount() {
    try {
      WebDriverWait wait = new WebDriverWait(driver, 100);
      wait.until(ExpectedConditions.visibilityOfElementLocated(
          By.cssSelector("fields-card.ng-star-inserted>div.layout-wrap.layout-row")));
      if (driver.findElements(By.cssSelector("fields-card.ng-star-inserted>div.layout-wrap.layout-row"))
          .size() > 0) {
        WebElement empWebElement = driver
            .findElements(By.cssSelector("fields-card.ng-star-inserted>div.layout-wrap.layout-row")).get(0);
        List<WebElement> listCatagories = empWebElement.findElements(By
            .cssSelector("span.cb-text-color-medium.field-label.flex-100.flex-gt-sm-25.ng-star-inserted"));
        for (int i = 0; i < listCatagories.size(); i++) {
          if (listCatagories.get(i).getText().trim().toLowerCase().contains("number of employees")) {
            WebElement empString = empWebElement
                .findElements(
                    By.cssSelector("span.field-value.flex-100.flex-gt-sm-75.ng-star-inserted"))
                .get(i);
            return empString.getText();
          }
        }
      }
    } catch (Exception e) {
      System.out.println("exception in getEmployeeCount : " + e.getMessage());
    }
    return "NA";
  }

  public String getCompanyType() {
    WebDriverWait wait = new WebDriverWait(driver, 100);
    wait.until(ExpectedConditions
        .visibilityOfElementLocated(By.cssSelector("fields-card.ng-star-inserted>div.layout-wrap.layout-row")));
    try {
      if (driver.findElements(By.cssSelector("fields-card.ng-star-inserted>div.layout-wrap.layout-row"))
          .size() > 0) {
        List<WebElement> listCatagories = driver.findElements(By
            .cssSelector("span.cb-text-color-medium.field-label.flex-100.flex-gt-sm-25.ng-star-inserted"));
        List<WebElement> empWebElement = driver
            .findElements(By.cssSelector("span.field-value.flex-100.flex-gt-sm-75.ng-star-inserted"));
        for (int i = 0; i < listCatagories.size(); i++) {
          if (listCatagories.get(i).getText().trim().toLowerCase().contains("company type")) {
            WebElement empString = empWebElement.get(i);
            return empString.getText();
          }
        }
      }

    } catch (Exception e) {
      System.out.println("exception in getCompanyType : " + e.getMessage());
    }
    return "NA";
  }

  public String getWebsite() {
    try {
      if (driver.findElements(By.cssSelector("fields-card.ng-star-inserted>div.layout-wrap.layout-row"))
          .size() > 0) {
        List<WebElement> listCatagories = driver.findElements(By
            .cssSelector("span.cb-text-color-medium.field-label.flex-100.flex-gt-sm-25.ng-star-inserted"));
        List<WebElement> empWebElement = driver
            .findElements(By.cssSelector("span.field-value.flex-100.flex-gt-sm-75.ng-star-inserted"));
        for (int i = 0; i < listCatagories.size(); i++) {
          if (listCatagories.get(i).getText().trim().toLowerCase().contains("website")) {
            WebElement empString = empWebElement.get(i).findElement(By.tagName("a"));
            return empString.getAttribute("href");
          }
        }
      }

    } catch (Exception e) {
      System.out.println("exception in getWebsite : " + e.getMessage());

    }
    return "NA";
  }

  public String getPhone() {
    try {
      if (driver.findElements(By.cssSelector("fields-card.ng-star-inserted>div.layout-wrap.layout-row"))
          .size() > 0) {
        List<WebElement> listCatagories = driver.findElements(By
            .cssSelector("span.cb-text-color-medium.field-label.flex-100.flex-gt-sm-25.ng-star-inserted"));
        List<WebElement> empWebElement = driver
            .findElements(By.cssSelector("span.field-value.flex-100.flex-gt-sm-75.ng-star-inserted"));
        for (int i = 0; i < listCatagories.size(); i++) {
          if (listCatagories.get(i).getText().trim().toLowerCase().contains("phone number")) {
            WebElement empString = empWebElement.get(i);
            return empString.getText();

          }
        }
      }

    } catch (Exception e) {
      System.out.println("exception in getPhone : " + e.getMessage());
    }
    return "NA";
  }

  public String getEmail() {
    try {
      if (driver.findElements(By.cssSelector("fields-card.ng-star-inserted>div.layout-wrap.layout-row"))
          .size() > 0) {
        List<WebElement> listCatagories = driver.findElements(By
            .cssSelector("span.cb-text-color-medium.field-label.flex-100.flex-gt-sm-25.ng-star-inserted"));
        List<WebElement> empWebElement = driver
            .findElements(By.cssSelector("span.field-value.flex-100.flex-gt-sm-75.ng-star-inserted"));
        for (int i = 0; i < listCatagories.size(); i++) {
          if (listCatagories.get(i).getText().trim().toLowerCase().contains("email")) {
            WebElement empString = empWebElement.get(i);
            return empString.getText();

          }
        }
      }

    } catch (Exception e) {
      System.out.println("exception in getEmail : " + e.getMessage());
    }
    return "NA";
  }

  public String getFacebookLink() {
    try {
      if (driver.findElements(By.cssSelector("fields-card.ng-star-inserted>div.layout-wrap.layout-row"))
          .size() > 0) {
        List<WebElement> listCatagories = driver.findElements(By
            .cssSelector("span.cb-text-color-medium.field-label.flex-100.flex-gt-sm-25.ng-star-inserted"));
        List<WebElement> empWebElement = driver
            .findElements(By.cssSelector("span.field-value.flex-100.flex-gt-sm-75.ng-star-inserted"));

        for (int i = 0; i < listCatagories.size(); i++) {
          if (listCatagories.get(i).getText().trim().toLowerCase().contains("facebook")) {
            WebElement empString = empWebElement.get(i).findElement(By.tagName("a"));
            return empString.getAttribute("href");

          }
        }
      }

    } catch (Exception e) {
      System.out.println("exception in getFacebook : " + e.getMessage());
    }
    return "NA";
  }

  public String getTwitterLink() {
    try {
      if (driver.findElements(By.cssSelector("fields-card.ng-star-inserted>div.layout-wrap.layout-row"))
          .size() > 0) {

        List<WebElement> listCatagories = driver.findElements(By
            .cssSelector("span.cb-text-color-medium.field-label.flex-100.flex-gt-sm-25.ng-star-inserted"));
        List<WebElement> empWebElement = driver
            .findElements(By.cssSelector("span.field-value.flex-100.flex-gt-sm-75.ng-star-inserted"));
        for (int i = 0; i < listCatagories.size(); i++) {
          if (listCatagories.get(i).getText().trim().toLowerCase().contains("twitter")) {
            WebElement empString = empWebElement.get(i).findElement(By.tagName("a"));
            return empString.getAttribute("href");

          }
        }
      }

    } catch (Exception e) {
      System.out.println("exception in getTwitter : " + e.getMessage());
    }
    return "NA";
  }

  public String getCatagories() {
    try {
      WebDriverWait wait = new WebDriverWait(driver, 100);
      wait.until(ExpectedConditions.visibilityOfElementLocated(
          By.cssSelector("fields-card.ng-star-inserted>div.layout-wrap.layout-row")));
      if (driver.findElements(By.cssSelector("fields-card.ng-star-inserted>div.layout-wrap.layout-row"))
          .size() > 0) {
        WebElement categoriesWebElement = driver
            .findElements(By.cssSelector("fields-card.ng-star-inserted>div.layout-wrap.layout-row")).get(0);
        List<WebElement> listCatagories = categoriesWebElement.findElements(By
            .cssSelector("span.cb-text-color-medium.field-label.flex-100.flex-gt-sm-25.ng-star-inserted"));
        for (int i = 0; i < listCatagories.size(); i++) {
          if (listCatagories.get(i).getText().trim().toLowerCase().contains("categories")) {
            WebElement catagoriesString = categoriesWebElement
                .findElements(By.cssSelector("identifier-multi-formatter.ng-star-inserted")).get(0);
            return catagoriesString.getText();

          }
        }
      }
    } catch (Exception e) {
      System.out.println("Exception in getCatagories : " + e.getMessage());
    }
    return "NA";
  }

  public void click(WebElement webElement) {
    try {
      JavascriptExecutor executor = (JavascriptExecutor) driver;
      executor.executeScript("arguments[0].click();", webElement);
    } catch (Exception e) {
      System.out.println("Error in click :" + e.getMessage());
    }
  }

  public void openProfile(String url) {
    try {
      driver.get(url);
      waitForAll();
    } catch (Exception e) {
      System.out.println("Exception in openProfile : " + e.getMessage());
    }
  }

  public void waitForAjax(WebDriver driver) {

    try {
      new WebDriverWait(driver, 100).until(new ExpectedCondition<Boolean>() {
        public Boolean apply(WebDriver driver) {
          JavascriptExecutor js = (JavascriptExecutor) driver;
          return (Boolean) js.executeScript("return jQuery.active == 0");
        }
      });

    } catch (Exception e) {

    }
  }

  public void waitForSimpleJavaScript(WebDriver driver) {
    try {
      new WebDriverWait(driver, 1000).until(new ExpectedCondition<Boolean>() {
        public Boolean apply(WebDriver driver) {
          JavascriptExecutor js = (JavascriptExecutor) driver;
          return (Boolean) js.executeScript("return document.readyState").equals("complete");
        }
      });

    } catch (Exception e) {
    }
  }

  public void waitForPageLoad() {
    try {
      Thread.sleep(3000);
    } catch (Exception e) {

    }
  }

  public void driverClose() {
    driver.close();
  }

  private void waitForAll() {
    waitForPageLoad();
    waitForSimpleJavaScript(driver);
    waitForAjax(driver);
  }

}

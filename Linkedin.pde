import java.util.concurrent.TimeUnit;
import javax.swing.JOptionPane;
import java.io.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import java.util.Calendar;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import org.json.JSONException;

import java.io.*;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.BufferedReader;

import java.util.List;

import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.map.ObjectMapper;
import org.jsoup.Connection;
import org.jsoup.Jsoup;

import org.codehaus.jackson.JsonNode;

import org.jsoup.*;
import org.jsoup.Jsoup;
import org.jsoup.parser.*;
import org.jsoup.helper.Validate;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.jsoup.nodes.Attribute;
import org.jsoup.nodes.Attributes;

import org.openqa.selenium.*;
import org.openqa.selenium.MutableCapabilities;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.firefox.*;
import org.openqa.selenium.firefox.FirefoxProfile;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.Keys;
import org.openqa.selenium.Proxy;
import org.openqa.selenium.remote.DesiredCapabilities;
import org.openqa.selenium.remote.*;

import com.gargoylesoftware.htmlunit.*;
import com.gargoylesoftware.htmlunit.html.HtmlElement;
import com.gargoylesoftware.htmlunit.CookieManager;
import com.gargoylesoftware.htmlunit.html.HtmlPage;
import com.gargoylesoftware.htmlunit.html.HTMLParser;
import com.gargoylesoftware.htmlunit.StringWebResponse;
import com.gargoylesoftware.htmlunit.util.Cookie;
import com.gargoylesoftware.htmlunit.util.*;
import com.gargoylesoftware.htmlunit.html.HtmlDivision;

/*
architecture for controlling whether accounts add connections, or scrape connections.
segment pools of IP addresses for each thread
*/

ArrayList<String> IPS = new ArrayList<String>();
int rotator = 0;

String profileUrl = "";

CrunchBase crunchObj;
GetDomainContactDetails getDomainContactDetails = new GetDomainContactDetails();

Map<String, Object> result = new HashMap<String, Object>();
Map<String,String> States = new HashMap<String,String>();

GlassdoorIncomeScraper GIS = new GlassdoorIncomeScraper();

void setup()
  {
    size( 500, 500 );
    String username = "freepromsoftware@gmail.com";
    String password = "alex102599";
    GIS.loginProcess(username, password);
    crunchObj = new CrunchBase();
    crunchObj.init();
    crunchObj.loginToCrunchBase("freepromsoftware@gmail.com", "alex102599");
    
    LinkedinDron DRON = new LinkedinDron( "freepromsoftware@gmail.com", "Alex102599" );
    
    IPS.add( "172.245.58.59:80" );
    IPS.add( "107.161.84.138:80" );
    IPS.add( "198.23.216.20:80" );
    IPS.add( "23.105.183.180:80" );
    IPS.add( "23.92.124.54:80" );
    IPS.add( "172.245.250.142:80" );
    IPS.add( "107.150.84.102:80" );
    IPS.add( "192.227.248.88:80" );
    IPS.add( "107.174.228.138:80" );
    IPS.add( "107.161.84.32:80" );
    IPS.add( "192.40.94.207:80" );
    IPS.add( "107.174.228.149:80" );
    IPS.add( "185.161.71.41:80" );
    IPS.add( "23.105.159.232:80" );
    IPS.add( "209.99.166.119:80" );
    IPS.add( "104.160.11.163:80" );
    IPS.add( "209.99.166.77:80" );
    IPS.add( "104.168.4.114:80" );
    IPS.add( "209.99.166.253:80" );
    IPS.add( "104.160.11.198:80" );
    IPS.add( "209.242.221.212:80" );
    
    /*
    for( int i = 0; i < 30; i++ )
      {
        DRON.AddConnections();
      }
    */
    
    //DRON.SearchByCompany( "sprint", "software developer" );
    
    DRON.ScrapeConnections();
    
    crunchObj.driverClose();
  }
  
void draw()
  {
  }
  
String Rotate()
  {
    String RET = IPS.get( rotator );
    
    if( IPS.size() <= rotator )
      {
        rotator = 0;
      }
    else
      {
        rotator++;
      }
      
    return RET;
  }
  

void Sleep( int MSEC )
  {
    try
      {
        Thread.sleep( MSEC );
      }
    catch( Exception e )
      {
        
      }
  }

void ExecuteJavaScript( JavascriptExecutor _js_, String code )
  {
    try
      {
        _js_.executeAsyncScript( code );
      }
    catch( Exception e )
      {
        //e.printStackTrace();
      }
  }

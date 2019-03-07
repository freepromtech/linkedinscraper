class GetDomainContactDetails {
  SpyFuApi spyFuApi = new SpyFuApi();
  String fileName = System.getProperty("user.home") + File.separator + "Desktop" + File.separator;

  /*
   * Method For Get Contact Details Multiple Domain
   */
  public void getConatctDetailsForMultipleDomain(List<String> listDomains, String filePath) {
    for (String domain : listDomains) {
      try {
        getContactDataAndCreateFile(domain, filePath);
      } catch (JSONException e) {
        // TODO Auto-generated catch block
        e.printStackTrace();
      }
    }
  }

  /*
   * Method For Get Contact Details Single Domain
   */
  public JSONObject getConatctDetailsForSingleDomain(String domain, String filePath) {
    try {
      return getContactDataAndCreateFile(domain, filePath);
    } catch (JSONException e) {
      // TODO Auto-generated catch block
      return ( new JSONObject() );
    }
  }

  /*
   * Method For Get Contact Data And Create CSV File
   */
  private JSONObject getContactDataAndCreateFile(String domain, String filePath) throws JSONException {
    try {
      JsonNode node = spyFuApi.listContacts(domain);
      JSONObject jsonObject = new JSONObject();
      Map<String, Object> map = new HashMap<String, Object>();
      if (node.has("top_ppc_keywords")) {
        jsonObject.setString("top_ppc_keywords", node.path("top_ppc_keywords").toString());
      }
      if (node.has("ppc_age")) {
        jsonObject.setString("ppc_age", node.path("ppc_age").toString());
      }
      if (node.has("ppc_budget")) {
        jsonObject.setString("ppc_budget", node.path("ppc_budget").toString());
      }
      if (node.has("ppc_value")) {
        jsonObject.setString("ppc_value", node.path("ppc_value").toString());
      }
      if (node.has("ppc_clicks")) {
        jsonObject.setString("ppc_clicks", node.path("ppc_clicks").toString());
      }
      if (node.has("num_ppc_kw")) {
        jsonObject.setString("num_ppc_kw", node.path("num_ppc_kw").toString());
      }
      if (node.has("top_seo_keywords")) {
        jsonObject.setString("top_seo_keywords", node.path("top_seo_keywords").toString());
      }
      if (node.has("seo_clicks")) {
        jsonObject.setString("seo_clicks", node.path("seo_clicks").toString());
      }
      if (node.has("seo_value")) {
        jsonObject.setString("seo_value", node.path("seo_value").toString());
      }
      if (node.has("num_seo_kw")) {
        jsonObject.setString("num_seo_kw", node.path("num_seo_kw").toString());
      }
      if (node.has("tech_types")) {
        jsonObject.setString("tech_types", node.path("tech_types").toString());
      }
      if (node.has("technologies")) {
        jsonObject.setString("technologies", node.path("technologies").toString());
      }
      if (node.has("twitter")) {
        jsonObject.setString("twitter", node.path("twitter").toString());
      }
      if (node.has("emails")) {
        jsonObject.setString("emails", node.path("emails").toString());
      }
      if (node.has("phone")) {
        jsonObject.setString("phone", node.path("phone").toString());
      }

      
      return jsonObject;
    } catch (Exception e) {
      return ( new JSONObject() );
    }
  }
}

class SpyFuApi {
  /*
   * Method For Get List Contacts
   */
  public JsonNode listContacts(String domain) {
    JsonNode node = null;
    try {
      String url = "https://www.spyfu.com/apis/leads_api/get_contact_card?domain=" + domain + "&api_key=ZPEWFJU1";

      String result = Jsoup.connect(url).timeout(0).ignoreContentType(true).userAgent(
          "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36")
          .header("accept", "application/json, text/plain, */*").method(Connection.Method.GET).execute()
          .body();
      ObjectMapper mapper = new ObjectMapper();
      node = mapper.readTree(result);
    } catch (IOException e) {
      e.printStackTrace();
    }
    return node;
  }
}

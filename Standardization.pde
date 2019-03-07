double StandardizeMonetaryQuantity( String MONEY )
  {
    double _MONEY_ = Double.parseDouble( MONEY.replaceAll( "[^\\d.]", "" ) );
    if( MONEY.toLowerCase().contains( "k" ) )
      {
        return 1000*_MONEY_;
      }
    else if( MONEY.toLowerCase().contains( "m" ) )
      {
        return 1000000*_MONEY_;
      }
    else if( MONEY.toLowerCase().contains( "b" ) )
      {
        return 1000000000*_MONEY_;
      }
    else
      return 0;
  }
  
void CreateStates()
  {
    try
      {
        BufferedReader br = new BufferedReader(new FileReader("crunch_data/StateAbbreviaton.csv"));
        try
          {
              StringBuilder sb = new StringBuilder();
              String line = br.readLine();
          
              while( line != null )
                {
                    States.put( line.split( "," )[ 1 ], line.split( "," )[ 0 ] );
                    line = br.readLine();
                }
                
              String everything = sb.toString();
          }
        finally
          {
              br.close();
          }
      }
    catch( Exception e )
      {
      }
  }

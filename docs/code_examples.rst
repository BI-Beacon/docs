Code examples
==================

PHP
---

.. code-block:: php

   <?php
   
   function bibeacon_set($channelid, $color, $period, $server="https://api.cilamp.se/v1/") {
      $options = array(
         'http' => array(
            'header'  => "Content-type: application/x-www-form-urlencoded\r\n",
            'method'  => 'POST',
            'content' => http_build_query(
               array("color"=>$color,
                     "period"=>$period))
         )
      );
      $context  = stream_context_create($options);
      $result   = @file_get_contents($server.$channelid, false, $context);
      if ( $result !== FALSE ) {
         if ( ($result = @json_decode($result)) !== FALSE ) {
            if ( @$result->message === "'".$channelid."' updated" ) {
               return TRUE;
            } else { echo "Invalid response: ".json_encode($result); }
         } else { echo "Server response structure error: ".error_get_last()['message']; }
      } else { echo "API Request failed: ".error_get_last()['message']; }
      return FALSE;
   }
   
   if (php_sapi_name() == "cli") {
      if ($argc != 4) {
         echo "Usage: $argv[0] <channelid> <color> <period>\n";
         exit(1);
      } else {
         exit((int)bibeacon_set($argv[1], $argv[2], $argv[3]));
      }
   }
   ?>


Java
----

.. code-block:: java

   import java.io.IOException;
   import java.io.InputStream;
   import java.io.OutputStream;
   import java.net.HttpURLConnection;
   import java.net.URL;
   import java.net.URLConnection;
   import java.util.Map;
   
   public class setBeacon {
   
      public static boolean setColor( String systemid, String color ) {
         try {
            URLConnection connection = new URL("https://api.cilamp.se/v1/" + systemid).openConnection();
            connection.setDoOutput(true);
            connection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
            OutputStream output = connection.getOutputStream();
            output.write(("color=" + color).getBytes());
            InputStream response = connection.getInputStream();
         } catch( Exception e ) {
            System.err.println( e );
            return false;
         }
         return true;
      }
   
      // Usage: <systemid> <color>
      public static void main(String args[]) {
         setColor(args[0], args[1]);
      }
   }




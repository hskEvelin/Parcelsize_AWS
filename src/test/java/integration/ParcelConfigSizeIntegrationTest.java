package integration;
import static org.junit.Assert.*;
import org.junit.Test;
import org.springframework.web.client.RestTemplate;

import service.DbStatus;


public class ParcelConfigSizeIntegrationTest {

	@Test
	public void testDatabaseConnection(){
		final String uri = "http://192.168.56.102:1100/parcel/sent/test/dbcon";
	     
	    RestTemplate restTemplate = new RestTemplate();
	    DbStatus result = restTemplate.getForObject(uri, DbStatus.class);
	     
	    assertEquals(DbStatus.CONNECTED, result);
	}
	

}

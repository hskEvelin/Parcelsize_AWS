package test.java.integration;
import static org.junit.Assert.*;
import org.junit.Test;

import main.java.ParcelSizeService;

public class ParcelConfigSizeIntegrationTest {

	@Test
	public void testDatabaseConnection(){
		ParcelSizeService service = new ParcelSizeService();
		assertNotNull(service);
	}
}

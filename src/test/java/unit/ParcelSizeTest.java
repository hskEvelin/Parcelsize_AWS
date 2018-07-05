package unit;



import static org.junit.Assert.assertEquals;


import org.junit.Test;

import com.google.gson.Gson;

import service.IDatabaseHandler;
import service.Parcel;
import service.Parcelsize;
import service.ParcelsizeCalculator;


public class ParcelSizeTest {

	
	public ParcelSizeTest(){
		
	}
	
	
	
	@Test
	public void testParcelSizeXS(){
		IDatabaseHandler db = new DatabaseMock();
		ParcelsizeCalculator service = new ParcelsizeCalculator(db);
		Gson g = new Gson();
		//Test Size XS: 0 - 35 cm
		
		//Test XS.1: 0cm
		Parcel testparcel = new Parcel(0,0,0);
		
		Parcelsize p = service.calculateParcelsize(testparcel);
		
		assertEquals("Expected parcelsize XS but actual size was " + p + ": Input 0/0/0", Parcelsize.XS, p);
		
		//Test XS.2: 20 cm
		testparcel = new Parcel(11, 10, 9);
		
		p = service.calculateParcelsize(testparcel);
		
		assertEquals("Expected parcelsize XS but actual size was " + p + ": Input 10/10/5", Parcelsize.XS, p);
		
		//Test XS.3: 35cm
		testparcel = new Parcel(20, 15, 17);
		
		p = service.calculateParcelsize(testparcel);
		
		assertEquals("Expected parcelsize XS but actual size was " + p + ": Input 20/15/10", Parcelsize.XS, p);

	}
	
	@Test
	public void testParcelSizeS(){
		IDatabaseHandler db = new DatabaseMock();
		ParcelsizeCalculator service = new ParcelsizeCalculator(db);
		Gson g = new Gson();
		//Test Size S: 36 - 50 cm
		
		//Test S.1: 36cm
		Parcel testparcel = new Parcel(21, 15, 17);
		
		Parcelsize p = service.calculateParcelsize(testparcel);
		
		assertEquals("Expected parcelsize S but actual size was " + p + ": Input 21/15/10", Parcelsize.S, p);
		
		//Test S.2: 40 cm
		testparcel = new Parcel(25, 20, 15);
		
		p = service.calculateParcelsize(testparcel);
		
		assertEquals("Expected parcelsize S but actual size was " + p + ": Input 20/20/5", Parcelsize.S, p);
		
		//Test S.3: 50cm
		testparcel = new Parcel(20, 30, 25);
		
		p = service.calculateParcelsize(testparcel);
		
		assertEquals("Expected parcelsize S but actual size was " + p + ": Input 20/30/10", Parcelsize.S, p);
	}
}

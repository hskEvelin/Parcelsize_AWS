package service;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.PostConstruct;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;



@RestController
@RequestMapping("/parcel/sent")
public class ParcelsizeController {
	private ParcelsizeCalculator calc;
	
	
	@PostConstruct
	public void init() {
		calc = new ParcelsizeCalculator();
	}
	
	@CrossOrigin
    @RequestMapping(method=RequestMethod.POST, value = "/size")
    public Parcel calculateParcelSize(@RequestBody String json) {
    	Gson g = new Gson();
		Parcel parcel = g.fromJson(json, Parcel.class);
		System.out.println(parcel);
		String resp = "";
		if(parcel != null){
			parcel.setSize(calc.calculateParcelsize(parcel));
			resp = g.toJson(parcel);
		}else{
			System.out.println("No Parcel transmitted: Could not deserialize JSON-String to Object");
			resp = "No Parcel transmitted: Could not deserialize JSON-String to Object";
		}
		
		System.out.println("Response: " + g.toJson(parcel));
		return parcel;
    }
	 
	@RequestMapping(method=RequestMethod.GET, value = "/test/dbcon")
	public DbStatus testDBConnection() {
		return calc.getDbStatus();
	}
	
}

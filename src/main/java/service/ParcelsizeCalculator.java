package service;

import java.util.HashMap;
import java.util.Map;

public class ParcelsizeCalculator {
	private Map<Integer, Parcelsize> parcelSizeMap;
	private int MAX_GIRTH = 300;
	private IDatabaseHandler db;
	
	
	public ParcelsizeCalculator() {
		db = MySQLDatabaseHandler.getDatabaseHandler();
		
		db.openConnection("jdbc:mysql://mysql-parcelsize:3306/ms_parcel_size?user=user&password=userpassword");
		
		parcelSizeMap = new HashMap<Integer,Parcelsize>();
		parcelSizeMap = db.getParcelSizeTable();
	}
	
	public ParcelsizeCalculator(IDatabaseHandler db) {
		this.db = db;
		parcelSizeMap = new HashMap<Integer,Parcelsize>();
		parcelSizeMap = db.getParcelSizeTable();
	}
	
	public Parcelsize calculateParcelsize(Parcel parcel) {
		int girth = parcel.getGirth();
		
		if(girth < MAX_GIRTH){
			int dim = parcel.getLongestSide()+parcel.getShortestSide();
			for (Map.Entry<Integer, Parcelsize> entry : parcelSizeMap.entrySet())
			{
				if(dim <= entry.getKey()){
					return entry.getValue();
				}
			}
			return Parcelsize.UNDEFINED;
			//parcel.setSize(Parcelsize.M);
		}else{
			return Parcelsize.UNDEFINED;
		}
	}
	
	public DbStatus getDbStatus() {
		try {
			db.openConnection("jdbc:mysql://localhost:3306/ms_parcel_size?user=root&password=evelinroot");
			return DbStatus.CONNECTED;
		}catch(Exception e) {
			return DbStatus.NO_CONNECTION;
		}
		
	}
	
	
}

package com.rest.data.request.position_entry;

public class BeaconEntry {
	private String beaconAp;
    private Double signalStrength;
    private String knownDeviceId;
	
    public String getBeaconAp() {
		return beaconAp;
	}
	
    public void setBeaconAp(String beaconAp) {
		this.beaconAp = beaconAp;
	}
	
    public Double getSignalStrength() {
		return signalStrength;
	}
	
    public void setSignalStrength(Double signalStrength) {
		this.signalStrength = signalStrength;
	}

	public String getKnownDeviceId() {
		return knownDeviceId;
	}

	public void setKnownDeviceId(String knownDeviceId) {
		this.knownDeviceId = knownDeviceId;
	}
    
    

}

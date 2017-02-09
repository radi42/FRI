package com.rest.data.request.position_entry;

public class WifiEntry {
	
	private Double signalStrength;
	private String accessPoint;
	private String knownDeviceId;
	
	public Double getSignalStrength() {
		return signalStrength;
	}
	
	public void setSignalStrength(Double signalStrength) {
		this.signalStrength = signalStrength;
	}
	
	public String getAccessPoint() {
		return accessPoint;
	}
	
	public void setAccessPoint(String accessPoint) {
		this.accessPoint = accessPoint;
	}

	public String getKnownDeviceId() {
		return knownDeviceId;
	}

	public void setKnownDeviceId(String knownDeviceId) {
		this.knownDeviceId = knownDeviceId;
	}
	
	

	
}

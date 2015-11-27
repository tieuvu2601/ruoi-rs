package com.banvien.portal.vms.bean;


import java.io.Serializable;

public class FileItem implements Serializable {
	private byte[] data;
	private String originalFilename;
	private long lastModified;// millis
	private String path;
	private String hrefPath;
	private String mimeType;

	public byte[] getData() {
		return data;
	}

	public void setData(byte[] data) {
		this.data = data;
	}

	public String getOriginalFilename() {
		return originalFilename;
	}

	public void setOriginalFilename(String originalFilename) {
		this.originalFilename = originalFilename;
	}

	public long getLastModified() {
		return lastModified;
	}

	public void setLastModified(long lastModified) {
		this.lastModified = lastModified;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public String getHrefPath() {
		return hrefPath;
	}

	public void setHrefPath(String hrefPath) {
		this.hrefPath = hrefPath;
	}

	public String getMimeType() {
		return mimeType;
	}

	public void setMimeType(String mimeType) {
		this.mimeType = mimeType;
	}
}

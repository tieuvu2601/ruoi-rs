package com.banvien.portal.vms.editor;


import com.banvien.portal.vms.bean.FileItem;
import org.springframework.beans.propertyeditors.ClassEditor;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

public class FileItemMultipartFileEditor extends ClassEditor {

	public void setValue(Object value) {
		if (value instanceof MultipartFile) {
			MultipartFile multipartFile = (MultipartFile) value;
			try {
				FileItem fileItem = new FileItem();
				fileItem.setData(multipartFile.getBytes());
				fileItem.setOriginalFilename(multipartFile.getOriginalFilename());
				super.setValue(fileItem);
			}
			catch (IOException ex) {
				IllegalArgumentException iae = new IllegalArgumentException("Cannot read contents of multipart file");
				iae.initCause(ex);
				throw iae;
			}
		}
		else if (value instanceof byte[]) {
			super.setValue(value);
		}
		else {
			super.setValue(value != null ? value.toString().getBytes() : null);
		}
	}

	public String getAsText() {
		byte[] value = (byte[]) getValue();
		return (value != null ? new String(value) : "");
	}

}

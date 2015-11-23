package com.banvien.portal.vms.editor;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.beans.PropertyEditorSupport;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @author Vien Nguyen Hai
 * 
 */
public class CustomDateEditor extends PropertyEditorSupport {
	private transient final Log log = LogFactory.getLog(getClass());
	private String dateFormat = "dd/MM/yyyy";
	public CustomDateEditor(String dateFormat) {
		this.dateFormat = dateFormat;
	}
	public CustomDateEditor(){}
	public void setAsText(String text) throws IllegalArgumentException {
		if (text != null && text.trim().length() > 1) {
			SimpleDateFormat format = new SimpleDateFormat(dateFormat);
			try {
				Date d = (Date) format.parse(text);
				setValue(new Timestamp(d.getTime()));
			} catch (Exception e) {
				log.error("Invalid date format [" + dateFormat + "]" + e.getMessage());
			}
		}

	}
}

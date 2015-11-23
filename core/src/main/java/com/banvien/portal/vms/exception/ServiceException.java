/**
 * Copyright (c) 2011 by Triumph Learning. All rights reserved.
 */
package com.banvien.portal.vms.exception;

/**
 * @author Nguyen Hai Vien
 *
 */
public class ServiceException extends Exception {
	/**
	 * 
	 */
	private static final long serialVersionUID = -8711956879534393734L;

	/**
	 * Constructor for ServiceException 
	 * @param message Exception message
	 */
	public ServiceException(final String message) {
		super(message);
	}
	
	/**
	 * Constructor for ServiceException.
	 * @param msg the detail message
	 * @param cause the root cause (usually from using a underlying
	 * data access API such as JDBC)
	 */
	public ServiceException(String msg, Throwable cause) {
		super(msg, cause);
	}
}

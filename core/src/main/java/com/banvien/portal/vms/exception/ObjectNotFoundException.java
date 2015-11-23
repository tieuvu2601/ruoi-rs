/**
 * Copyright (c) 2011 by Triumph Learning. All rights reserved.
 * 
 */
package com.banvien.portal.vms.exception;

/**
 * <p>This exception hierarchy aims to let user code find and handle the object not found
 * when retrieving object from the database</p>
 * 
 * @author Nguyen Hai Vien
 *
 */
public class ObjectNotFoundException extends ServiceException{
	/**
	 * Determines if a de-serialized file is compatible with this class.
	 */
	private static final long serialVersionUID = -6722815726639819077L;

	/**
	 * Constructor for ObjectNotFoundException 
	 * @param message Exception message
	 */
	public ObjectNotFoundException(final String message) {
		super(message);
	}
	
	/**
	 * Constructor for ObjectNotFoundException.
	 * @param msg the detail message
	 * @param cause the root cause (usually from using a underlying
	 * data access API such as JDBC)
	 */
	public ObjectNotFoundException(String msg, Throwable cause) {
		super(msg, cause);
	}
}

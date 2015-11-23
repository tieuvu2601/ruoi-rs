/**
 * Copyright 2011 by Triumph Learning. All rights reserved. 
 *
 */
package com.banvien.portal.vms.exception;

/**
 *  <p>This exception hierarchy aims to let user code find and handle the duplicate object
 * when save or update object into the database</p>
 * 
 * @author Nguyen Hai Vien
 *
 */
public class DuplicateException extends ServiceException {
	/**
	 * Determines if a de-serialized file is compatible with this class.
	 */
	private static final long serialVersionUID = -1434525425010139450L;

	/**
	 * Constructor for DuplicateException.
	 * @param msg the detail message
	 */
	public DuplicateException(final String message) {
		super(message);
	}
	
	/**
	 * Constructor for DuplicateException.
	 * @param msg the detail message
	 * @param cause the root cause (usually from using a underlying
	 * data access API such as JDBC)
	 */
	public DuplicateException(String msg, Throwable cause) {
		super(msg, cause);
	}
}

package com.banvien.portal.vms.dto;

public class UserDTO {
	private String commonName;
	private String displayName;
	private String mailfile;
	private String userName;
	private String password;
	private String lastName;
	private String firstName;
	private String mail;
    private String department;

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

	public String getCommonName() {
		return commonName;
	}
	public void setCommonName(String commonName) {
		this.commonName = commonName;
	}
	
	public String getMailfile() {
		return mailfile;
	}
	public void setMailfile(String mailfile) {
		this.mailfile = mailfile;
	}
	public String getDisplayName() {
		return displayName;
	}
	public void setDisplayName(String displayName) {
		this.displayName = displayName;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String toString() {
		StringBuffer userDTOStr = new StringBuffer("Person=[");
		userDTOStr.append(" Common Name = " + commonName);
		userDTOStr.append(", User Name = " + userName);
		userDTOStr.append(", password = " + password);
		userDTOStr.append(", Display Name = " + displayName);
		userDTOStr.append(", lastname = " + lastName);
		userDTOStr.append(", firstname = " + firstName);
		userDTOStr.append(", mail = " + mail);
		userDTOStr.append(", mailfile = " + mailfile);		
		userDTOStr.append(" ]");
		return userDTOStr.toString();
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastname) {
		this.lastName = lastname;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstname) {
		this.firstName = firstname;
	}
	public String getMail() {
		return mail;
	}
	public void setMail(String mail) {
		this.mail = mail;
	}
	
	
}

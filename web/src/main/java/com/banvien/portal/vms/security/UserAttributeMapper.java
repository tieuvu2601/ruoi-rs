package com.banvien.portal.vms.security;

import com.banvien.portal.vms.dto.UserDTO;
import org.springframework.ldap.core.AttributesMapper;

import javax.naming.NamingException;
import javax.naming.directory.Attribute;
import javax.naming.directory.Attributes;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class UserAttributeMapper implements AttributesMapper{
	private String uidName = "uid";
	public UserAttributeMapper() {
		super();
	}
	public UserAttributeMapper(String uidName) {
		super();
		this.uidName = uidName;
	}
	public Object mapFromAttributes(Attributes attributes) throws NamingException {
		UserDTO userDTO = new UserDTO();
		String commonName = (String)attributes.get("cn").get();
		if(commonName != null){
			userDTO.setCommonName(commonName);
		}	
		String displayName = (String)attributes.get("displayName").get();
		if(displayName != null) {
			userDTO.setDisplayName(displayName);
		}
		Attribute mailfile = attributes.get("mailfile");
		if(mailfile != null) {
			userDTO.setMailfile((String)mailfile.get());
		}	
		Attribute uid = attributes.get(uidName);
		if(uid != null) {
			userDTO.setUserName((String)uid.get());
		}	
		Attribute lastname = attributes.get("sn");
		if(lastname != null) {
			userDTO.setLastName((String)lastname.get());
		}
		Attribute firstname = attributes.get("givenname");
		if(firstname != null) {
			userDTO.setFirstName((String)firstname.get());
		}
		Attribute mail = attributes.get("mail");
		if(mail != null) {
			userDTO.setMail((String)mail.get());
		}
        String distinguishedName = (String)attributes.get("distinguishedName").get();
        if(distinguishedName != null) {
            Pattern regOrgUnit = Pattern.compile("(OU=[^,]*)") ;
            Matcher matcher = regOrgUnit.matcher(distinguishedName);
            if (matcher.find()) {
                String s = matcher.group(0);
                String tmp[] = s.split("=");
                if (tmp.length > 1)  {
                    userDTO.setDepartment(tmp[1]);
                }
            }
        }
		return userDTO;
	}

}

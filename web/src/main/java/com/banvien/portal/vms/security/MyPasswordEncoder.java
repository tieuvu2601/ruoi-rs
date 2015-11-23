/**
 * 
 */
package com.banvien.portal.vms.security;

import com.banvien.portal.vms.dao.UserDAO;
import com.banvien.portal.vms.domain.User;
import com.banvien.portal.vms.dto.C2UserDTO;
import org.springframework.dao.DataAccessException;
import org.springframework.security.authentication.encoding.PasswordEncoder;

/**
 * @author Nguyen Hai Vien
 *
 */
public class MyPasswordEncoder implements PasswordEncoder {
    private LdapUserLookup ldapUserLookup;
    private UserDAO userDAO;

    public void setLdapUserLookup(LdapUserLookup ldapUserLookup) {
        this.ldapUserLookup = ldapUserLookup;
    }

    public void setUserDAO(UserDAO userDAO) {
        this.userDAO = userDAO;
    }

    public String encodePassword(String password, Object salt)
			throws DataAccessException {
		return EncoderUtil.md5EncoderWithBaseAndSalt(password);
	}

	public boolean isPasswordValid(String encPass, String rawPass, Object salt)
			throws DataAccessException {
        boolean res = false;
        if(!res){
            User user = userDAO.findUserByUsernameAndPasswordFromDB(encPass, rawPass);
            if (user != null && user.getStatus() != null && user.getStatus().toString().equals("1")) {
                res = true;
            }
        }


//        try{
//		    res = ldapUserLookup.authenticate(encPass, rawPass);
//        }catch (Exception ex) {
//
//        }
//        if (!res) {
//            C2UserDTO c2UserDTO = userDAO.findC2UserByUsernameAndPassword(encPass, rawPass);
//            if (c2UserDTO != null && c2UserDTO.getStatus() != null && c2UserDTO.getStatus().equals("1")) {
//                res = true;
//            }
//        }
        return res;
	}

}

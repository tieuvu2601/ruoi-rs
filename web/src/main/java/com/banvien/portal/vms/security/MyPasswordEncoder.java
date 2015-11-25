package com.banvien.portal.vms.security;

import com.banvien.portal.vms.dao.UserDAO;
import com.banvien.portal.vms.domain.User;
import org.springframework.dao.DataAccessException;
import org.springframework.security.authentication.encoding.PasswordEncoder;


public class MyPasswordEncoder implements PasswordEncoder {
    private UserDAO userDAO;

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
        return res;
	}

}

package com.banvien.portal.vms.security;

import com.banvien.portal.vms.dto.UserDTO;

import java.util.List;

public interface LdapUserLookup {

	public boolean authenticate(String username, String password);
	public UserDTO getUser(String userName);
    public List<UserDTO> searchByDisplayName(String displayName);
}

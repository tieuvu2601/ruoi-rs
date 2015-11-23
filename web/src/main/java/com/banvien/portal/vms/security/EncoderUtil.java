package com.banvien.portal.vms.security;


import org.springframework.security.authentication.encoding.Md5PasswordEncoder;

/**
 * @author Nguyen Hai Vien
 * 
 */

public class EncoderUtil {
	public static String md5EncoderWithBaseAndSalt(String value) {
		Md5PasswordEncoder encode1 = new Md5PasswordEncoder();
		encode1.setEncodeHashAsBase64(true);
		String b = encode1.encodePassword(value, "C0reSecurity");
		return b;
	}

	public static String md5EncoderStandard(String value) {
		Md5PasswordEncoder encode = new Md5PasswordEncoder();
		encode.setEncodeHashAsBase64(false);
		String a = encode.encodePassword(value, null);
		return a;
	}

	public static String md5EncoderWithBaseAndSalt(String value, String salt) {
		Md5PasswordEncoder encode1 = new Md5PasswordEncoder();
		encode1.setEncodeHashAsBase64(true);
		String b = encode1.encodePassword(value, salt);
		return b;
	}

}

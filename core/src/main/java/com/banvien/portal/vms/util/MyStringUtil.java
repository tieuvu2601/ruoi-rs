package com.banvien.portal.vms.util;

import java.text.Normalizer;

/**
 * Created by Ban Vien Ltd.
 * User: Vien Nguyen (vien.nguyen@banvien.com)
 * Date: 5/2/13
 * Time: 1:38 PM
 */
public class MyStringUtil {
    public static String removeDiacritic(String str) {
		String result = Normalizer.normalize(str, Normalizer.Form.NFD);
		result = result.replaceAll("\\p{InCombiningDiacriticalMarks}+", "");
//		result = result.replace('đ', 'd');
//		result = result.replace('Đ', 'D');
		result = result.replaceAll("[^a-z A-Z0-9-]", "");
		return result;
	}
}

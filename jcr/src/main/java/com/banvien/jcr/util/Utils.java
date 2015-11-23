package com.banvien.jcr.util;


public class Utils {
	// jdk1.5
	/*public static String normalize(String str){
		String result = sun.text.Normalizer.normalize(str, sun.text.Normalizer.DECOMP, 0 );
        result = result.replaceAll("\\p{InCombiningDiacriticalMarks}+",
                "").replace('\u0111', 'd').replace('\u0110', 'D');
        return result;
	}*/
	// jdk1.6	
	public static String normalize(String str){
		String result = java.text.Normalizer.normalize(str, java.text.Normalizer.Form.NFD );
        result = result.replaceAll("\\p{InCombiningDiacriticalMarks}+", "").replace('\u0111', 'd').replace('\u0110', 'D');
        return result;
	}
	
}

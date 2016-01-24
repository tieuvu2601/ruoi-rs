package com.banvien.portal.vms.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Constants {
	/**
     * Sort direction constants
     */
    public static final String SORT_ASC = "2";
    public static final String SORT_DESC = "1";

    public static final int PENDING = 0;
    public static final int UPLOAD_FILE_ITEMS = 5;


    public static final Map<String,String> MAP_AGENT_STATUS = new HashMap<String,String>();
    static {
    	MAP_AGENT_STATUS.put("T", "Terminated");
    	MAP_AGENT_STATUS.put("A", "Active");
    }
    public static final Map<String,String> MAP_CASE_STATUS = new HashMap<String,String>();
    static {
    	MAP_CASE_STATUS.put("1", "Close at SUP");
    	MAP_CASE_STATUS.put("2", "Close at ADC");
    	MAP_CASE_STATUS.put("3", "Pending at CMP");
    	MAP_CASE_STATUS.put("4", "Pending at SUP");
    	MAP_CASE_STATUS.put("5", "Pending at ADC");
    	MAP_CASE_STATUS.put("6", "Substantiated");
    	MAP_CASE_STATUS.put("7", "Not Substantiated");
    	MAP_CASE_STATUS.put("8", "Pending Investigate");
    }

    public static final Integer TAT_DATE = 10;
    

    //~ Static fields/initializers =============================================

    public static final String DATE_FORMAT = "MM/dd/yyyy";

    public static final String ALPHABET_SEARCH_PREFIX = "^$^";

    public static final String BUNDLE_KEY = "ApplicationResources";

    public static final String FILE_SEP = System.getProperty("file.separator");

    public static final String USER_HOME = System.getProperty("user.home") + FILE_SEP;

    public static final String CONFIG = "appConfig";

    public static final String PREFERRED_LOCALE_KEY = "org.apache.struts2.action.LOCALE";

    public static final String LIST_MODEL_KEY = "items";

    public static final String FORM_MODEL_KEY = "item";



    public static final String ACEGI_SECURITY_FORM_USERNAME_KEY = "j_username";
	public static final String ACEGI_SECURITY_FORM_PASSWORD_KEY = "j_password";

	public static final String ACEGI_SECURITY_LAST_USERNAME_KEY = "ACEGI_SECURITY_LAST_USERNAME";

    /**
     * Crudaction
     */
    public static final String ACTION_DELETE = "delete";


    public static final String MESSAGE_RESPONSE_MODEL_KEY = "messageResponse";

    public static final String LOGON_ROLE = "LOGON";

    public static final String FULL_ACCESS_RIGHT = "FULL_ACCESS_RIGHT";

    /**
     * ContentEntity Type
     */
    public static final String CONTENT_TYPE_BOOLEAN = "BOOLEAN";
    public static final String CONTENT_TYPE_NUMERIC = "NUMERIC";
    public static final String CONTENT_TYPE_PLAIN_TEXT = "PLAIN_TEXT";
    public static final String CONTENT_TYPE_RICH_TEXT = "RICH_TEXT";
    public static final String CONTENT_TYPE_IMAGE = "IMAGE";
    public static final String CONTENT_TYPE_ATTACHMENT = "ATTACHMENT";
    
    public static final Integer CONTENT_SAVE = 0;
    public static final Integer CONTENT_PUBLISH = 1;

    public static final String FLAG_YES = "Y";
    public static final String FLAG_NO = "N";

    public static final String UP_COMING_EVENT = "upcoming";

    public static final String PAST_EVENT = "past";

    public static final String UNIT_M2 = "m2";
    public static final String UNIT_UNIT = "unit";
    public static final String UNIT_HECTA = "hecta";

    public static final String CATEGORY_RECENT_NEWS = "tin tuc";

    public static final String EMAIL_ADDRESS = "tieuvu2601@gmail.com";
    public static final String EMAIL_PASSWORD = "ThienDuong0209";

}

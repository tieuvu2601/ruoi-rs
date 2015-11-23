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
    /**
     * group code
     */
    public static final String GROUP_ADMIN = "ADMIN";
    public static final String GROUP_AUTHOR = "AUTHOR";
    public static final String GROUP_EDITOR = "EDITOR";
    public static final String GROUP_APPROVER = "APPROVER";
    public static final String GROUP_PUBLISHER = "PUBLISHER";
    public static final String GROUP_GUEST = "GUEST";
    
    /**
     * Process status
     */
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
    /**
     * The Alphabet number for search query
     */
    public static final String ALPHABET_SEARCH_PREFIX = "^$^";
    /**
     * The name of the ResourceBundle used in this application
     */
    public static final String BUNDLE_KEY = "ApplicationResources";

    /**
     * File separator from System properties
     */
    public static final String FILE_SEP = System.getProperty("file.separator");

    /**
     * User home from System properties
     */
    public static final String USER_HOME = System.getProperty("user.home") + FILE_SEP;

    /**
     * The name of the configuration hashmap stored in application scope.
     */
    public static final String CONFIG = "appConfig";

    /**
     * Session scope attribute that holds the locale set by the user. By setting this key
     * to the same one that Struts uses, we get synchronization in Struts w/o having
     * to do extra work or have two session-level variables.
     */
    public static final String PREFERRED_LOCALE_KEY = "org.apache.struts2.action.LOCALE";

    /**
     * The request scope attribute that holds the list form
     */
    public static final String LIST_MODEL_KEY = "items";

    /**
     * The request scope attribute that holds the form
     */
    public static final String FORM_MODEL_KEY = "item";


    /**
     * The name of the Administrator role, as specified in web.xml
     */
    public static final String ADMIN_ROLE = "ADMIN";

    public static final String SUPPORT_ROLE = "SUPPORT";


    /**
     * The name of the user's role list, a request-scoped attribute
     * when adding/editing a user.
     */
    public static final String USER_ROLES = "userRoles";

    /**
     * The name of the available roles list, a request-scoped attribute
     * when adding/editing a user.
     */
    public static final String AVAILABLE_ROLES = "availableRoles";

    /**
     * The name of the CSS Theme setting.
     */
    public static final String CSS_THEME = "csstheme";

    public static final String MOBI8_URL = "mobi8url";


    /**
     * Acegi security constants
     */

    public static final String ACEGI_SECURITY_FORM_USERNAME_KEY = "j_username";
	public static final String ACEGI_SECURITY_FORM_PASSWORD_KEY = "j_password";

	public static final String ACEGI_SECURITY_LAST_USERNAME_KEY = "ACEGI_SECURITY_LAST_USERNAME";

    /**
     * Crudaction
     */
    public static final String ACTION_DELETE = "delete";
    public static final String ACTION_REJECT = "reject";
    public static final String ACTION_PUBLIC = "public";

    public static final String ACTION_SEARCH = "search";
    public static final String ACTION_INSERT_UPDATE = "insert-update";
    public static final String ACTION_IMPORT = "import";

    public static final String MESSAGE_RESPONSE_MODEL_KEY = "messageResponse";

    public static final String LOGON_ROLE = "LOGON";

    public static final String FULL_ACCESS_RIGHT = "FULL_ACCESS_RIGHT";

    /**
     * Jbpm
     */
    public static final String CONTENT_PAGEFLOW_PROCESS_KEY = "ContentPageflow";
    public static final String CONTENT_PAGEFLOW_PROCESS_FILE_NAME = "processDefinition.jpdl.xml";
    
    public static final String EDITOR_PAGEFLOW_PROCESS_KEY = "EditorPageflow";
    public static final String EDITOR_PAGEFLOW_PROCESS_FILE_NAME = "editorProcess.jpdl.xml";
    
    public static final String APPROVER_PAGEFLOW_PROCESS_KEY = "ApproverPageflow";
    public static final String APPROVER_PAGEFLOW_PROCESS_FILE_NAME = "approverProcess.jpdl.xml";
    
    public static final String PUBLISHER_PAGEFLOW_PROCESS_KEY = "PublisherPageflow";
    public static final String PUBLISHER_PAGEFLOW_PROCESS_FILE_NAME = "publisherProcess.jpdl.xml";
    
    /**
     * import case
     */

    
    /**
     * jbpm temp users
     */
    public static final String JBPM_USER_AUTHOR = "_jbpm_temp_user_author_";
    public static final String JBPM_USER_EDITOR = "_jbpm_temp_user_editor_";
    public static final String JBPM_USER_APPROVER = "_jbpm_temp_user_approver_";
    public static final String JBPM_USER_PUBLISHER = "_jbpm_temp_user_publisher_";
    public static final String JBPM_USER_ADMIN = "_jbpm_temp_user_admin_";

    /**
     * Content Type
     */
    public static final String CONTENT_TYPE_BOOLEAN = "BOOLEAN";
    public static final String CONTENT_TYPE_NUMERIC = "NUMERIC";
    public static final String CONTENT_TYPE_PLAIN_TEXT = "PLAIN_TEXT";
    public static final String CONTENT_TYPE_RICH_TEXT = "RICH_TEXT";
    public static final String CONTENT_TYPE_IMAGE = "IMAGE";
    public static final String CONTENT_TYPE_ATTACHMENT = "ATTACHMENT";
    
    public static final Integer CONTENT_SAVE = -2;
    public static final Integer CONTENT_REJECT = -1;
    public static final Integer CONTENT_WAITING_APPROVE = 0;
    public static final Integer CONTENT_APPROVE = 1;
    public static final Integer CONTENT_PUBLISH = 2;


    /**
     * Comment
     */
    public static final int COMMENT_REJECT = 0;
    public static final int COMMENT_PUBLISH = 1;
    
    public static final String FLAG_YES = "Y";
    public static final String FLAG_NO = "N";
    //Poll
    public static final String[] MAP_POLL_RESULT_COLOR = new String[] {
            "red", "green", "blue","pink", "orange"};

    //find top views
    public static final int NO_OF_DAYS_AGO = 7;

    public static final String DOCUMENT_AUTHORING_CODE = "tai-lieu";

    public static final int CONTENT_ALLOW_SHARE = 1;

    public static final int CONTENT_NOT_ALLOW_SHARE = 2;


    public static final int CRAWLER_NOT_START = 0;

    public static final int CRAWLER_IN_PROGRESS = 1;

    public static final int CRAWLER_DONE = 2;

    public static final Integer FEEDBACK_NEW = 0;
    public static final Integer FEEDBACK_REPLIED = 1;

    public static final String SEPERATE = ",";

    public static final Integer MAX_PAGE_ITEMS = 6;

    public static final String EVENTS_CATEGORY_CODE = "events";

    public static final String JOBS_CATEGORY_CODE = "jobs resource";

    public static final String UP_COMING_EVENT = "upcoming";

    public static final String PAST_EVENT = "past";

    public static final String PAGE_PREFIX_URL = "page";
    public static final String NEW_PREFIX_URL = "page";
    public static final String EVENT_PREFIX_URL = "event";
    public static final String PERSON_AUTHORING_PREFIX_URL = "person";
    public static final String RESEARCH_PROJECTS_PREFIX_URL = "researches";
    public static final String RESEARCH_PROJECT_PREFIX_URL = "research";
    public static final String RESEARCH_GROUP_PREFIX_URL = "research-group";
    public static final String PRODUCT_PREFIX_URL = "product";
    public static final String GALLERY_PREFIX_URL = "gallery";
    public static final String ALBUM_PREFIX_URL = "album";
    public static final String COLLABORATION_PREFIX_URL = "collaboration";
    public static final String EXPERT_CORNER_PREFIX_URL = "expert";
    public static final String PREFIX_ENGLISH_LANGUAGE = "-eng";
}

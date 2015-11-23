package com.banvien.portal.vms.webapp.servlet.fck;



import net.fckeditor.localization.LocalizedMessages;
import net.fckeditor.requestcycle.ThreadLocalData;
import net.fckeditor.response.UploadResponse;

import org.apache.commons.lang.StringUtils;

public class CKUploadResponse extends UploadResponse{

	private String sCKECallback;

	public CKUploadResponse(String sCKECallback, Object... arguments) {
		super(arguments);
		this.sCKECallback = sCKECallback;
	}

	/** Creates an <code>OK</code> response. */
	public static CKUploadResponse getOK(String fileUrl, String sCKECallback) {
		return new CKUploadResponse(sCKECallback, EN_OK, fileUrl);
	}

	/** Creates a <code>FILE RENAMED</code> warning. */
	public static CKUploadResponse getFileRenamedWarning(String fileUrl,
			String newFileName, String sCKECallback) {
		LocalizedMessages lm = LocalizedMessages.getInstance(ThreadLocalData
				.getRequest());
		return new CKUploadResponse(sCKECallback, EN_FILE_RENAMED_WARNING, fileUrl,
				newFileName, lm.getFileRenamedWarning(newFileName));
	}

	/** Creates a <code>INVALID FILE TYPE</code> error. */
	public static CKUploadResponse getInvalidFileTypeError() {
		LocalizedMessages lm = LocalizedMessages.getInstance(ThreadLocalData
				.getRequest());
		return new CKUploadResponse(null, EN_INVALID_FILE_TYPE_ERROR, lm
				.getInvalidFileTypeSpecified());
	}

	/** Creates a <code>INVALID COMMAND</code> error. */
	public static CKUploadResponse getInvalidCommandError() {
		LocalizedMessages lm = LocalizedMessages.getInstance(ThreadLocalData
				.getRequest());
		return new CKUploadResponse(null, EN_CUSTOM_ERROR, null, null, lm
				.getInvalidCommandSpecified());
	}

	/** Creates a <code>INVALID RESOURCE TYPE</code> error. */
	public static CKUploadResponse getInvalidResourceTypeError() {
		LocalizedMessages lm = LocalizedMessages.getInstance(ThreadLocalData
				.getRequest());
		return new CKUploadResponse(null, EN_CUSTOM_ERROR, null, null, lm
				.getInvalidResouceTypeSpecified());
	}

	/** Creates a <code>INVALID CURRENT FOLDER</code> error. */
	public static CKUploadResponse getInvalidCurrentFolderError() {
		LocalizedMessages lm = LocalizedMessages.getInstance(ThreadLocalData
				.getRequest());
		return new CKUploadResponse(null, EN_CUSTOM_ERROR, null, null, lm
				.getInvalidCurrentFolderSpecified());
	}

	/** Creates a <code>FILE UPLOAD DISABLED</code> error. */
	public static CKUploadResponse getFileUploadDisabledError() {
		LocalizedMessages lm = LocalizedMessages.getInstance(ThreadLocalData
				.getRequest());
		return new CKUploadResponse(null, EN_SECURITY_ERROR, null, null, lm
				.getFileUploadDisabled());
	}

	/** Creates a <code>FILE UPLOAD WRITE</code> error. */
	public static CKUploadResponse getFileUploadWriteError() {
		LocalizedMessages lm = LocalizedMessages.getInstance(ThreadLocalData
				.getRequest());
		return new CKUploadResponse(null, EN_CUSTOM_ERROR, null, null, lm
				.getFileUploadWriteError());
	}

	/**
	 * Creates the HTML/JS representation of this upload response.
	 * 
	 * @return HTML/JS representation of this upload response
	 */
	@Override
	public String toString() {
		StringBuffer sb = new StringBuffer(400);
		sb.append("<script type=\"text/javascript\">\n");
		// Compressed version of the document.domain automatic fix script.
		// The original script can be found at
		// [fckeditor_dir]/_dev/domain_fix_template.js
		sb.append("(function(){var d=document.domain;while (true){try{var A=window.parent.document.domain;break;}catch(e) {};d=d.replace(/.*?(?:\\.|$)/,'');if (d.length==0) break;try{document.domain=d;}catch (e){break;}}})();\n");
		sb.append("window.parent.OnUploadCompleted(");

		for (Object parameter : parameters) {
			if (parameter instanceof Integer) {
				sb.append(parameter);
			} else {
				sb.append("'");
				if (parameter != null)
					sb.append(parameter);
				sb.append("'");
			}
			sb.append(",");
		}

		sb.deleteCharAt(sb.length() - 1);
		sb.append(");\n");
		if(StringUtils.isNotBlank(sCKECallback) && parameters != null && parameters.length > 1) {
			sb.append("window.parent.CKEDITOR.tools.callFunction(").append("\"").append(sCKECallback).append("\",\"").append(parameters[1]).append("\"");
//			if(parameters.length > 3) {
//				sb.append(", \"").append(parameters[3]).append("\"");
//			}
			sb.append(");");
			sb.append("\n");
		}
		sb.append("</script>");

		return sb.toString();
	}
}
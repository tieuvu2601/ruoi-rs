package com.banvien.portal.vms.util;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @author Nguyen Hai Vien
 * 
 */
public class FileUtils {
	private static final int BUFSIZE = 2 << 15;
	
	public static String getCommonPath(HttpServletRequest request) {
		String baseDir = CommonUtil.getBaseFolder();
		ServletContext context = request.getSession().getServletContext();
		String realBaseDir = context.getRealPath(baseDir);
		File baseFile = new File(realBaseDir);
		if (!baseFile.exists()) {
			baseFile.mkdir();
		}
		// Get commonPath in String form
		String commonPath = CommonUtil.getBaseFolder()
				+ CommonUtil.getCommonFolderName();
		return commonPath;
	}

	public static String getCurrentPath(HttpServletRequest request)
			throws ServletException {

		// Check type file is allowed
		// String typeStr = request.getParameter("Type");

		String currentPath = getCommonPath(request);
		// Create a directory with path "/type/" in WEB-INF
		currentPath = request.getContextPath() + currentPath;
		return currentPath;

	}

	public static String getCurrentDirPath(HttpServletRequest request)
			throws IOException, ServletException {
		// Get realpath in WEB-INF
		ServletContext context = request.getSession().getServletContext();
		String currentDirPath = context.getRealPath(getCurrentPath(request));

		// Creae a file or directory object
		File currentDir = new File(currentDirPath);

		// create directory "/type/" if not exist
		if (!currentDir.exists()) {
			currentDir.mkdir();
		}

		return currentDirPath;
	}

	public static String getCommonDirPath(HttpServletRequest request) {
		ServletContext context = request.getSession().getServletContext();

		// Get realpath in WEB-INF
		String commonDirPath = context.getRealPath(getCommonPath(request));

		// Create a directory
		File commonDir = new File(commonDirPath);
		if (!commonDir.exists()) {
			commonDir.mkdir();
		}
		return commonDirPath;
	}

	public static String upload(HttpServletRequest request, String destFolder,
			MultipartFile uplFile) throws IOException, ServletException {
		String fileName = normalizeFilename(uplFile.getOriginalFilename());
		File pathToSave = buildDestinationFile(request, destFolder, fileName);
		// Save to file
		uplFile.transferTo(pathToSave);
		return pathToSave.getName();
	}

	public static File buildDestinationFile(HttpServletRequest request,
			String destFolder, String fileName) {
		ServletContext context = request.getSession().getServletContext();
		String commonDirpath = context.getRealPath(destFolder);
		File baseFile = new File(commonDirpath);
		if (!baseFile.exists()) {
			baseFile.mkdir();
		}

		String newName = "";
		// Parse the request
		// Get just file name of upload file
		
		newName = normalizeFilename(fileName);
		// Get name withoout exension , get extension
		String nameWithoutExt = normalizeFilename(CommonUtil
				.getNameWithoutExtension(fileName));
		String ext = CommonUtil.getExtension(fileName);
		
		// ********************PATH to SAVE FILE************************
		File pathToSave = new File(commonDirpath, fileName);

		int counter = 1;
		// Check if existed, generating new file name
		while (pathToSave.exists()) {
			// New filename = name(counter).ext
			StringBuffer buffer = new StringBuffer();
			buffer.append(nameWithoutExt).append("(").append(counter).append(")").append(".").append(ext);
			newName = buffer.toString();

			// Create new file to receive uploaded file
			pathToSave = new File(commonDirpath, newName);

			counter++;
		}
		return pathToSave;
	}

	
	private static String normalizeFilename(String fileName) {
		String res = fileName.replaceAll(" ", "_");
		return res;
	}

	
	public static void save(byte[] input, String outputFilename)
			throws IOException {
		FileOutputStream fileOutputStream = new FileOutputStream(outputFilename, false);
		fileOutputStream.write(input);
		fileOutputStream.flush();
		fileOutputStream.close();
	}

	public static void remove(String filename){
		File file = new File(filename);
		file.delete();
	}

	public static void removeUploadedFile(HttpServletRequest request,
			String desFolder, String filename) throws Exception {
		ServletContext context = request.getSession().getServletContext();
		File file = new File(context.getRealPath(desFolder) + File.separatorChar + filename);
		file.delete();

	}

	public static void downLoadFile(HttpServletResponse response,
			String filePath) throws IOException {
		ServletOutputStream out = null;
		try {
			FileInputStream in = new FileInputStream(filePath);
			out = response.getOutputStream();
			int lastSlash = filePath.lastIndexOf(String.valueOf(File.separatorChar));
			String fileName = CommonUtil.generateUUID();
			if (lastSlash > 0) {
				fileName = filePath.substring(lastSlash + 1, filePath.length());
			}
			response.setContentType(String.format("application/octet-stream; name=\"{0}\"", fileName));
			response.setHeader("ContentEntity-Disposition", String.format("attachment; filename=\"{0}\"", fileName));
			response.setContentLength(in.available());

			byte[] buf = new byte[BUFSIZE];
			int count = 0;
			while ((count = in.read(buf)) != -1) {
				out.write(buf, 0, count);
			}
			in.close();
		} finally {
			if (out != null) {
				out.flush();
				out.close();
			}
		}
	}

	public static void downLoadCsvFile(HttpServletResponse response,
			String filePath, String downloadFileName) throws IOException {
		ServletOutputStream out = null;
		try {
			FileInputStream in = new FileInputStream(filePath);
			out = response.getOutputStream();
			
			response.setContentType(String.format("application/octet-stream; name=%s", downloadFileName));
			response.setHeader("ContentEntity-Disposition", String.format("attachment; filename=%s", downloadFileName));
			response.setContentLength(in.available());

			byte[] buf = new byte[BUFSIZE];
			int count = 0;
			while ((count = in.read(buf)) != -1) {
				out.write(buf, 0, count);
			}
			in.close();
		} finally {
			if (out != null) {
				out.flush();
				out.close();
			}
		}
	}
	public static void removeAbsoluteFile(HttpServletRequest request,
			String filename) {
		ServletContext context = request.getSession().getServletContext();
		File file = new File(context.getRealPath("/") + File.separatorChar + filename);
		file.delete();

	}

    public static List<String> doUpload(HttpServletRequest request){
        MultipartHttpServletRequest mRequest = (MultipartHttpServletRequest) request;
        Map<String, MultipartFile> map = mRequest.getFileMap();
        String uploadFolder = "/files/";
        List<String> fileNames = new ArrayList<String>();
        String fileName;
        for(int i = 0; i < Constants.UPLOAD_FILE_ITEMS; i++){
            fileName = "";
            MultipartFile file = (MultipartFile) map.get("file[" + i +"]");
            if(file == null || file.isEmpty()){
                continue;
            }
            try {
                fileName = FileUtils.upload(request, uploadFolder, file);
                fileNames.add(fileName);
            } catch (IOException e) {
            } catch (ServletException e) {
            }
        }
        return fileNames;
    }
}

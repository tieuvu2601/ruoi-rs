package com.banvien.portal.vms.webapp.servlet.fck;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import net.fckeditor.connector.Connector;
import net.fckeditor.connector.exception.FolderAlreadyExistsException;
import net.fckeditor.connector.exception.InvalidCurrentFolderException;
import net.fckeditor.connector.exception.InvalidNewFolderNameException;
import net.fckeditor.connector.exception.ReadException;
import net.fckeditor.connector.exception.WriteException;
import net.fckeditor.handlers.RequestCycleHandler;
import net.fckeditor.handlers.ResourceType;
import net.fckeditor.requestcycle.ThreadLocalData;

import org.apache.commons.io.IOUtils;
import org.apache.commons.io.filefilter.DirectoryFileFilter;
import org.apache.commons.lang.StringUtils;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.banvien.jcr.api.FileItem;
import com.banvien.jcr.api.IJcrContent;
import com.banvien.portal.vms.core.context.AppContext;
import com.banvien.portal.vms.util.BeanUtils;
import com.banvien.portal.vms.webapp.jcr.JcrConstants;

public class FCKAction implements Connector{

	private ServletContext servletContext;
	
	private IJcrContent jcrContent;
	
	@Override
	public void init(ServletContext servletContext) throws Exception {
		this.servletContext = servletContext;
		ApplicationContext ctx = WebApplicationContextUtils.getRequiredWebApplicationContext(servletContext);
        AppContext.setApplicationContext(ctx);
        jcrContent = ctx.getBean(IJcrContent.class);
	}

	@Override
	public List<Map<String, Object>> getFiles(ResourceType type,
			String currentFolder) throws InvalidCurrentFolderException,
			ReadException {
		List<Map<String, Object>> files = new ArrayList<Map<String, Object>>();
		Object obj = null;
		String path = "";
		if(type.equals(ResourceType.IMAGE)){
			path = JcrConstants.IMAGES_PATH;
		}else if(type.equals(ResourceType.FLASH)){
			path = JcrConstants.FLASH_PATH;
		}else if(type.equals(ResourceType.FILE)){
			path = JcrConstants.FILE_PATH;
		}else if(type.equals(ResourceType.MEDIA)){
			path = JcrConstants.MEDIA_PATH;
		}
		if(StringUtils.isNotEmpty(currentFolder) && currentFolder.length() > 1){
			currentFolder = currentFolder.substring(0, currentFolder.length() - 1);
			path += currentFolder;
		}
		if(StringUtils.isNotEmpty(path)){
			obj = jcrContent.getAll(path);
		}
		if(obj != null){
			Object[] objs = (Object[])obj;
			int size = Integer.valueOf(objs[0].toString());
			if(size > 0){
				List<FileItem> fileItems = (List<FileItem>)objs[1];
				if(fileItems.size() > 0){
					Map<String, Object> fileMap;
					for (FileItem file : fileItems) {
						fileMap = new HashMap<String, Object>(3);
						fileMap.put(Connector.KEY_NAME, file.getOriginalFilename());
						fileMap.put(Connector.KEY_SIZE, file.getData().length);
						fileMap.put("url", this.servletContext.getContextPath() + "/" + JcrConstants.REP_SVL + "/" + path + "/" + file.getOriginalFilename());
						files.add(fileMap);
					}
				}
			}
		}
		return files;
	}

	@Override
	public List<String> getFolders(ResourceType type, String currentFolder)
			throws InvalidCurrentFolderException, ReadException {
		String absolutePath = getRealUserFilesAbsolutePath(RequestCycleHandler
				.getUserFilesAbsolutePath(ThreadLocalData.getRequest()));
		File typeDir = getOrCreateResourceTypeDir(absolutePath, type);
		File currentDir = new File(typeDir, currentFolder);
		if (!currentDir.exists() || !currentDir.isDirectory())
			throw new InvalidCurrentFolderException();

		String[] fileList = currentDir.list(DirectoryFileFilter.DIRECTORY);
		return Arrays.asList(fileList);
	}

	@Override
	public void createFolder(ResourceType type, String currentFolder,
			String newFolder) throws InvalidCurrentFolderException,
			InvalidNewFolderNameException, FolderAlreadyExistsException,
			WriteException {
		String absolutePath = getRealUserFilesAbsolutePath(RequestCycleHandler
				.getUserFilesAbsolutePath(ThreadLocalData.getRequest()));
		File typeDir = getOrCreateResourceTypeDir(absolutePath, type);
		File currentDir = new File(typeDir, currentFolder);
		if (!currentDir.exists() || !currentDir.isDirectory())
			throw new InvalidCurrentFolderException();

		File newDir = new File(currentDir, newFolder);
		if (newDir.exists())
			throw new FolderAlreadyExistsException();
		if (!newDir.mkdir())
			throw new InvalidNewFolderNameException();
		
	}

	@Override
	public String fileUpload(ResourceType type, String currentFolder,
			String fileName, InputStream inputStream)
			throws InvalidCurrentFolderException, WriteException{
		String path = "";
		if(type.equals(ResourceType.IMAGE)){
			path = JcrConstants.IMAGES_PATH;
		}else if(type.equals(ResourceType.FLASH)){
			path = JcrConstants.FLASH_PATH;
		}else if(type.equals(ResourceType.FILE)){
			path = JcrConstants.FILE_PATH;
		}else if(type.equals(ResourceType.MEDIA)){
			path = JcrConstants.MEDIA_PATH;
		}
		if(StringUtils.isNotEmpty(currentFolder) && currentFolder.length() > 1){
			currentFolder = currentFolder.substring(0, currentFolder.length() - 1);
			path += currentFolder;
		}
		try {
			com.banvien.portal.vms.bean.FileItem fileItem = new com.banvien.portal.vms.bean.FileItem();
			fileItem.setData(IOUtils.toByteArray(inputStream));
			fileItem.setOriginalFilename(fileName);
			fileItem.setHrefPath("/" + path + "/" + fileName);
			fileItem.setPath("/" + path + "/" + fileName);
			fileName = jcrContent.write(path, BeanUtils.toJcrFileItem(fileItem));
		} catch (IOException e) {
			throw new WriteException();
		}
		return fileName;
	}

	private File getOrCreateResourceTypeDir(final String baseDir,
			final ResourceType type) {
		File dir = new File(baseDir, type.getPath());
		if (!dir.exists())
			dir.mkdirs();
		return dir;
	}
	
	private String getRealUserFilesAbsolutePath(String userFilesAbsolutePath) {
		return servletContext.getRealPath(userFilesAbsolutePath);
	}

}

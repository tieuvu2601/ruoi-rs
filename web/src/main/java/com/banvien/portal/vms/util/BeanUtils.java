package com.banvien.portal.vms.util;

import java.io.IOException;

import com.banvien.portal.vms.bean.FileItem;
import org.springframework.web.multipart.MultipartFile;

public class BeanUtils {
	public static com.banvien.jcr.api.FileItem toJcrFileItem(
			FileItem fileItem) {
		com.banvien.jcr.api.FileItem jcrFileItem = new com.banvien.jcr.api.FileItem();
		jcrFileItem.setData(fileItem.getData());
		jcrFileItem.setHrefPath(fileItem.getHrefPath());
		jcrFileItem.setLastModified(fileItem.getLastModified());
		jcrFileItem.setOriginalFilename(fileItem.getOriginalFilename());
		jcrFileItem.setPath(fileItem.getPath());
		jcrFileItem.setMimeType(fileItem.getMimeType());
		return jcrFileItem;
	}

	public static FileItem toFileItem(
			com.banvien.jcr.api.FileItem jcrFileItem) {
		FileItem fileItem = new FileItem();
		fileItem.setData(jcrFileItem.getData());
		fileItem.setHrefPath(jcrFileItem.getHrefPath());
		fileItem.setLastModified(jcrFileItem.getLastModified());
		fileItem.setOriginalFilename(jcrFileItem.getOriginalFilename());
		fileItem.setPath(jcrFileItem.getPath());
		fileItem.setMimeType(jcrFileItem.getMimeType());
		return fileItem;
	}
	
	public static com.banvien.jcr.api.FileItem multipartFile2FileItem(MultipartFile mFileItem){
		com.banvien.jcr.api.FileItem fileItem = new com.banvien.jcr.api.FileItem();
		try {
			fileItem.setData(mFileItem.getBytes());
			fileItem.setOriginalFilename(mFileItem.getOriginalFilename());
			fileItem.setMimeType(mFileItem.getContentType());
			return fileItem;
		} catch (IOException e) {
		}
		return null;
	}
}

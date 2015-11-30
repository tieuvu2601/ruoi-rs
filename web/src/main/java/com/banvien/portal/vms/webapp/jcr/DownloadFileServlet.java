package com.banvien.portal.vms.webapp.jcr;

import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.banvien.jcr.api.IJcrContent;
import com.banvien.portal.vms.util.BeanUtils;
import com.banvien.portal.vms.util.ImageUtils;

public class DownloadFileServlet extends HttpServlet{
	private transient final Logger logger = Logger.getLogger(getClass());
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * Constructor of the object.
	 */
	public DownloadFileServlet() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	/**
	 * The doGet method of the servlet. <br>
	 * 
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request
	 *            the request send by the client to the server
	 * @param response
	 *            the response send by the server to the client
	 * @throws ServletException
	 *             if an error occurred
	 * @throws IOException
	 *             if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		OutputStream out = response.getOutputStream();
		try {
			ApplicationContext cxt = WebApplicationContextUtils
					.getWebApplicationContext(this.getServletContext());
			IJcrContent jcrContent = (IJcrContent) cxt.getBean("jcrContent");
            String requestURI = request.getRequestURI();
            int repIndex = requestURI.indexOf(JcrConstants.REP_SVL) + JcrConstants.REP_SVL.length();
			String path = requestURI.substring(repIndex);
            if (path.indexOf(";") > 0) {
                path = path.substring(0, path.indexOf(";") - 1);
            }
			com.banvien.portal.vms.bean.FileItem fileItem = BeanUtils.toFileItem(jcrContent.getFileItem(path));
			String fileName = "";
			try {
				fileName = java.net.URLEncoder.encode(fileItem
						.getOriginalFilename(), "UTF-8");
			} catch (UnsupportedEncodingException e) {
				logger.error(e.getMessage(), e);
			}
			String contentType = fileItem.getMimeType();
            String fileNameRef = fileItem.getOriginalFilename().toLowerCase();

			if(!contentType.startsWith("image") && !contentType.contains("flash") &&
                    !(fileNameRef.contains(".png") || fileNameRef.contains(".jpg") || fileNameRef.contains(".gif") || fileNameRef.contains(".jpeg"))) {
				response.setHeader("Content-disposition", "attachment; filename=" + fileName);
			}else if(contentType.startsWith("image") || (fileNameRef.contains(".png") || fileNameRef.contains(".jpg") || fileNameRef.contains(".gif") || fileNameRef.contains(".jpeg"))){
				String sWidth = request.getParameter("w");
				String sHeight = request.getParameter("h");
				String sFit = request.getParameter("f");
				if(sHeight != null && !sHeight.isEmpty()) {
					try {
						int height = Integer.valueOf(sHeight);
						int width = 0;
						int fit = 0;
						if(sWidth != null && !sWidth.isEmpty()) {
							try {
								width = Integer.valueOf(sWidth);
							}catch(NumberFormatException nf) {
								logger.debug("Fail to get scale width for " + path);
							}
						}
						if(sFit != null && !sFit.isEmpty()) {
							try {
								fit = Integer.valueOf(sFit);
							}catch(NumberFormatException nf) {
								logger.debug("Fail to get scale fit param for " + path);
							}
						}
						byte[] scaledImage = ImageUtils.resizeImageAsJPG(fileItem.getData(), width, height, fit);
						fileItem.setData(scaledImage);
						
					}catch (NumberFormatException nf) {
						logger.error("Fail to get scale height for " + path, nf);
					}catch (IOException io) {
						logger.error("Fail to scale image " + path, io);
					}catch (Exception e) {
						logger.error("An error occurred when scaling image " + path, e);
					}
				}
			}
			response.setContentType(contentType);

			out.write(fileItem.getData());
			out.flush();
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
		} finally {
			out.close();
		}
	}

	/**
	 * Initialization of the servlet. <br>
	 * 
	 * @throws ServletException
	 *             if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
	}
}

/*
 * $Header: /cvsroot/mvnforum/mvnforum/src/com/mvnforum/common/AttachmentUtil.java,v 1.24.2.1 2010/08/17 04:28:32 minhnn Exp $
 * $Author: minhnn $
 * $Revision: 1.24.2.1 $
 * $Date: 2010/08/17 04:28:32 $
 *
 * ====================================================================
 *
 * Copyright (C) 2002-2007 by MyVietnam.net
 *
 * All copyright notices regarding mvnForum MUST remain
 * intact in the scripts and in the outputted HTML.
 * The "powered by" text/logo with a link back to
 * http://www.mvnForum.com and http://www.MyVietnam.net in
 * the footer of the pages MUST remain visible when the pages
 * are viewed on the internet or intranet.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 * Support can be obtained from support forums at:
 * http://www.mvnForum.com/mvnforum/index
 *
 * Correspondence and Marketing Questions can be sent to:
 * info at MyVietnam net
 *
 * @author: Minh Nguyen
 * @author: Mai  Nguyen
 */
package com.mvnforum.common;

import java.io.File;
import java.io.IOException;
import java.util.Collection;
import java.util.Iterator;

import net.myvietnam.mvncore.exception.DatabaseException;
import net.myvietnam.mvncore.service.BinaryStorageService;
import net.myvietnam.mvncore.service.MvnCoreServiceFactory;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.mvnforum.MVNForumConfig;
import com.mvnforum.db.AttachmentBean;
import com.mvnforum.db.DAOFactory;
import com.mvnforum.search.attachment.AttachmentIndexer;

public final class AttachmentUtil {

    private static final Log log = LogFactory.getLog(AttachmentUtil.class);

    private AttachmentUtil() {
    }

    public static String getAttachFilenameOnDisk(int attachID) {
        String filename = MVNForumConfig.getAttachmentDir() + File.separatorChar + attachID + ".mvn";
        return filename;
    }

    public static String getAlbumItemFilenameOnDisk(String memberName, String albumName, int albumItemID) {
        String filename = MVNForumConfig.getAlbumItemDir() + File.separatorChar + memberName.toLowerCase() +
                                File.separatorChar + albumName.toLowerCase() + File.separatorChar + albumItemID + ".mvn";
        return filename;
    }

    public static String getAlbumItemDirOnDisk(String memberName, String albumName) {
        String dir = MVNForumConfig.getAlbumItemDir() + File.separatorChar + memberName.toLowerCase() +
                                File.separatorChar + albumName.toLowerCase();
        return dir;
    }

    public static String getAlbumPropertiesFileOnDisk(String memberName, String albumName) {
        String dir = MVNForumConfig.getAlbumItemDir() + File.separatorChar + memberName.toLowerCase() +
                                File.separatorChar + albumName.toLowerCase() + File.separatorChar + "album.properties";
        return dir;
    }

    public static String getAlbumDirOnDisk(String memberName) {
        String dir = MVNForumConfig.getAlbumItemDir() + File.separatorChar + memberName.toLowerCase();

        return dir;
    }

    /*
    // remove, now use BinaryStorage
    public static void deleteAttachFilenameOnDisk(int attachID) {
        String filename = getAttachFilenameOnDisk(attachID);
        try {
            log.info("About to delete post attachment = " + filename);
            FileUtil.deleteFile(filename);
        } catch (Exception ex) {
            log.warn("Cannot delete post attachment file " + filename, ex);
            //@todo schedule to delete it later
        }
    }*/

    public static String getPmAttachFilenameOnDisk(int attachID) {
        String filename = MVNForumConfig.getPmAttachmentDir() + File.separatorChar + attachID + ".mvn";
        return filename;
    }

    /*public static void deletePmAttachFilenameOnDisk(int pmAttachID) {
        String filename = getPmAttachFilenameOnDisk(pmAttachID);
        try {
            log.info("About to delete message attachment = " + filename);
            FileUtil.deleteFile(filename);
        } catch (Exception ex) {
            log.warn("Cannot delete message attachment file " + filename, ex);
            //@todo schedule to delete it later
        }
    }*/

    /**
     * NOTE: This method should be called before any attemp to delete a forum
     * because it require the forum is exited
     * After calling this method, go ahead and delete the forum
     *
     * NOTE: For Admin only
     */
    public static void deleteAttachments_inForum(int forumID) throws DatabaseException {

        BinaryStorageService binaryStorage = MvnCoreServiceFactory.getMvnCoreService().getBinaryStorageService();

        // First, try to delete attachment in database
        Collection attachmentBeans = DAOFactory.getAttachmentDAO().getAttachments_inForum(forumID);

        log.info("Delete forum = " + forumID + " attachment count = " + attachmentBeans.size());

        //now delete files on disk
        for (Iterator iter = attachmentBeans.iterator(); iter.hasNext(); ) {
            AttachmentBean attachmentBean = (AttachmentBean)iter.next();
            int attachID = attachmentBean.getAttachID();

            //this method already catch the exception
            //AttachmentUtil.deleteAttachFilenameOnDisk(attachID);
            try {
                binaryStorage.deleteData(BinaryStorageService.CATEGORY_POST_ATTACHMENT, String.valueOf(attachID), null);
            } catch (IOException ex) {
                log.error("Cannot delete file", ex);
                // actually this exception is never existed
            }

            try {
                DAOFactory.getAttachmentDAO().delete(attachID);
            } catch (Exception ex) {
                log.warn("Cannot delete attachment in database", ex);
            }

            // Then delete in Lucene index
            AttachmentIndexer.scheduleDeleteAttachmentTask(attachID);
        }
    }

}

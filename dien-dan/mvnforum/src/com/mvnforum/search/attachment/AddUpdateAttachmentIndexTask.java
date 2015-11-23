/*
 * $Header: /cvsroot/mvnforum/mvnforum/src/com/mvnforum/search/attachment/AddUpdateAttachmentIndexTask.java,v 1.4 2008/05/30 04:41:34 minhnn Exp $
 * $Author: minhnn $
 * $Revision: 1.4 $
 * $Date: 2008/05/30 04:41:34 $
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
 * @author: Dejan Krsmanovic dejan_krsmanovic@yahoo.com
 */
package com.mvnforum.search.attachment;

import java.util.TimerTask;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.mvnforum.db.AttachmentBean;

//This class is used for indexing single attachment
public class AddUpdateAttachmentIndexTask extends TimerTask {

    private static final Log log = LogFactory.getLog(AddUpdateAttachmentIndexTask.class);

    //Constants used for operations
    public static final int OPERATION_ADD    = 0;
    public static final int OPERATION_UPDATE = 1;

    private AttachmentBean attachmentBean;
    private int operation;

    /*
     * Contructor with default access, prevent new an instance from outside package
     */
    AddUpdateAttachmentIndexTask(AttachmentBean attachmentBean, int operation) {
        this.attachmentBean = attachmentBean;
        this.operation = operation;
    }

    public void run() {
        log.debug("AddUpdateAttachmentIndexTask.run : op = " + operation + " for AttachmentID = " + attachmentBean.getAttachID());
        try {
            switch (operation) {
                case OPERATION_UPDATE:
                    AttachmentIndexer.deleteAttachmentFromIndex(attachmentBean.getAttachID());
                    // fall through
                case OPERATION_ADD:
                    AttachmentIndexer.addAttachmentToIndex(attachmentBean);
                    break;
                default:
                    log.warn("Cannot process the AddUpdateAttachmentIndexTask with operation = " + operation);
            }
        } catch (Exception ex) {
            log.error("Error while performing index operation", ex);
        }
    }

}

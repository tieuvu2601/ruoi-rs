/*
 * $Header: /cvsroot/mvnforum/mvnforum/src/com/mvnforum/admin/importexport/jive/JiveMessageXML.java,v 1.7 2007/01/15 10:27:36 dungbtm Exp $
 * $Author: dungbtm $
 * $Revision: 1.7 $
 * $Date: 2007/01/15 10:27:36 $
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
 * @author: Igor Manic   
 */
package com.mvnforum.admin.importexport.jive;

import com.mvnforum.admin.PostXML;
import com.mvnforum.admin.importexport.XMLUtil;
import com.mvnforum.db.DAOFactory;
import net.myvietnam.mvncore.exception.*;

/**
 * @author Igor Manic
 * @version $Revision: 1.7 $, $Date: 2007/01/15 10:27:36 $
 * <br/>
 * <code>JiveMessageXML</code> class encapsulates processing of
 * messages' definitions found in the Jive XML file. It implements
 * methods to be called from XML parsing routine, adds some additional
 * processing and checking, and calls corresponding methods of
 * <code>PostXML</code> and other neccessary classes in order to perform
 * the actual creation of a post.
 */
public class JiveMessageXML {

    private PostXML postXML=null;
    private boolean postCreated=false;
    //only one of parentJiveMessage and parentJiveThread will be defined (later), and the other will be null
    private JiveThreadXML parentJiveThread   =null;
    private JiveMessageXML parentJiveMessage =null;

    public JiveMessageXML() {
        super();
        postXML=new PostXML();
        postCreated=false;
        parentJiveThread=null;
        parentJiveMessage=null;
    }

    public void setPostID(String id) {
        postXML.setPostID(id);
    }

    /**
     * This method simply calls <code>setPostID()</code>.
     * It's defined only to avoid property-setter problems with digester
     * (since it doesn't seem to recognize <code>setPostID()</code> as a setter
     * method for <code>postID</code> property).
     */
    public void setPostId(String id) {
        setPostID(id);
    }

    public int getPostID() {
        return postXML.getPostID();
    }

    public int getParentCategoryID() {
        return postXML.getParentCategoryID();
    }

    public int getParentForumID() {
        return postXML.getParentForumID();
    }

    public int getParentThreadID() {
        return postXML.getParentThreadID();
    }

    public int getParentPostID() {
        return postXML.getParentPostID();
    }

    public void setParentThreadOrPost(Object o)
    throws ForeignKeyNotFoundException {
        if (o instanceof JiveThreadXML) {
            parentJiveThread=(JiveThreadXML)o;
            //warning: parent thread might not be added to database yet
            parentJiveMessage=null;
        } else if (o instanceof JiveMessageXML) {
            parentJiveMessage=(JiveMessageXML)o;
            //warning: parent post might be not added to database yet
            parentJiveThread=null;
        } else {
            throw new ForeignKeyNotFoundException("Can't find neither parent thread nor message.");
        }
    }

    private String postSubject=null;
    public void setPostSubject(String value) throws CreateException {
        if ( (value==null) || (value.equals("")) ) {
            throw new CreateException("Cannot create a post with an empty PostSubject.");
        } else this.postSubject=value;
    }

    private String postBody=null;
    public void setPostBody(String value) throws CreateException {
        if ( (value==null) || (value.equals("")) ) {
            throw new CreateException("Cannot create a post with an empty PostBody.");
        } else this.postBody=value;
    }

    private String postUsername=null;
    public void setPostUsername(String value) throws CreateException {
        this.postUsername=value;
    }

    private String postCreationDate=null;
    public void setPostCreationDate(String value) throws CreateException {
        this.postCreationDate=value;
    }

    private String postModifiedDate=null;
    public void setPostModifiedDate(String value) throws CreateException {
        this.postModifiedDate=value;
    }

    public void addJiveMessage() throws CreateException, DuplicateKeyException,
    ObjectNotFoundException, DatabaseException, ForeignKeyNotFoundException, BadInputException {
        /* First, check if the digester already called this method.
         * It will happen even under normal circumstances, if this message has
         * subelements that need it already be defined, so they first call
         * this method to create message before creating data that refer him.
         */
        if (postCreated) return;
        /* Second, create parent message or thread if it's not yet created. */
        if (parentJiveMessage!=null) {
            parentJiveMessage.addJiveMessage();
            postXML.setParentPostID(parentJiveMessage.getPostID());
            postXML.setParentThreadID(parentJiveMessage.getParentThreadID());
            postXML.setParentForumID(parentJiveMessage.getParentForumID());
            postXML.setParentCategoryID(parentJiveMessage.getParentCategoryID());
        } else if (parentJiveThread!=null) {
            parentJiveThread.addJiveThread(postUsername, postSubject, postBody);
            //postXML.setParentPostID(0) is not neccessary
            postXML.setParentThreadID(parentJiveThread.getThreadID());
            postXML.setParentForumID(parentJiveThread.getParentForumID());
            postXML.setParentCategoryID(parentJiveThread.getParentCategoryID());
        }

        ImportJive.addMessage("Adding Jive message \""+postSubject+"\".");
        postXML.addPost(postUsername/*memberName*/, postUsername/*lastEditMemberName*/,
                        postSubject/*postTopic*/, postBody,
                        postCreationDate, postModifiedDate/*postLastEditDate*/,
                        null/*postCreationIP*/, null/*postLastEditIP*/,
                        null/*postEditCount*/, null/*postFormatOption*/,
                        null/*postOption*/, null/*postStatus*/,
                        null/*postIcon*/, null/*postAttachCount*/);
        postCreated=true;

        if ((postUsername!=null) && (postUsername.length()>0)) {
            DAOFactory.getMemberDAO().increasePostCount(
                   DAOFactory.getMemberDAO().getMemberIDFromMemberName(postUsername));
        }
        if (parentJiveMessage!=null) {
            parentJiveMessage.updateAddedReplyPost(postXML, postUsername, postCreationDate);
        } else if (parentJiveThread!=null) {
            parentJiveThread.updateAddedPost(postXML, postUsername, XMLUtil.stringToSqlTimestampDefNull(postCreationDate));
        }
    }

    public void updateAddedReplyPost(PostXML subPost, String postUsername, String postCreationDate)
    throws ObjectNotFoundException, DatabaseException, ForeignKeyNotFoundException {
        if ((!postCreated) || (postXML.getPostID()<0)) return; //todo Igor: process this error
        //nothing to update in this post data
        if (parentJiveMessage!=null) {
            parentJiveMessage.updateAddedReplyPost(subPost, postUsername, postCreationDate);
        } else if (parentJiveThread!=null) {
            parentJiveThread.updateAddedPost(subPost, postUsername, XMLUtil.stringToSqlTimestampDefNull(postCreationDate));
        }
    }


}



/*
 * $Header: /cvsroot/mvnforum/mvnforum/src/com/mvnforum/auth/MVNCmsPermissionWebHelper.java,v 1.4 2008/05/30 04:41:22 minhnn Exp $
 * $Author: minhnn $
 * $Revision: 1.4 $
 * $Date: 2008/05/30 04:41:22 $
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
 * @author: Phuong, Pham Dinh Duy
 */
package com.mvnforum.auth;

import java.sql.*;
import java.util.ArrayList;

import net.myvietnam.mvncore.db.DBUtils;
import net.myvietnam.mvncore.exception.DatabaseException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.mvnforum.MVNForumConstant;
import com.mvnforum.db.MemberGroupDAO;

public class MVNCmsPermissionWebHelper {

    private static final Log log = LogFactory.getLog(MVNCmsPermissionWebHelper.class);

    private static final String MemberGroup     = MemberGroupDAO.TABLE_NAME;

    //TODO: change here later
    private static final String GROUP_CHANNEL_STEP    = "mvncmsGroupChannelStepPerm";

    static ArrayList getGroupPermissionsInStepWithChannel(int memberID) throws DatabaseException {

        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        ArrayList retValue = new ArrayList();

        StringBuffer sql = new StringBuffer(512);
        sql.append("SELECT DISTINCT StepID, ChannelID, Permission");// belong to table GroupForum
        sql.append(" FROM ").append(GROUP_CHANNEL_STEP).append(" groupchannelstep, ").append(MemberGroup).append(" memgroup");
        sql.append(" WHERE ( (groupchannelstep.GroupID = memgroup.GroupID) AND (memgroup.MemberID = ?) )");
        if ((memberID!=0) && (memberID!=MVNForumConstant.MEMBER_ID_OF_GUEST)) {
            sql.append(" OR groupchannelstep.GroupID = ").append(MVNForumConstant.GROUP_ID_OF_REGISTERED_MEMBERS);
        }

        try {
            connection = DBUtils.getConnection();
            statement = connection.prepareStatement(sql.toString());
            statement.setInt(1, memberID);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                CmsPermission cmsPermission = new CmsPermission();
                cmsPermission.setStepID(resultSet.getInt("StepID"));
                cmsPermission.setChannelID(resultSet.getInt("ChannelID"));
                cmsPermission.setPermission(resultSet.getInt("Permission"));
                retValue.add(cmsPermission);
            }
            return retValue;
        } catch(SQLException sqle) {
            log.error("Sql Execution Error!", sqle);
            throw new DatabaseException("Error executing SQL in MVNCmsPermissionWebHelper.getGroupPermissionsInStepWithChannel.");
        } finally {
            DBUtils.closeResultSet(resultSet);
            DBUtils.closeStatement(statement);
            DBUtils.closeConnection(connection);
        }
    }

}
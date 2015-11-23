/*
 * $Header: /cvsroot/mvnforum/mvnforum/src/com/mvnforum/common/Attic/RemoteUserUtil.java,v 1.10 2008/06/01 17:22:06 minhnn Exp $
 * $Author: minhnn $
 * $Revision: 1.10 $
 * $Date: 2008/06/01 17:22:06 $
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
 * @author: Phong Ta Quoc
 */
package com.mvnforum.common;

import java.sql.Date;
import java.sql.Timestamp;

import net.myvietnam.mvncore.exception.*;

import net.myvietnam.mvncore.util.DateUtil;
import net.myvietnam.mvncore.util.ParamUtil;
import net.myvietnam.mvncore.web.GenericRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.mvnforum.MVNForumConfig;
import com.mvnforum.MVNForumConstant;
import com.mvnforum.auth.OnlineUserManager;
import com.mvnforum.db.*;
import com.mvnforum.search.member.MemberIndexer;

public final class RemoteUserUtil {

    private static final Log log = LogFactory.getLog(RemoteUserUtil.class);

    private RemoteUserUtil() {
    }

    public static void createAccount(String memberName, GenericRequest request)
        throws ObjectNotFoundException, CreateException, DatabaseException, DuplicateKeyException,
        ForeignKeyNotFoundException {

        Timestamp now = DateUtil.getCurrentGMTTimestamp();
        Date memberBirthday = new Date(now.getTime());

        // You should think of creating the email based on your company policy
        String email = memberName + "@yourdomain.com";

        DAOFactory.getMemberDAO().create(memberName, OnlineUserManager.PASSWORD_OF_METHOD_CUSTOMIZATION, email,
                        email, MemberBean.MEMBER_EMAIL_VISIBLE, MemberBean.MEMBER_NAME_VISIBLE,
                        request.getRemoteAddr(), request.getRemoteAddr(), 0/* memberViewCount */,
                        0/* memberPostCount */, now /*memberCreationDate*/, now /*memberModifiedDate*/, now /*memberExpireDate*/, now /*memberPasswordExpireDate*/, now/* memberLastLogon */, 0,
                        MemberBean.MEMBER_STATUS_ENABLE, ""/* memberActivateCode */, ""/* memberTempPassword */,
                        0/* memberMessageCount */, 0, 10, 0/* memberWarnCount */,
                        0/* memberVoteCount */, 0/* memberVoteTotalStars */,
                        0/* memberRewardPoints */, ""/* memberTitle */, 0/* memberTimeZone */,
                        ""/* memberSignature */, ""/* memberAvatar */, ""/* memberSkin */,
                        ""/* memberLanguage */, ""/* memberFirstname */, ""/* memberLastname */,
                        MemberBean.MEMBER_GENDER_MALE/* memberGender */, memberBirthday, ""/* memberAddress */,
                        ""/* memberCity */, ""/* memberState */, ""/* memberCountry */,
                        ""/* memberPhone */, ""/* memberMobile */, ""/* memberFax */,
                        ""/* memberCareer */, ""/* memberHomepage */, ""/* memberYahoo */,
                        ""/* memberAol */, ""/* memberIcq */, ""/* memberMsn */,
                        ""/* memberCoolLink1 */, ""/* memberCoolLink2 */);

        // Now, create 4 default folders for each member
        int memberID = MemberCache.getInstance().getMemberIDFromMemberName(memberName);
        int folderStatus = 0;
        int folderOption = 0;
        int folderType = 0;
        DAOFactory.getMessageFolderDAO().create(MVNForumConstant.MESSAGE_FOLDER_INBOX, memberID,
                                                0/* order */, folderStatus, folderOption,
                                                folderType, now, now);
        DAOFactory.getMessageFolderDAO().create(MVNForumConstant.MESSAGE_FOLDER_DRAFT, memberID,
                                                1/* order */, folderStatus, folderOption,
                                                folderType, now, now);
        DAOFactory.getMessageFolderDAO().create(MVNForumConstant.MESSAGE_FOLDER_SENT, memberID,
                                                2/* order */, folderStatus, folderOption,
                                                folderType, now, now);
        DAOFactory.getMessageFolderDAO().create(MVNForumConstant.MESSAGE_FOLDER_TRASH, memberID,
                                                3/* order */, folderStatus, folderOption,
                                                folderType, now, now);

        // Add member to the lucene index
        MemberBean memberBean = DAOFactory.getMemberDAO().getMember(memberID);
        MemberIndexer.scheduleAddMemberTask(memberBean);

        // now, if require activation, then we will send mail
        // Note that because after this page succeed,
        // we redirect to usermanagement so not use mvnforum.mail.failed now
        if (MVNForumConfig.getRequireActivation()) {
            String serverName = ParamUtil.getServerPath(); // ParamUtil.getServer2(request);
            try {
                SendMailUtil.sendActivationCodeEmail(memberID, serverName);
            } catch (Exception ex) {
                log.error("Cannot send mail after registration!", ex);
                request.setAttribute("mvnforum.mail.failed",
                                     "Cannot send activation email after registration!");
                // @todo: save the error message to displayed later
            }
        }
    }
}

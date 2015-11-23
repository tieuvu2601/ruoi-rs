/*
 * $Header: /cvsroot/mvnforum/myvietnam/src/net/myvietnam/mvncore/service/impl/BinaryStorageServiceImplBase.java,v 1.2 2007/01/15 10:31:19 dungbtm Exp $
 * $Author: dungbtm $
 * $Revision: 1.2 $
 * $Date: 2007/01/15 10:31:19 $
 *
 * ====================================================================
 *
 * Copyright (C) 2002-2007 by MyVietnam.net
 *
 * All copyright notices regarding MyVietnam and MyVietnam CoreLib
 * MUST remain intact in the scripts and source code.
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
 *
 * Correspondence and Marketing Questions can be sent to:
 * info at MyVietnam net
 *
 * @author: Minh Nguyen
 */
package net.myvietnam.mvncore.service.impl;

import java.io.*;

import net.myvietnam.mvncore.service.BinaryStorageService;
import net.myvietnam.mvncore.service.BinaryStorageHandle;
import net.myvietnam.mvncore.util.FileUtil;

public abstract class BinaryStorageServiceImplBase implements BinaryStorageService {

    public BinaryStorageHandle storeData(String category, String nameId, String fileName, byte[] data,
                                         int attachDataFileSize, int attachOption, int attachStatus, String contentType, String storageIP)
        throws IOException {

        return storeData(category, nameId, fileName, new ByteArrayInputStream(data, 0, attachDataFileSize),
                         attachDataFileSize, attachOption, attachStatus, contentType, storageIP);
    }

    public byte[] loadData(String category, String nameId, BinaryStorageHandle handle)
        throws IOException {

        InputStream inputStream = getInputStream(category, nameId, handle);
        return FileUtil.getBytes(inputStream);
    }

    public void updateData(String category, String nameId, BinaryStorageHandle handle)
        throws IOException {

        throw new RuntimeException("Not emplemented yet.");
    }
}

package com.banvien.portal.vms.bean;

import com.banvien.portal.vms.domain.Category;
import com.banvien.portal.vms.dto.CropImageDTO;

import java.util.List;

/**
 * Copyright (c) by Ban Vien Co., Ltd.
 * User: MBP
 * Date: 11/13/12
 * Time: 5:40 PM
 * Author: vien.nguyen@banvien.com
 */
public class CropImageBean extends AbstractBean<CropImageDTO> {
    public CropImageBean()
    {
        this.pojo = new CropImageDTO();
    }
    
    public Integer getImgHeight() {
		return imgHeight;
	}
	public void setImgHeight(Integer imgHeight) {
		this.imgHeight = imgHeight;
	}

	public Integer getImgWidth() {
		return imgWidth;
	}

	public void setImgWidth(Integer imgWidth) {
		this.imgWidth = imgWidth;
	}

	private Integer imgWidth;
    private Integer imgHeight;

}

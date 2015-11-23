package com.banvien.portal.vms.dto;

public class CropImageDTO {
	private Long contentID;
	private Float cropX;
    private Float cropY;
    private Float cropWidth;
    private Float cropHeight;

    public Long getContentID() {
        return contentID;
    }

    public void setContentID(Long contentID) {
        this.contentID = contentID;
    }

    public Float getCropX() {
        return cropX;
    }

    public void setCropX(Float cropX) {
        this.cropX = cropX;
    }

    public Float getCropY() {
        return cropY;
    }

    public void setCropY(Float cropY) {
        this.cropY = cropY;
    }

    public Float getCropWidth() {
        return cropWidth;
    }

    public void setCropWidth(Float cropWidth) {
        this.cropWidth = cropWidth;
    }

    public Float getCropHeight() {
        return cropHeight;
    }

    public void setCropHeight(Float cropHeight) {
        this.cropHeight = cropHeight;
    }
}

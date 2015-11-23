package com.banvien.portal.vms.util;

//import com.sun.image.codec.jpeg.JPEGCodec;
//import com.sun.image.codec.jpeg.JPEGImageEncoder;

import com.sun.imageio.plugins.jpeg.JPEGImageWriter;

import javax.imageio.ImageIO;
import javax.swing.*;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;

public class ImageUtils {
    /**
     * This method takes in an image as a byte array (currently supports GIF, JPG, PNG and possibly other formats) and
     * resizes it to have a width no greater than the pMaxWidth parameter in pixels. It converts the image to a standard
     * quality JPG and returns the byte array of that JPG image.
     *
     * @param pImageData
     *                the image data.
     * @param pMaxWidth
     *                the max width in pixels, 0 means do not scale.
     * @return the resized JPG image.
     * @throws IOException
     *                 if the iamge could not be manipulated correctly.
     */
    public static byte[] resizeImageAsJPG(byte[] pImageData, int pMaxWidth, int pMaxHeight, int fit) throws IOException {
        // Create an ImageIcon from the image data
        ImageIcon imageIcon = new ImageIcon(pImageData);
        int width = imageIcon.getIconWidth();
        int height = imageIcon.getIconHeight();
        // If the image is larger than the max width, we need to resize it
        if (fit == 0 && pMaxHeight > 0) {
            // Determine the shrink ratio
            double ratio = (double) pMaxHeight / imageIcon.getIconHeight();
            width = (int) (imageIcon.getIconWidth() * ratio);
            if(pMaxWidth > 0 && width > pMaxWidth) {
                width = pMaxWidth;
            }
            height = pMaxHeight;
        }else if (fit == 1 && pMaxWidth > 0 && pMaxHeight > 0) {
            height = pMaxHeight;
            width = pMaxWidth;
        }
        // Create a new empty image buffer to "draw" the resized image into
        BufferedImage bufferedResizedImage = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        // Create a Graphics object to do the "drawing"
        Graphics2D g2d = bufferedResizedImage.createGraphics();
        g2d.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BICUBIC);
        // Draw the resized image
        g2d.drawImage(imageIcon.getImage(), 0, 0, width, height, null);
        g2d.dispose();
        // Now our buffered image is ready
        // Encode it as a JPEG
        ByteArrayOutputStream encoderOutputStream = new ByteArrayOutputStream();
//		JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(encoderOutputStream);
//        FileOutputStream fos = new FileOutputStream();
        JPEGImageWriter imageWriter = (JPEGImageWriter) ImageIO.getImageWritersBySuffix("jpeg").next();
//        ImageOutputStream ios = ImageIO.createImageOutputStream(fos);
        imageWriter.setOutput(bufferedResizedImage);
        byte[] resizedImageByteArray = encoderOutputStream.toByteArray();
        return resizedImageByteArray;
    }


    public static byte[] cropImage(byte[] pImageData, int x, int y, int width, int height) throws IOException {
        InputStream in = new ByteArrayInputStream(pImageData);
        BufferedImage bImageFromConvert = ImageIO.read(in);
        BufferedImage bufferedCroppedImage = bImageFromConvert.getSubimage(x, y, width, height);
        ByteArrayOutputStream encoderOutputStream = new ByteArrayOutputStream();
//        JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(encoderOutputStream);
        JPEGImageWriter imageWriter = (JPEGImageWriter) ImageIO.getImageWritersBySuffix("jpeg").next();
//        encoder.encode(bufferedCroppedImage);
        imageWriter.setOutput(bufferedCroppedImage);
        return encoderOutputStream.toByteArray();
    }
}

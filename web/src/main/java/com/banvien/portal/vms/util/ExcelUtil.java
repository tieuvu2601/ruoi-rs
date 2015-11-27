package com.banvien.portal.vms.util;

import com.banvien.portal.vms.dto.CellDataType;
import com.banvien.portal.vms.dto.CellValue;
import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.write.*;
import jxl.write.Number;

import java.sql.Timestamp;
import java.util.Date;

/**
 * Created by Ban Vien Ltd.
 * UserEntity: Vien Nguyen (vien.nguyen@banvien.com)
 * Date: 7/26/12
 * Time: 9:20 AM
 */
public class ExcelUtil {
    public static void addHeader(WritableSheet sheet, int startHeader, int startColumn,  CellValue cellValue) throws WriteException {
        WritableCellFormat cellF = new WritableCellFormat();
        cellF.setWrap(true);
        cellF.setBackground(jxl.format.Colour.LIGHT_BLUE);
        cellF.setBorder(Border.ALL, BorderLineStyle.THIN);
        cellF.setAlignment(Alignment.CENTRE);

        Label label = new Label(startColumn, startHeader, String.valueOf(cellValue.getValue()),cellF);
        sheet.addCell(label);
    }
    public static void addRow(WritableSheet sheet, int startHeader, int startColumn,  CellValue cellValue) throws WriteException {
        WritableCellFormat cellF = new WritableCellFormat();
        cellF.setWrap(true);
        cellF.setBorder(Border.ALL, BorderLineStyle.THIN);
        cellF.setAlignment(Alignment.CENTRE);

        Label label = new Label(startColumn, startHeader, String.valueOf(cellValue.getValue()),cellF);
        sheet.addCell(label);
    }
    public static void addHeader(WritableSheet sheet, int startRow, CellValue[] cellValues) throws WriteException {
        for (int i = 0; i < cellValues.length; i++) {
            if (cellValues[i] != null && cellValues[i].getValue() != null) {
                if (cellValues[i].getType().equals(CellDataType.STRING)) {
                    WritableCellFormat cellFormat = new WritableCellFormat();
                    cellFormat.setWrap(true);
                    cellFormat.setBackground(jxl.format.Colour.LIGHT_BLUE);
                    cellFormat.setBorder(Border.ALL, BorderLineStyle.THIN);
                    Label label = new Label(i, startRow, String.valueOf(cellValues[i].getValue()), cellFormat);

                    sheet.addCell(label);
                }
            }
        }
    }
    public static void addRow(WritableSheet sheet, int startRow, CellValue[] cellValues) throws WriteException {
        for (int i = 0; i < cellValues.length; i++) {
            if (cellValues[i] != null && cellValues[i].getValue() != null) {
                if (cellValues[i].getType().equals(CellDataType.STRING)) {
                    WritableCellFormat cellFormat = new WritableCellFormat();
                    cellFormat.setWrap(true);
                    cellFormat.setBorder(Border.ALL, BorderLineStyle.THIN);
                    Label label = new Label(i, startRow, String.valueOf(cellValues[i].getValue()), cellFormat);

                    sheet.addCell(label);
                }else if (cellValues[i].getType().equals(CellDataType.INT)) {

                    NumberFormat towdps = new NumberFormat("#,##0");
                    WritableCellFormat towdpsFormat = new WritableCellFormat(towdps);
                    towdpsFormat.setBorder(Border.ALL, BorderLineStyle.THIN);
                    Number number = new Number(i, startRow, (Integer)cellValues[i].getValue(), towdpsFormat);
                    sheet.addCell(number);
                } else if (cellValues[i].getType().equals(CellDataType.DOUBLE)) {
                    NumberFormat towdps = new NumberFormat("#,##0.00");
                    WritableCellFormat towdpsFormat = new WritableCellFormat(towdps);
                    towdpsFormat.setBorder(Border.ALL, BorderLineStyle.THIN);
                    Number number = new Number(i, startRow, (Double)cellValues[i].getValue(), towdpsFormat);
                    sheet.addCell(number);
                } else if (cellValues[i].getType().equals(CellDataType.DATE)) {
                    Date now = new Date(((Timestamp)cellValues[i].getValue()).getTime());
                    DateFormat customDateFormat = new DateFormat ("dd/MM/yyyy");
                    WritableCellFormat dateFormat = new WritableCellFormat (customDateFormat);
                    dateFormat.setBorder(Border.ALL, BorderLineStyle.THIN);
                    DateTime dateCell = new DateTime(i, startRow, now, dateFormat);
                    sheet.addCell(dateCell);
                }
            }else{
                WritableCellFormat cellFormat = new WritableCellFormat();
                cellFormat.setWrap(true);
                cellFormat.setBorder(Border.ALL, BorderLineStyle.THIN);
                Label label = new Label(i, startRow, "", cellFormat);

                sheet.addCell(label);
            }
        }
    }
}

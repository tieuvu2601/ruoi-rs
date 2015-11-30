package com.banvien.portal.vms.util;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * Created by Ban Vien Ltd.
 * User: Vien Nguyen (vien.nguyen@banvien.com)
 * Date: 7/2/12
 * Time: 2:56 PM
 */
public class DateUtils {
    public static long HOUR = 3600000L;
    public static final Date addDate(Date d, int days) {
        Date res = new Date(d.getTime() + days * 24 * 3600000L);
        return res;
    }

    public static final Date addMonth(Date d, int month) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(d);
        calendar.add(Calendar.MONTH, month);
        return calendar.getTime();
    }

    public static final String date2String(Date d, String format) {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(format);
        return simpleDateFormat.format(d);
    }

    public static int getWeekOfYear(Timestamp d) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(new Date(d.getTime()));

        return calendar.get(Calendar.WEEK_OF_YEAR);
    }

    public static int getMonthOfYear(Timestamp d) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(new Date(d.getTime()));

        return calendar.get(Calendar.MONTH);

    }

    public static Timestamp move2TheEndOfDay(Timestamp input) {
		Timestamp res = null;
		if (input != null) {
			res = new Timestamp(input.getTime() + 24 * HOUR - 1000);
		}
		return res;
	}

    public static Date convertFromString2Date(String strDate, String patten){
        if(strDate != null){
            Date date ;
            DateFormat formatter = new SimpleDateFormat(patten);
            try {
                date = (Date)formatter.parse(strDate);
            } catch (ParseException e) {
                return null;
            }
            return date;
        }
        return null;
    }
}

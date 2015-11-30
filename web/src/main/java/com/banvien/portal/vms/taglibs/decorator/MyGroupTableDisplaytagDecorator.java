package com.banvien.portal.vms.taglibs.decorator;

import org.apache.commons.lang.ObjectUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.displaytag.decorator.TableDecorator;
import org.displaytag.model.*;
import org.displaytag.util.TagConstants;

import javax.servlet.jsp.PageContext;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: hieu
 * Date: 6/4/13
 * Time: 5:30 PM
 * To change this template use File | Settings | File Templates.
 */
public class MyGroupTableDisplaytagDecorator extends TableDecorator{

    /**
     * Logger.
     */
    private static Log log = LogFactory.getLog(MyGroupTableDisplaytagDecorator.class);

    /**
     * Previous values needed for grouping.
     */
    private Map previousValues = new HashMap();

    /**
     * Name of the property used for grouping.
     */
    private String groupPropertyName;

    private boolean isFirstRow;

    private String groupClass;
    /**
     * @see org.displaytag.decorator.Decorator#init(javax.servlet.jsp.PageContext, Object, org.displaytag.model.TableModel)
     */
    public void init(PageContext context, Object decorated, TableModel tableModel)
    {
        super.init(context, decorated, tableModel);

        // reset
        groupPropertyName = null;
        previousValues.clear();
        isFirstRow = true;

        for (Iterator it = tableModel.getHeaderCellList().iterator(); it.hasNext();)
        {
            HeaderCell cell = (HeaderCell) it.next();
            if (cell.getGroup() == 1)
            {
                groupPropertyName = cell.getBeanPropertyName();
                break;
                //MultipleHtmlAttribute temp = (MultipleHtmlAttribute)cell.getHtmlAttributes().get("class");
            }
        }
    }


    @Override
    public String displayGroupedValue(String cellValue, short groupingStatus, int columnNumber) {
        return TagConstants.EMPTY_STRING;
    }

    @Override
    public String startRow() {
        String row = null;
        if (groupPropertyName != null)
        {
            Object groupedPropertyValue = evaluate(groupPropertyName);
            Object previousGroupedPropertyValue = previousValues.get(groupPropertyName);
            if ((previousGroupedPropertyValue != null
                    && !ObjectUtils.equals(previousGroupedPropertyValue, groupedPropertyValue)) || isFirstRow)
            {
                row = createGroupRow(groupedPropertyValue.toString());
            }
            previousValues.put(groupPropertyName, groupedPropertyValue);
        }
        isFirstRow = false;
        return row;
    }

    private String createGroupRow(String groupPropertyValue) {
        String value = groupPropertyValue;
        Object groupShowProperty = getPageContext().getAttribute("groupShowProperty");
        if(groupShowProperty != null) {
            Object temp =  evaluate(groupShowProperty.toString());
            if(temp != null) {
                value = temp.toString();
            }
        }
        StringBuffer buffer = new StringBuffer(1000);
        buffer.append("\n<tr class=\"trGroup\">");
        buffer.append("<td colspan=\"");
        buffer.append(tableModel.getHeaderCellList().size()).append("\"").append(" >")
                .append("<a href='javascript:toggleGroup(\"").append(value).append("\")'>").append(value).append("</a>");
        buffer.append("</td>");

        /*boolean isFirstCol = true;
        for (Iterator it = headerCells.iterator(); it.hasNext();)
        {
            HeaderCell cell = (HeaderCell) it.next();
            String cssClass = ObjectUtils.toString(cell.getHtmlAttributes().get("class"));

            buffer.append("<td");
            if (StringUtils.isNotEmpty(cssClass))
            {
                buffer.append(" class=\"");
                buffer.append(cssClass);
                buffer.append("\"");
            }
            buffer.append(">");
            if(isFirstCol) {
                buffer.append(value);
                isFirstCol = false;
            }
            buffer.append("</td>");

        }*/

        buffer.append("</tr>");

        return buffer.toString();
    }

    private String getColEvaluatedValue(String defaultValue) {
        RowIterator rowIterator = tableModel.getRowIterator(false);
        int i = 0;
        Row currentRow = null;
        while (rowIterator.hasNext())
        {
            if(i == getViewIndex()) {
                currentRow = rowIterator.next();
                break;
            }
            i++;
        }
        if(currentRow != null) {
            ColumnIterator columnIterator = currentRow.getColumnIterator(tableModel.getHeaderCellList());
            while (columnIterator.hasNext())
            {
                Column column = columnIterator.nextColumn();
                if(column.getHeaderCell().getBeanPropertyName() != null && column.getHeaderCell().getBeanPropertyName().equals(groupPropertyName)) {
                    return column.getChoppedAndLinkedValue();
                }

            }
        }

       return defaultValue;
    }
}

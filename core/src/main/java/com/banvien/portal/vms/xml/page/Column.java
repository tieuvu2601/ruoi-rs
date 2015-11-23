
package com.banvien.portal.vms.xml.page;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for Column complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="Column">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="rows" type="{}Rows" minOccurs="0"/>
 *       &lt;/sequence>
 *       &lt;attribute name="title" type="{http://www.w3.org/2001/XMLSchema}string" />
 *       &lt;attribute name="renderingTemplate" type="{http://www.w3.org/2001/XMLSchema}string" />
 *       &lt;attribute name="displayItem" type="{http://www.w3.org/2001/XMLSchema}int" />
 *       &lt;attribute name="category" type="{http://www.w3.org/2001/XMLSchema}string" />
 *       &lt;attribute name="skin" type="{http://www.w3.org/2001/XMLSchema}string" />
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "Column", propOrder = {
    "rows"
})
public class Column {

    protected Rows rows;
    @XmlAttribute
    protected String title;
    @XmlAttribute
    protected String renderingTemplate;
    @XmlAttribute
    protected Integer displayItem;
    @XmlAttribute
    protected String category;
    @XmlAttribute
    protected String skin;

    /**
     * Gets the value of the rows property.
     * 
     * @return
     *     possible object is
     *     {@link Rows }
     *     
     */
    public Rows getRows() {
        return rows;
    }

    /**
     * Sets the value of the rows property.
     * 
     * @param value
     *     allowed object is
     *     {@link Rows }
     *     
     */
    public void setRows(Rows value) {
        this.rows = value;
    }

    /**
     * Gets the value of the title property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTitle() {
        return title;
    }

    /**
     * Sets the value of the title property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTitle(String value) {
        this.title = value;
    }

    /**
     * Gets the value of the renderingTemplate property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getRenderingTemplate() {
        return renderingTemplate;
    }

    /**
     * Sets the value of the renderingTemplate property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setRenderingTemplate(String value) {
        this.renderingTemplate = value;
    }

    /**
     * Gets the value of the displayItem property.
     * 
     * @return
     *     possible object is
     *     {@link Integer }
     *     
     */
    public Integer getDisplayItem() {
        return displayItem;
    }

    /**
     * Sets the value of the displayItem property.
     * 
     * @param value
     *     allowed object is
     *     {@link Integer }
     *     
     */
    public void setDisplayItem(Integer value) {
        this.displayItem = value;
    }

    /**
     * Gets the value of the category property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCategory() {
        return category;
    }

    /**
     * Sets the value of the category property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCategory(String value) {
        this.category = value;
    }

    /**
     * Gets the value of the skin property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSkin() {
        return skin;
    }

    /**
     * Sets the value of the skin property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSkin(String value) {
        this.skin = value;
    }

}

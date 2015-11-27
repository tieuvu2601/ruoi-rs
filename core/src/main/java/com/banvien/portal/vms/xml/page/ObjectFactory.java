
package com.banvien.portal.vms.xml.page;

import javax.xml.bind.JAXBElement;
import javax.xml.bind.annotation.XmlElementDecl;
import javax.xml.bind.annotation.XmlRegistry;
import javax.xml.namespace.QName;


/**
 * This object contains factory methods for each 
 * Java content interface and Java element interface 
 * generated in the com.banvien.portal.vms.xml.page package. 
 * <p>An ObjectFactory allows you to programatically 
 * construct new instances of the Java representation 
 * for XML content. The Java representation of XML 
 * content can consist of schema derived interfaces 
 * and classes representing the binding of schema 
 * type definitions, element declarations and model 
 * groups.  Factory methods for each of these are 
 * provided in this class.
 * 
 */
@XmlRegistry
public class ObjectFactory {

    private final static QName _Page_QNAME = new QName("", "page");

    /**
     * Create a new ObjectFactory that can be used to create new instances of schema derived classes for package: com.banvien.portal.vms.xml.page
     * 
     */
    public ObjectFactory() {
    }

    /**
     * Create an instance of {@link Column }
     * 
     */
    public Column createColumn() {
        return new Column();
    }

    /**
     * Create an instance of {@link Rows }
     * 
     */
    public Rows createRows() {
        return new Rows();
    }

    /**
     * Create an instance of {@link Page }
     * 
     */
    public Page createPage() {
        return new Page();
    }

    /**
     * Create an instance of {@link Row }
     * 
     */
    public Row createRow() {
        return new Row();
    }

    /**
     * Create an instance of {@link Columns }
     * 
     */
    public Columns createColumns() {
        return new Columns();
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link Page }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "", name = "page")
    public JAXBElement<Page> createPage(Page value) {
        return new JAXBElement<Page>(_Page_QNAME, Page.class, null, value);
    }

}

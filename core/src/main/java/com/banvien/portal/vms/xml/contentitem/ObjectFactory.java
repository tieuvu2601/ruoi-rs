package com.banvien.portal.vms.xml.contentitem;

import javax.xml.bind.JAXBElement;
import javax.xml.bind.annotation.XmlElementDecl;
import javax.xml.bind.annotation.XmlRegistry;
import javax.xml.namespace.QName;


/**
 * This object contains factory methods for each 
 * Java content interface and Java element interface 
 * generated in the com.banvien.portal.vms.xml.contentitem package. 
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

    private final static QName _ContentItem_QNAME = new QName("", "contentItem");

    /**
     * Create a new ObjectFactory that can be used to create new instances of schema derived classes for package: com.banvien.portal.vms.xml.contentitem
     * 
     */
    public ObjectFactory() {
    }

    /**
     * Create an instance of {@link Item }
     * 
     */
    public Item createItem() {
        return new Item();
    }

    /**
     * Create an instance of {@link ContentItem }
     * 
     */
    public ContentItem createContentItem() {
        return new ContentItem();
    }

    /**
     * Create an instance of {@link Items }
     * 
     */
    public Items createItems() {
        return new Items();
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link ContentItem }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "", name = "contentItem")
    public JAXBElement<ContentItem> createContentItem(ContentItem value) {
        return new JAXBElement<ContentItem>(_ContentItem_QNAME, ContentItem.class, null, value);
    }

}

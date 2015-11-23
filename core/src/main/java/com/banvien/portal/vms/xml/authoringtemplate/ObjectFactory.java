package com.banvien.portal.vms.xml.authoringtemplate;

import javax.xml.bind.JAXBElement;
import javax.xml.bind.annotation.XmlElementDecl;
import javax.xml.bind.annotation.XmlRegistry;
import javax.xml.namespace.QName;


/**
 * This object contains factory methods for each 
 * Java content interface and Java element interface 
 * generated in the com.banvien.portal.vms.xml.authoringtemplate package. 
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

    private final static QName _AuthoringTemplate_QNAME = new QName("", "authoringTemplate");

    /**
     * Create a new ObjectFactory that can be used to create new instances of schema derived classes for package: com.banvien.portal.vms.xml.authoringtemplate
     * 
     */
    public ObjectFactory() {
    }

    /**
     * Create an instance of {@link AuthoringTemplate }
     * 
     */
    public AuthoringTemplate createAuthoringTemplate() {
        return new AuthoringTemplate();
    }

    /**
     * Create an instance of {@link Nodes }
     * 
     */
    public Nodes createNodes() {
        return new Nodes();
    }

    /**
     * Create an instance of {@link Node }
     * 
     */
    public Node createNode() {
        return new Node();
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link AuthoringTemplate }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "", name = "authoringTemplate")
    public JAXBElement<AuthoringTemplate> createAuthoringTemplate(AuthoringTemplate value) {
        return new JAXBElement<AuthoringTemplate>(_AuthoringTemplate_QNAME, AuthoringTemplate.class, null, value);
    }

}

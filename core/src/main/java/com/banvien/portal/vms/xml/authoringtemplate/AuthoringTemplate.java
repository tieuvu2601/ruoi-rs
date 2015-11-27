package com.banvien.portal.vms.xml.authoringtemplate;

import javax.xml.bind.annotation.*;


/**
 * <p>Java class for AuthoringTemplateEntity complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="AuthoringTemplateEntity">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="nodes" type="{}Nodes"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlRootElement(name="authoringTemplate")
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "AuthoringTemplate", propOrder = {
    "nodes"
})
public class AuthoringTemplate {

    @XmlElement(required = true)
    protected Nodes nodes;

    /**
     * Gets the value of the nodes property.
     * 
     * @return
     *     possible object is
     *     {@link Nodes }
     *     
     */
    public Nodes getNodes() {
        return nodes;
    }

    /**
     * Sets the value of the nodes property.
     * 
     * @param value
     *     allowed object is
     *     {@link Nodes }
     *     
     */
    public void setNodes(Nodes value) {
        this.nodes = value;
    }

}

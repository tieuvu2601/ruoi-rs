package com.banvien.portal.vms.util;

import com.banvien.portal.vms.exception.InvalidXMLException;
import com.banvien.portal.vms.xml.authoringtemplate.AuthoringTemplate;
import org.apache.xml.serialize.OutputFormat;
import org.apache.xml.serialize.XMLSerializer;
import org.xml.sax.SAXException;

import javax.xml.XMLConstants;
import javax.xml.bind.*;
import javax.xml.bind.util.ValidationEventCollector;
import javax.xml.validation.Schema;
import javax.xml.validation.SchemaFactory;
import java.io.*;

/**
 * Created by Ban Vien Ltd.
 * User: Vien Nguyen (vien.nguyen@banvien.com)
 * Date: 11/22/12
 * Time: 3:17 PM
 */
public class AuthoringTemplateUtil {
    public static AuthoringTemplate parseXML(String xmlContent) throws JAXBException, SAXException, InvalidXMLException {
        AuthoringTemplate res = null;
        SchemaFactory schemaFactory = SchemaFactory.newInstance(XMLConstants.W3C_XML_SCHEMA_NS_URI);
        Schema schema = schemaFactory.newSchema(Thread.currentThread().getContextClassLoader().getResource("authoringtemplate.xsd"));

        JAXBContext jc = JAXBContext.newInstance("com.banvien.portal.vms.xml.authoringtemplate");
        Unmarshaller u = jc.createUnmarshaller();
        u.setSchema(schema);

        ValidationEventCollector validationCollector= new ValidationEventCollector();
        u.setEventHandler( validationCollector );
        try{
            JAXBElement element = (JAXBElement) u.unmarshal(new StringReader(xmlContent));
            res = (AuthoringTemplate) element.getValue();
        }catch (Exception e) {
            StringBuffer message = new StringBuffer();
            for(ValidationEvent event: validationCollector.getEvents() ){
                String msg = event.getMessage();
                ValidationEventLocator locator = event.getLocator();
                int line = locator.getLineNumber();
                int column = locator.getColumnNumber();
                message.append("Error at line ").append(line).append(" column ").append(column).append(msg);
            }
            throw new InvalidXMLException(message.toString(), e);
        }

        return res;
    }

    public static String bean2Xml(AuthoringTemplate authoringTemplate) throws JAXBException, SAXException,  IOException {
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        JAXBContext jc = JAXBContext.newInstance("com.banvien.portal.vms.xml.authoringtemplate");
		Marshaller marshaller = jc.createMarshaller();
		marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, new Boolean(true));
		marshaller.setProperty(Marshaller.JAXB_FRAGMENT, true);

		XMLSerializer authoringTemplateSerializer = getXMLSerializer(new String[]{"^defaultValue","^constraintValues"},
				byteArrayOutputStream );
		marshaller.marshal(authoringTemplate, authoringTemplateSerializer.asContentHandler());

        return new String(byteArrayOutputStream.toByteArray(), "UTF-8");
    }

    private static XMLSerializer getXMLSerializer(String[] cdataElements, ByteArrayOutputStream out) {
        // configure an OutputFormat to handle CDATA
        OutputFormat of = new OutputFormat();

        of.setCDataElements(cdataElements);

        // set any other options you'd like
        of.setPreserveSpace(true);
        of.setIndenting(true);
        of.setEncoding("UTF-8");

        // create the serializer
        XMLSerializer serializer = new XMLSerializer(of);
        serializer.setOutputByteStream(out);

        return serializer;
    }

}

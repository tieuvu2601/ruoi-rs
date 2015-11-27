import junit.framework.TestCase;
import org.apache.http.protocol.HTTP;

/**
 * Created by Ban Vien Co., Ltd.
 * UserEntity: viennh
 * Email: vien.nguyen@banvien.com
 * Date: 1/25/13
 * Time: 3:33 PM
 */
public class Test extends TestCase{
    public  void testConvertURL() {
        try{
            String nextURL = "http:\\u002f\\u002f10.151.70.91\\u002fCNHCM01\\u002fLists\\u002fAnnouncements\\u002fAllItems.aspx?Paged=TRUE\\u0026p_Created=20121204\\u00252009\\u00253a06\\u00253a38\\u0026p_ID=2746\\u0026View=\\u00257bAD077482\\u00252dE82E\\u00252d4FC4\\u00252dB675\\u00252dFC0CCC02BC31\\u00257d\\u0026FolderCTID=0x012001\\u0026PageFirstRow=101";
            nextURL = nextURL.replace("\\u002f", "/").replace("\\u0026", "&").replace("\\u002520", " ").replace("\\u00253a", ":").replace("\\u00257b", "{").replace("\\u00252d", "-").replace("\\u00257d", "}");

            System.out.println(nextURL);
        }catch (Exception e) {

        }
    }
}

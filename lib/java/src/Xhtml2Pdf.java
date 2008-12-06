import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;

import org.xhtmlrenderer.pdf.ITextRenderer;

public class Xhtml2Pdf
{
    public static void main(String[] args) throws Exception {
       
        String input = args[0];
        String output = args[1];
        String url = new File(input).toURI().toURL().toString();
        
        
        OutputStream os = new FileOutputStream(output);

        ITextRenderer renderer = new ITextRenderer();
        renderer.setDocument(url);
        renderer.layout();
        renderer.createPDF(os);
        os.close();
    }
}

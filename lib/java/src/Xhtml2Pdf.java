import gnu.getopt.Getopt;
import gnu.getopt.LongOpt;

public class Xhtml2Pdf
{
    public static void main(String[] args) {
        
        String inputFile = args[0];
        String url = new File(inputFile).toURI().toURL().toString();
       
        String outputFile = args[1];
       
        OutputStream os = new FileOutputStream(outputFile);

        ITextRenderer renderer = new ITextRenderer();
        renderer.setDocument(url);
        renderer.layout();
        renderer.createPDF(os);


    }
}

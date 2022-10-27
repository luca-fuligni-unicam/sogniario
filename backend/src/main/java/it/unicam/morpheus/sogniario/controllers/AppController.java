package it.unicam.morpheus.sogniario.controllers;

import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLConnection;

@RestController
@RequestMapping("api/download")
public class AppController {

    //private static final String EXTERNAL_FILE_PATH = "/home/luca/Desktop/Test/";
    private static final String EXTERNAL_FILE_PATH = "C:\\Public\\";

    @RequestMapping("/file/{fileName:.+}")
    public void downloadPDFResource(HttpServletRequest request, HttpServletResponse response,
                                    @PathVariable("fileName") String fileName) throws IOException {

        File file = new File(EXTERNAL_FILE_PATH + fileName);

        if (file.exists()) {

            String mimeType = URLConnection.guessContentTypeFromName(file.getName());
            if (mimeType == null) {
                mimeType = "application/vnd.android.package-archive";
            }

            response.setContentType(mimeType);

            //response.setHeader("Content-Disposition", String.format("inline; filename=\"" + file.getName() + "\""));

            //Here we have mentioned it to show as attachment
            response.setHeader("Content-Disposition", String.format("attachment; filename=\"" + file.getName() + "\""));

            response.setContentLength((int) file.length());

            InputStream inputStream = new BufferedInputStream(new FileInputStream(file));

            FileCopyUtils.copy(inputStream, response.getOutputStream());
        }

    }


}

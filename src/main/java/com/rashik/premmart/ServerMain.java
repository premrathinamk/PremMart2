package com.rashik.premmart;

import org.apache.catalina.Context;
import org.apache.catalina.WebResourceRoot;
import org.apache.catalina.core.StandardContext;
import org.apache.catalina.startup.Tomcat;
import org.apache.catalina.webresources.DirResourceSet;
import org.apache.catalina.webresources.StandardRoot;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;

public class ServerMain {

    public static void main(String[] args) throws Exception {
        int port = 8080;
        String portEnv = System.getenv("PORT");
        if (portEnv != null && !portEnv.trim().isEmpty()) {
            try {
                port = Integer.parseInt(portEnv.trim());
            } catch (NumberFormatException ignored) {
            }
        }

        Tomcat tomcat = new Tomcat();
        tomcat.setPort(port);

        // Temp directory for embedded Tomcat work
        File baseDir = new File("target/tomcat-embedded");
        if (!baseDir.exists()) {
            baseDir.mkdirs();
        }
        tomcat.setBaseDir(baseDir.getAbsolutePath());

        // Initialize default HTTP connector
        tomcat.getConnector();

        // Locate webapp directory
        File webappDir = new File("src/main/webapp");
        if (!webappDir.exists()) {
            webappDir = new File("PremMart/src/main/webapp");
        }
        if (!webappDir.exists()) {
            throw new IllegalStateException("Could not find webapp folder at src/main/webapp or PremMart/src/main/webapp");
        }

        // Locate compiled classes
        File classesDir = new File("target/classes");
        if (!classesDir.exists()) {
            classesDir = new File("PremMart/target/classes");
        }

        // 1. Add /PremMart webapp context
        StandardContext ctx = (StandardContext) tomcat.addWebapp("/PremMart", webappDir.getAbsolutePath());
        ctx.setParentClassLoader(ServerMain.class.getClassLoader());
        ctx.setReloadable(true);

        if (classesDir.exists()) {
            WebResourceRoot resources = new StandardRoot(ctx);
            resources.addPreResources(new DirResourceSet(resources, "/WEB-INF/classes",
                    classesDir.getAbsolutePath(), "/"));
            ctx.setResources(resources);
        }

        // 2. Add ROOT context ("") that redirects to /PremMart
        Context rootCtx = tomcat.addContext("", baseDir.getAbsolutePath());
        Tomcat.addServlet(rootCtx, "RootRedirectServlet", new HttpServlet() {
            @Override
            protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
                resp.sendRedirect("/PremMart");
            }
        });
        rootCtx.addServletMappingDecoded("/*", "RootRedirectServlet");

        System.out.println("==================================================================");
        System.out.println("  PremMart Server Started Successfully!");
        System.out.println("  Access Link: http://localhost:" + port + "/PremMart");
        System.out.println("  Root Link:   http://localhost:" + port + "/");
        System.out.println("==================================================================");

        tomcat.start();
        tomcat.getServer().await();
    }
}

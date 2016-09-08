package com.ruxia.tools.testunit.utils;


import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.methods.StringRequestEntity;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;


/**
 * Created by SEELE on 2016/9/6.
 */
public class HttpUtil {


    public static Map<String,Object> sendXmlData(String url,String xml){
        Map<String,Object> resultMap = new HashMap<>();
        //创建httpclient工具对象
        HttpClient client = new HttpClient();
        //创建post请求方法
        PostMethod myPost = new PostMethod(url);
        //设置请求超时时间
        client.setConnectionTimeout(300*1000);
        String responseString = null;
        try{
            //设置请求头部类型
            myPost.setRequestHeader("Content-Type","text/xml");
            myPost.setRequestHeader("charset","utf-8");

            //设置请求体，即xml文本内容，注：这里写了两种方式，一种是直接获取xml内容字符串，一种是读取xml文件以流的形式
//          myPost.setRequestBody(xmlString);

           /// InputStream body=this.getClass().getResourceAsStream("/"+xmlFileName);
            //myPost.setRequestBody(xml);
            myPost.setRequestEntity(new StringRequestEntity(xml,"application/xml","utf-8"));
            int statusCode = client.executeMethod(myPost);
            resultMap.put("statusCode",statusCode);
            if(statusCode == HttpStatus.SC_OK){
                BufferedInputStream bis = new BufferedInputStream(myPost.getResponseBodyAsStream());
                byte[] bytes = new byte[1024];
                ByteArrayOutputStream bos = new ByteArrayOutputStream();
                int count = 0;
                while((count = bis.read(bytes))!= -1){
                    bos.write(bytes, 0, count);
                }
                byte[] strByte = bos.toByteArray();
                responseString = new String(strByte,0,strByte.length,"utf-8");
                bos.close();
                bis.close();
            }
            resultMap.put("responseMsg",responseString);
        }catch (Exception e) {
            e.printStackTrace();
        }
        myPost.releaseConnection();
        return resultMap;
    }
}

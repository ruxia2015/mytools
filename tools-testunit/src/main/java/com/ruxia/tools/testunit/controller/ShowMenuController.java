package com.ruxia.tools.testunit.controller;

import java.io.File;
import java.util.*;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ruxia.tools.testunit.model.FileModel;
import com.ruxia.tools.testunit.service.TestUnitManagerService;

/**
 * Created by SEELE on 2016/9/5.
 */
@Controller
@RequestMapping("/showMenu")
public class ShowMenuController {
    public static Map<String, FileModel> fileModelMap = new HashMap<>();
    
    private String root_path = TestUnitManagerService.ROOT_PATH;
    
    /**
     *
     * @return
     */
    @RequestMapping("toLeftMenu")
    public String toLeftMenu(ModelMap modelMap) {
        File file = new File(root_path);
        List<FileModel> fileModels = new ArrayList<>();
        for (File temp : file.listFiles()) {
            fileModels.add(getFolderDirectorys(temp, null));
        }
        modelMap.put("fileModels", fileModels);
        return "leftMenu";
    }
    
    @ResponseBody
    @RequestMapping("leftMenu")
    public List<FileModel> leftMenu() {
        File file = new File(root_path);
        List<FileModel> fileModels = new ArrayList<>();
        for (File temp : file.listFiles()) {
            fileModels.add(getFolderDirectorys(temp, null));
        }
        return fileModels;
    }
    
    public FileModel getFolderDirectorys(File file, String parentUuid) {
        FileModel fileModel = new FileModel();
        fileModel.setFile(file);
        
        String  uuid = UUID.randomUUID().toString();
        
        if (file.isDirectory()) {
            fileModel.setFileSimpleName(file.getName());
        } else {
            String filename = file.getName();
            fileModel.setFileName(filename);
            filename = filename.substring(0, filename.lastIndexOf("."));
            fileModel.setFileSimpleName(filename);
            uuid = UUID.randomUUID().toString();
            fileModel.setFileFullPath(file.getPath());
            fileModel.setParentUuid(uuid);
            
            String parentPath = file.getParent();
            fileModel.setParentRelativePath(parentPath
                    .substring(TestUnitManagerService.ROOT_PATH.length()));
            fileModel.setUuid(uuid);
            fileModel.setParentUuid(parentUuid);
            fileModelMap.put(uuid, fileModel);
        }
        fileModel.setIsFolder(file.isDirectory());
        if (!fileModel.isFolder()) {
            return fileModel;
        }
        
        ArrayList<FileModel> fileModels = new ArrayList<>();
        
        File[] fileList = file.listFiles();
        for (File tempFile : fileList) {
            FileModel tempFileModel = getFolderDirectorys(tempFile, uuid);
            fileModels.add(tempFileModel);
        }
        fileModel.setChildFileModels(fileModels);
        return fileModel;
    }
    
}

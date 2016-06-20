//
//  FileOperationTool.swift
//  fileOperationTool
//
//  Created by 宋旭 on 16/4/6.
//  Copyright © 2016年 sky. All rights reserved.
//

import UIKit

// 以下所有操作的目录默认为DocumentDirectory
let jkManager = NSFileManager.defaultManager()
let baseURL = jkManager.URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask).first!

class FileOperationTool: NSObject {
    
    /**
     * 创建文件夹
     */
    class func createDirectoryAtPath(fileName: String) -> Bool {
        
        if fileName.isEmpty {
            
            return false
        }
        
        let pathURL = baseURL.URLByAppendingPathComponent(fileName)
        
        var createDirSuccess = false; var createFailed = false
        
        if !jkManager.fileExistsAtPath(pathURL.path!) {
            
            do {
                try jkManager.createDirectoryAtURL(pathURL, withIntermediateDirectories: true, attributes: nil)
            } catch {
                createFailed = true
                print("您的输入有误,请重新输入")
            }
            if !createFailed {
                
                createDirSuccess = true
                
                print("\(fileName)创建成功")
            } else {
                print("创建文件夹失败")
            }
            
        }
        return createDirSuccess
    }
    
    /**
     * 创建文件
     */
    class func createFileAtPath(fileName: String) -> Bool {
        
        if fileName.isEmpty {
            return false
        }
        
        let pathURL = baseURL.URLByAppendingPathComponent(fileName)
        
        var createFileSuccess = false
        
        if !jkManager.fileExistsAtPath(pathURL.path!) {
            
            let data = NSData(base64EncodedString:"Operation Success!",
                              options:.IgnoreUnknownCharacters)
            
            createFileSuccess = jkManager.createFileAtPath(pathURL.path!,
                                                           contents: data,
                                                           attributes: nil)
            
            print("\(fileName)创建成功")
        }
        return createFileSuccess
    }
    
    /**
     * 写文件--字符串
     */
    class func writeToFileAtPath(fileName: String, withString contentStr: String) -> Bool {
        
        if fileName.isEmpty {
            return false
        }
        
        let pathURL = baseURL.URLByAppendingPathComponent(fileName)
        
        var createFailed = false
        
        if jkManager.fileExistsAtPath(pathURL.path!) {
            
            do{
                try contentStr.writeToURL(pathURL, atomically: true, encoding: NSUTF8StringEncoding)
                
                print("字符串写入成功")
            } catch {
                createFailed = true
                print("您的输入有误,请重新输入")
            }
        }
        
        return !createFailed
    }
    
    /**
     * 写文件--字典
     */
    class func writeToFileAtPath(fileName: String, withDict contentDict: NSDictionary) -> Bool {
        
        if fileName.isEmpty {
            return false
        }
        let pathURL = baseURL.URLByAppendingPathComponent(fileName)
        
        var createSuccessed = false
        
        var isDir: ObjCBool = false
        
        if jkManager.fileExistsAtPath(pathURL.path!, isDirectory: &isDir) {
            
            contentDict.writeToURL(pathURL, atomically: true)
            createSuccessed = true
            
            print("字典写入成功")
        } else {
            print("您的输入有误，请重新输入")
        }
        return createSuccessed;
    }
    
    /**
     * 写文件--数组
     */
    class func writeToFileAtPath(fileName: String, withArray contentArray: NSArray) -> Bool {
        
        if fileName.isEmpty {
            return false
        }
        let pathURL = baseURL.URLByAppendingPathComponent(fileName)
        var createSuccessed = false
        var isDir: ObjCBool = false
        
        if jkManager.fileExistsAtPath(pathURL.path!, isDirectory: &isDir) {
            
            contentArray.writeToURL(pathURL, atomically: true)
            createSuccessed = true
            print("数组写入成功")
            
        } else {
            print("您的输入有误，请重新输入")
        }
        return createSuccessed;
    }
    
    /**
     * 读文件
     */
    class func readFileAtPath(fileName: String) -> Bool {
        
        var readSuccess = false
        
        if fileName.containsString(".") {
            
            let pathURL = baseURL.URLByAppendingPathComponent(fileName)
            
            let content = jkManager.contentsAtPath(pathURL.path!)
            
            if !(content == nil) {
                
                let dataInFile = NSString(data: content!, encoding: NSUTF8StringEncoding)
                
                print("文件内容: \(dataInFile)")
                
                readSuccess = true
                
            } else {
                
                print("该文件为空或不存在")
            }
        } else {
            print("请输入正确的文件名")
        }
        return readSuccess
    }
    
    /**
     * 获取目录下所有文件
     */
    class func getAllFilesAtPath(directoryName: String) -> Bool {
        
        let pathURL = baseURL.URLByAppendingPathComponent(directoryName)
        
        var operationSuccess = false
        
        if jkManager.fileExistsAtPath(pathURL.path!) {
            
            let enumeratorAtPath = jkManager.enumeratorAtPath(pathURL.path!)
            
            print("enumeratorAtPath: \(enumeratorAtPath?.allObjects)")
            
            operationSuccess = true
        } else{
            print("当前文件夹已无效")
        }
        
        return operationSuccess;
    }
    
    /**
     * 删除文件
     */
    class func deleteFileAtPath(fileName: String) -> Bool {
        
        let pathURL = baseURL.URLByAppendingPathComponent(fileName)
        
        var deleteFileSuccess = false
        
        if !fileName.isEmpty {
            if jkManager.fileExistsAtPath(pathURL.path!) {
                
                do {
                    try jkManager.removeItemAtURL(pathURL)
                    deleteFileSuccess = true
                    
                    print("删除操作成功")
                } catch {
                    print("您的输入有误，请重新输入")
                }
            } else {
                print("您输入的文件不存在")
            }
        } else {
            print("文件(夹)名不能为空")
        }
        
        return deleteFileSuccess;
    }
    
    /**
     * 移动文件
     */
    class func moveFileFromDirectory(fileName: String) -> Bool {
        
        var operationSuccessed = false
        
        if !fileName.isEmpty {
            
            let srcUrl = baseURL.URLByAppendingPathComponent(fileName)
            
            let firstUrl = baseURL.URLByAppendingPathComponent("Moved")
            
            do {
                
                try jkManager.createDirectoryAtURL(firstUrl,
                                                   withIntermediateDirectories: true,
                                                   attributes: nil)
            } catch {
                print("程序异常，请呼叫网管")
                print("网管不在，请检查firstUrl路径是否正确")
            }
            
            let secondUrl = firstUrl.URLByAppendingPathComponent(fileName)
            
            if self.isFileExisted(secondUrl.path!) {
                
                do {
                    
                    try jkManager.moveItemAtURL(srcUrl, toURL: secondUrl)
                    operationSuccessed = true
                    print("\(fileName)移动成功")
                } catch {
                    print("请检查目标路径secondUrl是否正确")
                }
            } else {
                print("请检查原文件路径srcUrl与目标路径secondUrl是否正确")
            }
        } else {
            print("文件名不能为空")
        }
        
        return operationSuccessed;
    }
    
    /**
     * 判断文件是否存在
     */
    class func isFileExisted(fileName: String) -> Bool {
        
        var operationSuccess = false
        
        if !fileName.isEmpty {
            
            let pathURL = baseURL.URLByAppendingPathComponent(fileName)
            
            if jkManager.fileExistsAtPath(pathURL.path!) {
                
                operationSuccess = true
                
                print("\(fileName)存在")
            }
        } else {
            print("文件不存在或文件为空")
        }
        return operationSuccess;
    }
    
    /**
     * 获取某文件属性(计算某文件大小)
     */
    class func fileSizeAtPath(fileName: String) -> (CLongLong) {
        
        if fileName.isEmpty {
            
            return 0
        }
        
        var fileSize: Int64 = 0
        
        let pathURL = baseURL.URLByAppendingPathComponent(fileName)
        
        var isDir: ObjCBool = false
        
        if jkManager.fileExistsAtPath(pathURL.path!, isDirectory: &isDir) {
            
            do {
                let attributes = try jkManager.attributesOfItemAtPath(pathURL.path!)
                
                let size = attributes[NSFileSize]
                if size == nil {
                    print("\(fileName)大小为 0 ")
                } else {
                    fileSize = size!.longLongValue
                }
            } catch {
                print("检查文件路径是否异常")
            }
        } else {
            print("此方法不能检测文件夹大小")
        }
        return fileSize
    }
    
    /**
     * 计算整个文件夹大小
     */
    class func folderSizeAtPath(folderPath: String) -> (CLongLong) {
        
        let pathURL = baseURL.URLByAppendingPathComponent(folderPath)
        
        if !jkManager.fileExistsAtPath(pathURL.path!) {
            
            return 0
        }
        
        let childFilesEnumerator = jkManager.subpathsAtPath(pathURL.path!)
        var fileName: String?
        var folderSize: CLongLong = 0
        var attributes = [String : AnyObject]()
        
        if (childFilesEnumerator?.count) == 0 {
            print("该文件夹为空")
            return 0
        }
        
        for item in childFilesEnumerator! {
            
            fileName = item as String
            
            let fileAbsolutePath = pathURL.URLByAppendingPathComponent(fileName!)
            
            do {
                attributes = try jkManager.attributesOfItemAtPath(fileAbsolutePath.path!)
            } catch {
                print("路径为\(fileAbsolutePath.path!)的文件获取其属性异常")
            }
            
            if attributes.count == 0 {
                return 0
            } else {
                
                folderSize += (attributes[NSFileSize]?.longLongValue)!
            }
        }
        return folderSize / 1024
    }
}
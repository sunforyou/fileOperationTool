//
//  ViewController.swift
//  fileOperationTool
//
//  Created by 宋旭 on 16/4/6.
//  Copyright © 2016年 sky. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var fileNameInput: UITextField!
    
    @IBOutlet weak var basePath: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fileNameInput.delegate = self
        basePath.hidden = true
        print("操作基础路径 \n \(baseURL.path!)")
        
    }

    /**
     * 处理键盘显示与隐藏
     */
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.fileNameInput.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.fileNameInput.resignFirstResponder()
        basePath.hidden = true
    }
    
    //MARK: >>>>>>>>>>>>>>>>> 点击事件 <<<<<<<<<<<<<<<<<<
    
    @IBAction func createFolderClicked(sender: UIButton) {
        
        if FileOperationTool.createDirectoryAtPath(fileNameInput.text!) {
            basePath.text = "创建文件夹操作成功"
            basePath.hidden = false
        } else {
            basePath.text = "请输入文件夹名称"
            basePath.hidden = false
        }
    }
    
    @IBAction func createFileClicked(sender: UIButton) {
        
        if FileOperationTool.createFileAtPath(fileNameInput.text!) {
            basePath.text = "创建文件操作成功"
            basePath.hidden = false
        } else {
            basePath.text = "请输入文件名"
            basePath.hidden = false
        }
    }

    @IBAction func writeFileClicked(sender: UIButton) {
        
        let str = "abcd"
        
        if FileOperationTool.writeToFileAtPath(fileNameInput.text!, withString: str) {
            basePath.text = "写字符串操作成功"
            basePath.hidden = false
        } else {
            basePath.text = "请输入文件名"
            basePath.hidden = false
        }
    }
    
    @IBAction func writeArrayClicked(sender: UIButton) {
        
        let array = ["hello","jkxy"]
        
        if FileOperationTool.writeToFileAtPath(fileNameInput.text!, withArray: array) {
            basePath.text = "写数组操作成功"
            basePath.hidden = false
        } else {
            basePath.text = "请输入文件名"
            basePath.hidden = false
        }
    }
    
    @IBAction func writeDictionary(sender: UIButton) {
        
        let dict = ["name":"jkxy", "age":2]
        
        if FileOperationTool.writeToFileAtPath(fileNameInput.text!, withDict: dict){
            basePath.text = "写字典操作成功"
            basePath.hidden = false
        } else {
            basePath.text = "请输入文件名"
            basePath.hidden = false
        }
        
    }
    
    @IBAction func readFileClicked(sender: UIButton) {
        
        if FileOperationTool.readFileAtPath(fileNameInput.text!) {
            basePath.text = "读文件操作成功"
            basePath.hidden = false
        } else {
            basePath.text = "读文件操作失败"
            basePath.hidden = false
        }
    }
    
    @IBAction func delFileClicked(sender: UIButton) {
        
        if FileOperationTool.deleteFileAtPath(fileNameInput.text!) {
            basePath.text = "删除文件操作成功"
            basePath.hidden = false
        } else {
            basePath.text = "删除文件操作失败"
            basePath.hidden = false
        }
    }
    
    
    @IBAction func captureAllFileClicked(sender: UIButton) {
        
        if FileOperationTool.getAllFilesAtPath(fileNameInput.text!) {
            basePath.text = "获取所有文件操作成功"
            basePath.hidden = false
        } else {
            basePath.text = "获取所有文件操作失败"
            basePath.hidden = false
        }
        
    }
    
    
    @IBAction func moveFileClicked(sender: UIButton) {
        
        if FileOperationTool.moveFileFromDirectory(fileNameInput.text!) {
            basePath.text = "移动文件操作成功"
            basePath.hidden = false
        } else {
            basePath.text = "移动文件操作失败"
            basePath.hidden = false
        }
    }
    
    
    @IBAction func fileIsExistClicked(sender: UIButton) {
        
        if FileOperationTool.isFileExisted(fileNameInput.text!) {
            basePath.text = "检测文件操作成功"
            basePath.hidden = false
        } else {
            basePath.text = "检测文件操作失败"
            basePath.hidden = false
        }
        
    }
    
    
    @IBAction func calculateSizeOfFileClicked(sender: UIButton) {
        
        let size = FileOperationTool.fileSizeAtPath(fileNameInput.text!)
        if 0 != size {
            basePath.text = "该文件大小为 \(size)Byte"
            print("该文件大小为 \(size)Byte")
            basePath.hidden = false
        } else {
            basePath.text = "该文件为空或不存在"
            print("该文件为空或不存在")
            basePath.hidden = false
        }
    }
    
    
    @IBAction func calculateSizeOfFolderClicked(sender: UIButton) {
        
        let size = FileOperationTool.folderSizeAtPath(fileNameInput.text!)
        if 0 != size {
            basePath.text = "该文件夹大小为 \(size)Byte"
            print("该文件夹大小为 \(size)Byte")
            basePath.hidden = false
        } else {
            basePath.text = "该文件夹为空或不存在"
            print("该文件夹为空或不存在")
            basePath.hidden = false
        }
    }
}


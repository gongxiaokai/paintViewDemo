//
//  ViewController.swift
//  PaintView
//
//  Created by gongwenkai on 2016/12/11.
//  Copyright © 2016年 gongwenkai. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    @IBOutlet weak var widthSlider: UISlider!
    @IBOutlet weak var cleanBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet var paintView: PaintView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //改变线宽刷新view
    @IBAction func configLineWidth(_ sender: Any) {
        paintView.lineWidth = CGFloat(self.widthSlider.value) * 10

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //清除面板
    @IBAction func cleanAll(_ sender: Any) {

        paintView.cleanAll()
    }
    
    //保存图片
    @IBAction func savePic(_ sender: Any) {
        
        let height:CGFloat = self.view.bounds.size.height - self.saveBtn.frame.height - 10
        let imageSize :CGSize = CGSize(width: self.view.bounds.size.width, height: height)
        UIGraphicsBeginImageContext(imageSize)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let img:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        UIImageWriteToSavedPhotosAlbum(img, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    //保存图片回调
    func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo:UnsafeRawPointer) {
        var resultTitle:String?
        var resultMessage:String?
        if error != nil {
            resultTitle = "错误"
            resultMessage = "保存失败,请检查是否允许使用相册"
        } else {
            resultTitle = "提示"
            resultMessage = "保存成功"
        }
        let alert:UIAlertController = UIAlertController.init(title: resultTitle, message:resultMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "确定", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //屏幕切换时刷新
    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        self.paintView.setNeedsDisplay()
    }
    

}


    //
    //  LunboView.swift
    //  ChanganTravel
    //
    //  Created by apple on 16/9/14.
    //  Copyright © 2016年 ZZH. All rights reserved.
    //

    import UIKit
    //选择车辆的轮播
    class LunboView: UIView,UIScrollViewDelegate {
            var mymodelview=Doormodelview()//数据请求
            var myview=Doorview()
        var scrollview:UIScrollView?
        var dataarr:NSArray?
        var pagelabel:UILabel?
        var currentpage:Int=1
        var qianpage:Int=1
        var total:String="1"
        let zucheview:ZuCheView=ZuCheView()
        var longitude:Double=0.0
        var latitude:Double=0.0
        var retOutletsIdstr:String=""
        var takeOutletsIdstr:String=""
        typealias callbackfunc=(_ btntag:Int)->Void
        var myblock:callbackfunc?//向上一界面传值
        override init(frame: CGRect) {
            super.init(frame: frame)
            dataarr=[]
            initscrollview()
        }
        func initscrollview()
        {
            scrollview=UIScrollView.init(frame:self.bounds)
            scrollview?.isPagingEnabled=true
            scrollview?.contentMode = UIViewContentMode.center
            scrollview?.delegate=self
            scrollview?.contentOffset=CGPoint(x: 0, y: 0);
            self.addSubview(scrollview!)
            pagelabel=PublicView.label(withText: "1/1", andFrame: CGRect(x: 0, y: HEIGHTSWIFT*0.85-84, width: WIDTHSWIFT, height: HEIGHTSWIFT*0.06), andTextColor: UIColor.white, andFont: UIFont.systemFont(ofSize: myfont()+3.0), andduiqi: 1)
            self.addSubview(pagelabel!)
        }
        func addsimageview(_ icondataarr:NSArray,alltotal:String,namestr:String,daohangtaptag:Int,submittag:Int,typestr:String){
            let count:Int=(dataarr?.count)!
            for i in 0 ..< icondataarr.count {
                let timemodel=icondataarr[i] as! Timemodelswift
                let bgview=zucheview.creatbigbgview("card我要预订", titlestr: NSString.stringwithmystring(timemodel.number), titletag: 101, btnstr: namestr, btntag:(i+count+submittag), selfview:scrollview!, selfvc: self,myframe:CGRect(x: WIDTHSWIFT * CGFloat(i+count)+WIDTHSWIFT*0.04, y: 0,width: WIDTHSWIFT*0.92, height: HEIGHTSWIFT*0.85-84))
                creatxinxiui(bgview, mytimemodel: timemodel,daohangtaptag:(i+count+daohangtaptag),typestring:typestr)//创建里面的东西
            }
            let array = NSMutableArray()
            if count>0 {
                array.addObjects(from: self.dataarr! as [AnyObject])
                    array.addObjects(from: icondataarr as [AnyObject])
                }else{
                    array.addObjects(from: icondataarr as [AnyObject])
                }
            self.dataarr=array
            scrollview?.contentSize = CGSize( width: WIDTHSWIFT * CGFloat((dataarr?.count)!), height: self.frame.height)
            self.total=alltotal
            pagelabel?.text=String(format: "%d/%@", currentpage,alltotal)
        }
        func creatxinxiui(_ bigbgview:UIView,mytimemodel:Timemodelswift,daohangtaptag:Int,typestring:String){
            let iconview=PublicView.imageViewWithimage("长安逸动500300", andFrame: CGRect(x: bigbgview.frame.width*0.2,y: bigbgview.frame.height*0.11+20, width: bigbgview.frame.width*0.6, height: bigbgview.frame.height*0.26))
            iconview?.kf.setImage(with: URL(string: NSString.stringwithmystring(mytimemodel.imageString)), placeholder: UIImage(named: "长安逸动500300"))
            bigbgview.addSubview(iconview!)
           let carnamelabel=PublicView.label(withText: NSString.stringwithmystring(mytimemodel.carnname), andFrame: CGRect(x:(iconview?.frame.minX)!,y:(iconview?.frame.maxY)!-(iconview?.frame.height)!*0.3,width:(iconview?.frame.width)!,height:(iconview?.frame.height)!*0.3), andTextColor: UIColor.white, andFont: UIFont.systemFont(ofSize: myfont()), andduiqi: 1)
            carnamelabel?.backgroundColor=RGBA(0, g: 0, b: 0, a: 0.5)
             bigbgview.addSubview(carnamelabel!)
            let high=bigbgview.frame.height*0.85 - (iconview?.frame.maxY)!-50
           _=zucheview.creattupianlabel(CGRect(x: 15, y: (iconview?.frame.maxY)!+15, width: bigbgview.frame.width-30, height: high/4), imagestr: "", titlestr: "取车网点: ", detailstr: NSString.stringwithmystring(mytimemodel.outletsName), selfview: bigbgview, titlecolor: graycolor, detailcolor: UIColor.black,taptag:0,selfvc:self)
            let outletsLongitude:NSString=mytimemodel.outletsLongitude! as NSString
            let outletsLatitude:NSString=mytimemodel.outletsLatitude! as NSString
            let juli=PublicView.lantitudeLongitudeDist(longitude, other_Lat: latitude, self_Lon: outletsLongitude.doubleValue, self_Lat: outletsLatitude.doubleValue)
             let julikm=fabs(juli)/1000.0
            let julistring=String(format: "%.2f km", julikm)
            _=zucheview.creattupianlabel(CGRect(x: 15, y: (iconview?.frame.maxY)!+high/4+20, width: (bigbgview.frame.width-30)/2, height: high/4), imagestr: "", titlestr: "距离: ", detailstr: julistring, selfview: bigbgview, titlecolor: graycolor, detailcolor: organecolor,taptag:0,selfvc:self)
            _=zucheview.creattupianlabel(CGRect(x: 20+(bigbgview.frame.width-30)/2, y: (iconview?.frame.maxY)!+high/4+20, width: (bigbgview.frame.width-40)/2, height: high/4), imagestr: "icon-导航", titlestr: "导航 ", detailstr: "", selfview: bigbgview, titlecolor: graycolor, detailcolor: organecolor,taptag:daohangtaptag,selfvc:self)
            let hourRent=String.init(format: "%@", mytimemodel.hourRent!)
            _=zucheview.creattupianlabel(CGRect(x: 15,  y: (iconview?.frame.maxY)!+high/2+40, width: (bigbgview.frame.width-30)/3, height: high/4), imagestr: "", titlestr: hourRent, detailstr: "元/时", selfview: bigbgview, titlecolor: organecolor, detailcolor: graycolor,taptag:0,selfvc:self)
            let dayRent=String.init(format: "%@", mytimemodel.dayRent!)
            _=zucheview.creattupianlabel(CGRect(x: 20+(bigbgview.frame.width-30)/3 , y: (iconview?.frame.maxY)!+high/2+40, width: (bigbgview.frame.width-40)/3, height: high/4), imagestr: "", titlestr: dayRent, detailstr: "元/天", selfview: bigbgview, titlecolor: organecolor, detailcolor: graycolor,taptag:0,selfvc:self)
            //添加问号按钮?
            let btn=PublicView.button(withTitle: "", andtitlecolor: nil, andframe: CGRect(x: 30+(bigbgview.frame.width-30)*2/3 , y: (iconview?.frame.maxY)!+high/2+40+high/16, width:high/8, height: high/8), andImage: "icon-help-red", andColor: nil)
          
            if typestring == "1" {//公务
             btn?.tag=6465
            }else{//个人
                 btn?.tag=6464
            }
            btn?.addTarget(self, action: #selector(btnClick(_:)), for: UIControlEvents.touchUpInside)
            
            bigbgview.addSubview(btn!)
            
            let evBattery=String.init(format: "%@%% ", mytimemodel.evBattery!)
            _=zucheview.creattupianlabel(CGRect(x: 15, y:
                (iconview?.frame.maxY)!+high*3/4+45, width: (bigbgview.frame.width-30)/2, height: high/4), imagestr: "icon-电池", titlestr: evBattery, detailstr: "(电量)", selfview: bigbgview, titlecolor: RGBA(51, g: 51, b: 51, a: 1), detailcolor: graycolor,taptag:0,selfvc:self)
            let endurance=String.init(format: "%@ km ", mytimemodel.endurance!)
            _=zucheview.creattupianlabel(CGRect(x: 20+(bigbgview.frame.width-30)/2 , y: (iconview?.frame.maxY)!+high*3/4+45, width: (bigbgview.frame.width-40)/2, height: high/4), imagestr: "icon-续航", titlestr: endurance, detailstr: "(续航)", selfview: bigbgview, titlecolor:  RGBA(51, g: 51, b: 51, a: 1), detailcolor: graycolor,taptag:0,selfvc:self)
            //let lineview=PublicView.lineViewwithframe(CGRect(x: 5, y: (iconview?.frame.maxY)!+high/2+25, width: bigbgview.frame.width-10, height: 1))
            //bigbgview.addSubview(lineview!)
        }
        func tapClick(_ tap:UITapGestureRecognizer){
            if tap.view?.tag==3030 {
                tap.view?.removeFromSuperview()
                return
            }
    //        let tag=(tap.view?.tag)!-2000
    //        let timemodel=dataarr![tag] as! Timemodelswift
          self.myblock!((tap.view?.tag)!)
    //        selfvc.navigationController?.pushViewController(vc, animated: true)
        }
        func btnClick(_ btn:UIButton){
            if btn.tag==6464 || btn.tag==6465  {
                let typestr:String=(btn.tag==6464 ? "0" : "1")
            let timemodel=dataarr?[currentpage-1] as! Timemodelswift
            mymodelview.fetPubliccheliangmomey(NSString.stringwithmystring(timemodel.idstr), takeOutletsId: takeOutletsIdstr , retOutletsId: retOutletsIdstr,mytype:typestr)
            mymodelview.mymoneydict={
                    (dict:NSDictionary,total:String) in
                    self.myview.creatpricebgview(NSString.stringwithmystring(dict["hourPrice"]), daypricestr: NSString.stringwithmystring(dict["dayPrice"]), lichengfei: NSString.stringwithmystring(dict["insure"]), nightdayprice: NSString.stringwithmystring(dict["workdaynightRangePrice"]), overprice: NSString.stringwithmystring(dict["overTime"]), nightshijianstr: "", myframe: CGRect(x:25,y:30,width:WIDTHSWIFT-50,height:HEIGHTSWIFT*0.5), selfview: self,selfvc:self)
                }

                return
            }
            if btn.tag == 554 {//我知道了的
                let bgview=btn.superview
                bgview?.superview?.removeFromSuperview()
                return
            }

            printhidden(btn.tag as AnyObject)
            self.myblock!(btn.tag)
        }
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            let i=(scrollView.contentOffset.x + WIDTHSWIFT/2)/WIDTHSWIFT
            currentpage=Int(i)+1
            if currentpage == ((dataarr?.count)! - 1) && qianpage < currentpage {//最大值
                self.myblock!(888)
            }
            pagelabel?.text=String(format: "%d/%@", currentpage,total)
            print(i)
            if currentpage > qianpage {
            qianpage=currentpage
            }
        }
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        /*
        // Only override drawRect: if you perform custom drawing.
        // An empty implementation adversely affects performance during animation.
        override func drawRect(rect: CGRect) {
            // Drawing code
        }
        */

    }



defineClass ('AppDelegate',{
             
             
             application_didFinishLaunchingWithOptions: function(application, launchOptions) {
             self.ORIGapplication_didFinishLaunchingWithOptions(application, launchOptions);
             
             console.log("测试jspatch成功");
             
             },
             
             })


defineClass('JSPatchDemoViewController',['scrollView','nametextf','passwordtextf','nextBtn'], {
            
            //添加全局的属性首先要在init内部实例化
            init: function() {
            require('UIScreen,UIScrollView,UIColor,UIButton,UITextField');
            self = self.super().init()
            self.setScrollView(UIScrollView.alloc().init());
            
            self.setNametextf(UITextField.alloc().init());
            self.setPasswordtextf(UITextField.alloc().init());
            self.setNextBtn(UIButton.alloc().init());
            
            return self
            },
            
            
            
            viewDidLoad: function() {
            self.ORIGviewDidLoad();
            
            self.addNotification();
            
            self.view().setBackgroundColor(require('UIColor').whiteColor());
            
            self.setTitle("测试的控制器Two");
            //先导入引用类
            require('UIScreen,UIView+CustomView,UIScrollView,UIColor');
            //设置全局变量
            var screenWidth = UIScreen.mainScreen().bounds().width;
            
            var screenheight = UIScreen.mainScreen().bounds().height;
            
            
            var lscrollView = self.scrollView();
            lscrollView.setAlwaysBounceVertical(true);
            lscrollView.setShowsVerticalScrollIndicator(false);
            
            self.view().addSubview(lscrollView);
            
            self.nametextf().setTextAlignment(0);
            self.nametextf().setPlaceholder("请输入用户名");
            self.nametextf().setBorderStyle(3);
            self.nametextf().setDelegate(self);
            lscrollView.addSubview(self.nametextf());
            
            self.passwordtextf().setTextAlignment(0);
            self.passwordtextf().setPlaceholder("请输入密码");
            self.passwordtextf().setBorderStyle(3);
            self.passwordtextf().setDelegate(self);
            lscrollView.addSubview(self.passwordtextf());
            
            self.nextBtn().setTitle_forState("登录", 0);
            self.nextBtn().setBackgroundColor(require('UIColor').blueColor());
            self.nextBtn().addTarget_action_forControlEvents(self, 'tapLogin', 1<<6);
            lscrollView.addSubview(self.nextBtn());

            
            
            },
            
            tapLogin : function(){
            
            if(self.nametextf().text().length() > 0 && self.passwordtextf().text().length() > 0){
            require('TooltipView').showWithText("登录");
            self.login(self.nametextf().text(),self.passwordtextf().text());
            }else{
            require('TooltipView').showWithText("请输入用户名和密码");
            }
            
            },
            
        
            
            login : function (username,password){
            
                var jwTestViewCtrl = JWTestViewController.alloc().init()
                jwTestViewCtrl.setHidesBottomBarWhenPushed(YES);
                self.navigationController().pushViewController_animated(jwTestViewCtrl, YES)
            
            },
            
            
            viewDidLayoutSubviews : function (){
            
            var NavHeight = 64;
            
            var screenWidth = UIScreen.mainScreen().bounds().width;
            var screenheight = UIScreen.mainScreen().bounds().height;
            self.scrollView().setFrame({x:0, y:0+NavHeight, width:screenWidth, height:screenheight});
            self.passwordtextf().setFrame({x:20, y:60 + NavHeight, width:screenWidth-40, height:30});
            self.nametextf().setFrame({x:20, y:20 + NavHeight, width:screenWidth-40, height:30});
            self.nextBtn().setFrame({x:20, y:100 + NavHeight, width:screenWidth-40, height:30});
            },
            
            
            
            })

/*
 随便创建一个控制器
 */
defineClass('JWTestViewController : UIViewController', ['scrollView'], {
            
            
            //添加全局的属性首先要在init内部实例化
            init: function() {
            require('UIScreen,UIView+CustomView,UIScrollView,UIColor');
            var screenWidth = UIScreen.mainScreen().bounds().width;
            var screenheight = UIScreen.mainScreen().bounds().height;
            self = self.super().init()
            self.setScrollView(UIScrollView.alloc().initWithFrame({x:0, y:0, width:screenWidth, height:screenheight}));
            return self
            },
            
            
            viewDidLoad: function() {
            self.ORIGviewDidLoad();
            
            self.view().setBackgroundColor(require('UIColor').whiteColor());
            
            self.setTitle("测试的控制器");
            //先导入引用类
            require('UIScreen,UIView+CustomView,UIScrollView,UIColor');
            //设置全局变量
            var screenWidth = UIScreen.mainScreen().bounds().width;
            
            var screenheight = UIScreen.mainScreen().bounds().height;
            
            
            
            var lscrollView = self.scrollView();
            lscrollView.setAlwaysBounceVertical(true);
            lscrollView.setShowsVerticalScrollIndicator(false);
            
            self.view().addSubview(lscrollView);
            
            var jsArr = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20"];
            
            var maxBtnHeight = 0;
            
            require('UIButton,UIImage');
            for (var i = 0; i < jsArr.length; i++) {
            var button = UIButton.buttonWithType(0);
            button.setTitle_forState(jsArr[i], 0);
            button.setTag(1001 + i);
            button.setBackgroundColor(require('UIColor').redColor());
            button.setTitleColor_forState(require('UIColor').blackColor(), 0);
            button.layer().setBorderWidth(0.5);
            button.layer().setBorderColor(require('UIColor').blackColor());
            button.addTarget_action_forControlEvents(self, 'testTap:', 1<<6);
            
            var a = parseInt(i / 3);
            var b = i % 3;
            var Btnheight = screenWidth / 3;
            
            button.setFrame({x: b * Btnheight, y:Btnheight * a, width:Btnheight, height:Btnheight});
            
            lscrollView.addSubview(button);
            
            maxBtnHeight = button.y() + Btnheight;
            
            
            }
            
            require('JWTestView');
            
            var textView = JWTestView.alloc().initWithFrame({x:0, y:maxBtnHeight, width:screenWidth, height:300});
            
            lscrollView.addSubview(textView);
            
            
            lscrollView.setContentSize({width: 0, height:textView.y()+300});
            
            
            self.mylogfun();
            
            
            },
            
            testTap : function(button){
            
            console.log(button.titleLabel().text());
            
                require('TooltipView').showWithText("点击了" + button.tag());
            
            },
            
            
            mylogfun : function(){
            
            console.log("----");
            
            }
            
            
            })

/*
 创建一个view
 */

defineClass('JWTestView : UIView', {
            
            
            //            require('UIImageView,UIColor,UIScreen');
            
            initWithFrame: function(frame) {
            self = self.super().initWithFrame(frame);
            if (self) {
            //            var screenWidth = UIScreen.mainScreen().bounds().width;
            //            var screenheight = UIScreen.mainScreen().bounds().height;
            var imageView = require('UIImageView').alloc().init();
            imageView.setFrame({x: 0, y:0, width:200, height:200})
            imageView.setBackgroundColor(require('UIColor').blueColor());
            imageView.setImage(require('UIImage').imageNamed("more-2"));
            self.addSubview(imageView);
            
            }
            return self;
            },
            
            
            
            
            
            })






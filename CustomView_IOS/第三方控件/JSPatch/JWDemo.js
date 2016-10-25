

defineClass ('AppDelegate',{
             
             
             application_didFinishLaunchingWithOptions: function(application, launchOptions) {
             self.ORIGapplication_didFinishLaunchingWithOptions(application, launchOptions);
             
             console.log("测试jspatch成功");
             
             },
             
             })


defineClass('JSPatchDemoViewController',['scrollView','nametextf','passwordtextf','nextBtn'], {
            
            //添加全局的属性首先要在init内部实例化
            init: function() {
            require('UIScreen,UIView+CustomView,UIScrollView,UIColor,UIButton,UITextField');
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






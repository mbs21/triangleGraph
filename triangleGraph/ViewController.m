#import "ViewController.h"
#define MarginR         UIViewAutoresizingFlexibleRightMargin
#define MarginL         UIViewAutoresizingFlexibleLeftMargin
#define MarginTop       UIViewAutoresizingFlexibleTopMargin
#define MarginBottom    UIViewAutoresizingFlexibleBottomMargin
@interface ViewController ()
@end

@implementation ViewController
{
    //使用するツールの宣言
    UINavigationBar *mainTop;
    UINavigationBar *secondTop;
    UINavigationItem *NaviTitle;
    UINavigationItem *secondTitle;
    UILabel *title;
    UIBarButtonItem *drawbt;
    UIScrollView *mainView;
    UIScrollView *secondView;
    UIFont *ja_font;
    UILabel *result;
    UITextField *sides_input[3];
    UIButton *next;
    UIButton *prev;
    UIButton *done;
    UIButton *rute;
    UILabel *sidesRute[3];
    UILabel *separate;
    int ruteOnOff[3];
    int textPosition;
    double a;
    double b;
    double c;
    double longest;
    double drawHeigh;
    double drawWidth;
    double IntersectionPoint_X;
    double IntersectionPoint_Y;
    char triangleType;
    /*  triangleType
        1_正三角形
        2_直角二等辺三角形
        3_直角三角形
        4_鈍角二等辺三角形
        5_鋭角二等辺三角形
        0_三角形
     */
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UILabel *sides_name[3];
    UILabel *result_title;
    UIButton *judgment;
    UIButton *reset_bt;
    UITapGestureRecognizer *gestureRecognizer;
    UIView *additionalKeys;
    
    //フォントの設定
    ja_font = [UIFont fontWithName:@"HiraKakuProN-W3" size:17];
    
    //タイトルの初期化、作成
    mainTop = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    mainTop.alpha = 0.7f;
    mainTop.barStyle = UIBarStyleDefault;
    [self.view addSubview:mainTop];
    //[self.navigationController setNavigationBarHidden:NO animated:NO];
    
    title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 60)];
    title.backgroundColor = [UIColor clearColor];
    title.text = @"三角形判定";
    title.font = [UIFont fontWithName:@"HiraKakuProN-W6" size:17];
    title.textAlignment = 1;
    title.textColor = [UIColor blackColor];
    
    NaviTitle = [[UINavigationItem alloc]init];
    NaviTitle.titleView = title;
    [mainTop pushNavigationItem:NaviTitle animated:YES];
    
    //表示する画面の作成
    mainView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height-60)];
    mainView.autoresizesSubviews =
    MarginR | MarginL | MarginTop | MarginBottom;
    [self.view addSubview:mainView];
    
    //辺の名前と入力を初期化、作成
    for (int i=0; i<3; i++) {
        sides_name[i] = [[UILabel alloc]init];
        sides_name[i].frame = CGRectMake(70, 70+70*i, 40, 20);
        sides_name[i].font = ja_font;
        sides_name[i].autoresizingMask =
        MarginR | MarginL | MarginTop | MarginBottom;
        
        sides_input[i] = [[UITextField alloc]init];
        sides_input[i].borderStyle = UITextBorderStyleRoundedRect;
        sides_input[i].keyboardType = UIKeyboardTypeNumberPad;
        sides_input[i].clearButtonMode = UITextFieldViewModeWhileEditing;
        sides_input[i].placeholder = @"数字を入力";
        sides_input[i].tag = i;
        sides_input[i].delegate = self;
        sides_input[i].font = ja_font;
        sides_input[i].frame = CGRectMake(160, 70+70*i, 100, 20);
        sides_input[i].autoresizingMask =
        MarginR | MarginL | MarginTop | MarginBottom;
    }
    sides_name[0].text = @"辺A";
    sides_name[0].textColor = [UIColor redColor];
    //sides_input[0].textColor = [UIColor redColor];
    sides_name[1].text = @"辺B";
    sides_name[1].textColor = [UIColor greenColor];
    //sides_input[1].textColor = [UIColor greenColor];
    sides_name[2].text = @"辺C";
    sides_name[2].textColor = [UIColor blueColor];
    //sides_input[2].textColor = [UIColor blueColor];
    
    //判定ボタンの作成
    judgment = [UIButton buttonWithType:UIButtonTypeSystem];
    [judgment setTitle:@"判定ボタン" forState: UIControlStateNormal];
    judgment.frame = CGRectMake(170, 290, 100, 20);
    [judgment.titleLabel setFont: ja_font];
    judgment.autoresizingMask =
    MarginR | MarginL | MarginTop | MarginBottom;
    //判定ボタンを押した時のアクション
    [judgment addTarget:self action:@selector(error_check:) forControlEvents:UIControlEventTouchDown];
    
    //リセットボタンの作成
    reset_bt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [reset_bt.titleLabel setFont:ja_font];
    [reset_bt setTitle:@"リセット" forState:UIControlStateNormal];
    reset_bt.frame = CGRectMake(60, 290, 80, 20);
    reset_bt.autoresizingMask =
    MarginR | MarginL | MarginTop | MarginBottom;
    [reset_bt.titleLabel setFont:ja_font];
    //リセットボタンを押したときのアクション
    [reset_bt addTarget:self action:@selector(reset:) forControlEvents:UIControlEventTouchDown];
    
    //判定のタイトルの初期化、作成
    result_title = [[UILabel alloc]init];
    result_title.text = @"判定:";
    result_title.frame = CGRectMake(70, 360, 50, 20);
    result_title.font = ja_font;
    result_title.autoresizingMask =
    MarginR | MarginL | MarginTop | MarginBottom;
    
    //判定結果の初期化、作成
    result = [[UILabel alloc]init];
    result.frame = CGRectMake(120, 360, 180, 20);
    result.textColor = [UIColor redColor];
    result.textAlignment = 1;
    result.font = ja_font;
    result.autoresizingMask =
    MarginR | MarginL | MarginTop | MarginBottom;
    
    //キーボードの上にボタンの追加
    additionalKeys = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    additionalKeys.backgroundColor = [UIColor clearColor];
    
    //テキストフィールドを戻るボタンの初期化、作成
    prev = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    prev.frame = CGRectMake(0, 5, 50, 30);
    [prev.titleLabel setFont:ja_font];
    [prev setTitle:@"Prev" forState:UIControlStateNormal];
    [prev addTarget:self action:@selector(previousText:) forControlEvents:UIControlEventTouchDown];
    [additionalKeys addSubview:prev];
    
    //区切りのテキスト
    separate = [[UILabel alloc]init];
    separate.frame = CGRectMake(50, 5, 10, 30);
    separate.text = @"/";
    [additionalKeys addSubview:separate];
    
    //テキストフィールドを進むボタンの初期化、作成
    next = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    next.frame = CGRectMake(60, 5, 50, 30);
    [next.titleLabel setFont:ja_font];
    [next setTitle:@"Next" forState:UIControlStateNormal];
    [next addTarget:self action:@selector(nextText:) forControlEvents:UIControlEventTouchDown];
    [additionalKeys addSubview:next];
    
    //テキストフィールドを閉じるボタンの初期化、作成
    done = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    done.frame = CGRectMake(260, 5, 50, 30);
    [done.titleLabel setFont:ja_font];
    [done setTitle:@"Done" forState:UIControlStateNormal];
    done.autoresizingMask =
    MarginR | MarginL | MarginTop | MarginBottom;
    [done addTarget:self action:@selector(closeSoftKeyboard) forControlEvents:UIControlEventTouchDown];
    [additionalKeys addSubview:done];
    
    //√を加えるためのボタンの初期化、作成
    rute = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    rute.frame = CGRectMake(130, 5, 50, 30);
    [rute.titleLabel setFont:ja_font];
    [rute setTitle:@"( √ )" forState:UIControlStateNormal];
    [rute addTarget:self action:@selector(ruteMake) forControlEvents:UIControlEventTouchDown];
    [additionalKeys addSubview:rute];
    
    //ソフトウェアキーボード使用時、キーボード以外をタップするとキーボードを閉じるアクション
    gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeSoftKeyboard)];
    
    //画面にツールを貼付け
    //[mainView addSubview:title];
    for (int i=0; i<3; i++) {
        [mainView addSubview:sides_name[i]];
        [mainView addSubview:sides_input[i]];
        sides_input[i].inputAccessoryView = additionalKeys;
    }
    [mainView addSubview:judgment];
    [mainView addSubview:result_title];
    [mainView addSubview:result];
    [mainView addSubview:reset_bt];
    [mainView addGestureRecognizer:gestureRecognizer];
    
    [self registerForKeyboardNotifications];
}
//判定ボタンを押されたとき、エラーをチェックするメソッド
-(IBAction)error_check:(UIButton*)sender
{
    UIAlertView *error;
    NSMutableString *error_detail;
    NSString *error_sides = [NSString stringWithFormat:@""];
    
    [self closeSoftKeyboard];
    //何も入力されていないとき
    if ([sides_input[0].text  isEqual: @""] || [sides_input[1].text  isEqual: @""] || [sides_input[2].text  isEqual: @""]) {
        int i = 0;
        if ([sides_input[0].text  isEqual: @""]) {
            error_sides = [error_sides stringByAppendingString:@"辺A、"];
            i++;
        }
        if ([sides_input[1].text  isEqual: @""]) {
            error_sides = [error_sides stringByAppendingString:@"辺B、"];
            i++;
        }
        if ([sides_input[2].text  isEqual: @""]) {
            error_sides = [error_sides stringByAppendingString:@"辺C、"];
            i++;
        }
        error_detail = [NSMutableString stringWithFormat:@"%@が入力されていません。", error_sides];
        [error_detail deleteCharactersInRange:NSMakeRange(i*3-1, 1)];
        error = [[UIAlertView alloc]initWithTitle:@"エラー" message:error_detail delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        
        [error show];
    }
    //エラーがなかったとき
    else{
        //計算するメソッドへ移行
        [self operation];
    }
}
//エラーがないときの三角形判定をするメソッド
- (void)operation
{
    //入力された数字の初期化
    a = [sides_input[0].text doubleValue];
    b = [sides_input[1].text doubleValue];
    c = [sides_input[2].text doubleValue];
    double a2 = 0.0;
    double b2 = 0.0;
    double c2 = 0.0;
    
    //√を使っているかどうかの判定
    if (ruteOnOff[0] == 1) {
        a2 = a;
        a = sqrt(a);
    }
    if(ruteOnOff[0] == 0){
        a2 = a*a;
    }
    if (ruteOnOff[1] == 1) {
        b2 = b;
        b = sqrt(b);
    }
    if(ruteOnOff[1] == 0){
        b2 = b*b;
    }
    if (ruteOnOff[2] == 1) {
        c2 = c;
        c = sqrt(c);
    }
    if(ruteOnOff[2] == 0){
        c2 = c*c;
    }
    
    //三角形判定
    /*  triangleType
     1_正三角形
     2_直角二等辺三角形
     3_直角三角形
     4_鈍角二等辺三角形
     5_鋭角二等辺三角形
     0_三角形
     */
    if ((a==0) || (b==0) || (c==0)) {
        result.text = @"三角形ではありません";
    }
    else{
        if ((a+b<=c) || (a+c<=b) || (b+c<=a)) {
            result.text = @"三角形ではありません";
        }
        else{
            if ((a==b) && (b==c)) {
                result.text = @"正三角形";
                triangleType = 1;
            }
            else if (((c2 == a2+b2) || (a2 == b2+c2) || (b2 == a2+c2)) && ((a==b) || (a==c) || (b==c))){
                result.text = @"直角二等辺三角形";
                triangleType = 2;
            }
            else if ((c2 == a2+b2) || (a2 == b2+c2) || (b2 == a2+c2)){
                result.text = @"直角三角形";
                triangleType = 3;
            }
            else if ((a==b) || (b==c) || (c==a)){
                result.text = @"二等辺三角形";
                if ( a==b ) {
                    if ( a>c ) {
                        triangleType = 5;
                    }
                    else{
                        triangleType = 4;
                    }
                }
                else if ( b==c ) {
                    if ( b>a ) {
                        triangleType = 5;
                    }
                    else{
                        triangleType = 4;
                    }
                }
                else{
                    if ( c>b ) {
                        triangleType = 5;
                    }
                    else{
                        triangleType = 4;
                    }
                }
                
            }
            else{
                result.text = @"三角形";
                triangleType = 0;
            }
            drawbt = [[UIBarButtonItem alloc]initWithTitle:@"Draw" style:UIBarButtonItemStyleBordered target:self action:@selector(drawAction)];
            NaviTitle.rightBarButtonItem = drawbt;
            [self oprateIntersectionPoint];
        }
    }

}
//リセットボタンを押されたときのメソッド
-(IBAction)reset:(UIButton*)sender
{
    result.text = @"";
    NaviTitle.rightBarButtonItem = Nil;
    for (int i=0; i<3; i++) {
        sides_input[i].text = @"";
        if (ruteOnOff[i] == 1) {
            textPosition = i;
            [self ruteMake];
        }
    }
}
//ソフトウェアキーボード使用時、キーボード以外をタップするとキーボードを閉じるメソッド
- (void)closeSoftKeyboard {
    [self.view endEditing: YES];
}
//テキストフィールドを戻るメソッド
-(IBAction)previousText:(UITextField*)textField
{
    [sides_input[textPosition-1] becomeFirstResponder];
}
//テキストフィールドを進むメソッド
-(IBAction)nextText:(UITextField*)sender
{
    [sides_input[textPosition+1] becomeFirstResponder];
}
//テキストフィールドを編集するときに戻る、進むボタンの可、不可を行うメソッド
-(BOOL)textFieldShouldBeginEditing:(UITextField*)textField
{
    switch (textField.tag) {
        case 0:
            prev.enabled = NO;
            next.enabled = YES;
            textPosition = 0;
            break;
        case 2:
            prev.enabled = YES;
            next.enabled = NO;
            textPosition = 2;
            break;
        default:
            prev.enabled = YES;
            next.enabled = YES;
            textPosition = 1;
            break;
    }
    return YES;
}
//キーボードが出ているときと出ていないときの処理
-(void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHidden:) name:UIKeyboardWillHideNotification object:nil];
}
//キーボードが出ているときに画面を上に動かすメソッド
-(void)keyboardShown:(NSNotification*)aNotfication
{
    CGPoint scrollPoint = CGPointMake(0.0, 60.0);
    [mainView setContentOffset:scrollPoint animated:YES];
}
//上に動かした画面を元に戻したメソッド
-(void)keyboardHidden:(NSNotification*)aNotfication
{
    [mainView setContentOffset:CGPointZero animated:YES];
}
//√ボタンを押したときの処理をするメソッド
-(void)ruteMake
{
    static int appear[3] = {0,0,0};
    static int firstOrOther = 0;
    if (firstOrOther == 0) {
        for (int i=0; i<3; i++) {
            sidesRute[i] = [[UILabel alloc]init];
            sidesRute[i].frame =  CGRectMake(140, 70+70*i, 10, 20);
            sidesRute[i].text = @"√";
            sidesRute[i].font = ja_font;
            ruteOnOff[i] = appear[i];
        }
        firstOrOther++;
        [mainView addSubview:sidesRute[textPosition]];
    }
    if (firstOrOther == 1){
        if (appear[textPosition] == 0) {
            [mainView addSubview:sidesRute[textPosition]];
            appear[textPosition]++;
            ruteOnOff[textPosition] = appear[textPosition];
        }
        else{
            [sidesRute[textPosition] removeFromSuperview];
            appear[textPosition] = 0;
            ruteOnOff[textPosition] = appear[textPosition];
        }
    }
}

- (void)drawAction
{
    UIViewAnimationTransition trans;
    trans = UIViewAnimationTransitionFlipFromRight;
    
    //三角形の高さや交点を調べるメソッドを呼びだし
    [self oprateIntersectionPoint];
    
    secondTop = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    secondTop.alpha = 0.7f;
    secondTop.barStyle = UIBarStyleDefault;

    UILabel *tmp = [[UILabel alloc]init];
    tmp.frame = CGRectMake(0, 0, 180, 20);
    tmp.textColor = [UIColor redColor];
    tmp.textAlignment = 1;
    tmp.font = ja_font;
    tmp.text = result.text;
    secondTitle = [[UINavigationItem alloc]init];
    secondTitle.titleView = tmp;
    [secondTop pushNavigationItem:secondTitle animated:YES];
    
    //<の追加
    UIBarButtonItem *backbt = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(backViewAction)];
    secondTitle.leftBarButtonItem = backbt;

    secondView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height-60)];
    secondView.backgroundColor = [UIColor whiteColor];

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationTransition:trans forView:self.view cache:YES];
    [UIView setAnimationDuration:1.0];
    [mainTop removeFromSuperview];
    [mainView removeFromSuperview];
    [self.view addSubview:secondTop];
    [self.view addSubview:secondView];
    
    if (longest+100 <= self.view.frame.size.width) {
        if (longest+100 <= self.view.frame.size.height-60) {
            drawWidth = (double)self.view.frame.size.width;
            drawHeigh = (double)self.view.frame.size.height-60;
        }
        else{
            drawWidth = (double)self.view.frame.size.width;
            drawHeigh = longest+100-60;
        }
    }
    else{
        if (longest+100 <= self.view.frame.size.height-60) {
            drawWidth = longest+100;
            drawHeigh = (double)self.view.frame.size.height-60;
        }
        else{
            drawWidth = longest+100;
            drawHeigh = longest+100-60;
        }
    }
    
    DrawTriangle *triangleDraw = [[DrawTriangle alloc]initWithFrame:CGRectMake(0, 0, drawWidth, drawHeigh)];
    triangleDraw._IntersectionPoint_X = IntersectionPoint_X;
    triangleDraw._IntersectionPoint_Y = IntersectionPoint_Y;
    triangleDraw._drawWidth = drawWidth;
    triangleDraw._drawHeight = drawHeigh;
    triangleDraw._triangleType = triangleType;
    triangleDraw._a = a;
    triangleDraw._b = b;
    triangleDraw._c = c;
    secondView.contentSize = triangleDraw.frame.size;
    [secondView addSubview:triangleDraw];
    
    [UIView commitAnimations];
   
}

- (void)backViewAction
{
    UIViewAnimationTransition trans;
    trans = UIViewAnimationTransitionFlipFromLeft;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationTransition:trans forView:self.view cache:YES];
    [UIView setAnimationDuration:1.0];
    [self.view addSubview:mainTop];
    [self.view addSubview:mainView];
    [secondTop removeFromSuperview];
    [secondView removeFromSuperview];
    [UIView commitAnimations];
}
/*  triangleType
 1_正三角形
 2_直角二等辺三角形
 3_直角三角形
 4_鈍角二等辺三角形
 5_鋭角二等辺三角形
 0_三角形
 */
- (void)oprateIntersectionPoint
{
    double f;
    double S;
    double h;
    
    //直角二等辺三角形、鈍角二等辺三角形、三角形の場合
    if (triangleType == 2 || triangleType == 4 || triangleType == 0) {
        f = (a+b+c)/2.0;
        
        S = sqrt(f*(f-a)*(f-b)*(f-c));
        
        if ( a>=b && a>=c) {
            h = 2*S/a;
            IntersectionPoint_X = sqrt(c*c-h*h);
            IntersectionPoint_Y = h;
        }
        else if ( b>=c && b>=a) {
            h = 2*S/b;
            IntersectionPoint_X = sqrt(a*a-h*h);
            IntersectionPoint_Y = h;
        }
        else {
            h = 2*S/c;
            IntersectionPoint_X = sqrt(b*b-h*h);
            IntersectionPoint_Y = h;
        }
    }
    //正三角形の場合
    if (triangleType == 1) {
        IntersectionPoint_X = a/2.0;
        IntersectionPoint_Y = sqrt(a*a-(a/2.0)*(a/2.0));
    }
    //鋭角二等辺三角形の場合
    if (triangleType == 5) {
        if ( a==b ) {
            h = sqrt(a*a-(c/2.0)*(c/2.0));
            IntersectionPoint_X = c/2.0;
            IntersectionPoint_Y = h;
        }
        else if ( b==c ) {
            h = sqrt(b*b-(a/2.0)*(a/2.0));
            IntersectionPoint_X = a/2.0;
            IntersectionPoint_Y = h;
        }
        else if ( c==a ) {
            h = sqrt(c*c-(b/2.0)*(b/2.0));
            IntersectionPoint_X = b/2.0;
            IntersectionPoint_Y = h;
        }
    }
    //一番長い辺をもとめる
    if ( a>=b && a>=c && a>=h) {
        longest = a*MAGNIFICATION;
    }
    else if ( b>=a && b>=c && b>=h) {
        longest = b*MAGNIFICATION;
    }
    else if ( c>=a && c>=b && c>=h) {
        longest = c*MAGNIFICATION;
    }
    else if ( h>=a && h>=b && h>=c){
        longest = h*MAGNIFICATION;
    }
}

@end

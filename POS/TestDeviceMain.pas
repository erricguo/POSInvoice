unit TestDeviceMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Forms, Controls, CommDevSub, Dialogs, DB,
  ADODB, CommDev, CommTypes, ComCtrls, StdCtrls, POSChkBox, Buttons, POSButtons,
  ExtCtrls,ComObj;

type
  TfrmDeviceTest = class(TForm)
    InvPrinter: TInvPrinter;
    Display: TDisplay;
    HandyScan: THandyScan;
    pcTest: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    StatusBar: TStatusBar;
    adoQuery: TADOQuery;
    EDCCom: TEDCCom;
    KeyHook1: TKeyHook;
    TestSND: TDisplay;
    OpenDialog: TOpenDialog;
    Panel1: TPanel;
    POSSpeedButton4: TPOSButton;
    POSSpeedButton2: TPOSSpeedButton;
    POSSpeedButton1: TPOSSpeedButton;
    sbUniName: TSpeedButton;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Button1: TPOSButton;
    ComboBox2: TComboBox;
    ComboBox1: TComboBox;
    ComboBox3: TComboBox;
    Button2: TPOSButton;
    btFF: TPOSButton;
    btLF: TPOSButton;
    btDrawer: TPOSButton;
    btPrint: TPOSButton;
    btStamp: TPOSButton;
    btCutPaper: TPOSButton;
    Edit1: TEdit;
    ckInvPrinterStatus: TPOSCheckBox;
    cdInvPrinterDefaultReset: TPOSCheckBox;
    btValid: TPOSButton;
    btBarcode: TPOSButton;
    edUniName: TEdit;
    edExcelPath: TEdit;
    btnExcelPath: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    edComp: TEdit;
    Label3: TLabel;
    edUniNo: TEdit;
    Memo1: TMemo;
    btnPrint: TPOSButton;
    procedure Button10Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btFFClick(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure ckInvPrinterStatusClick(Sender: TObject);
    procedure POSSpeedButton1Click(Sender: TObject);
    procedure POSSpeedButton2Click(Sender: TObject);
    procedure POSSpeedButton3Click(Sender: TObject);
    procedure POSSpeedButton4Click(Sender: TObject);
    procedure InvPrinterPtrError(Sender: TObject; Msg: String;
      ErrorCode: Integer; var Retry: Boolean);
    procedure cdInvPrinterDefaultResetClick(Sender: TObject);
    procedure POSButton1Click(Sender: TObject);
    procedure POSSpeedButton5Click(Sender: TObject);
    procedure POSButton2Click(Sender: TObject);
    procedure sbUniNameClick(Sender: TObject);
    procedure POSSpeedButton6Click(Sender: TObject);
    procedure POSButton3Click(Sender: TObject);
    procedure EDCComEDCError(Sender: TObject; ErrorCode: Integer;
      var Suspend: Boolean);
    procedure EDCComEDCMsg(Sender: TObject; MsgCode, Second: Integer;
      var Suspend: Boolean);
    procedure EDCComGetEDC(Sender: TObject; CardValue: CREDITCARD);
    procedure btnSQLChangeMemClick(Sender: TObject);
    procedure cbEDCTypeChange(Sender: TObject);
    procedure POSSpeedButton7Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure cdInvCombineDspClick(Sender: TObject);
    procedure SetInvCombineDsp(xValue: boolean);
    procedure HandyScanGetData(Sender: TObject; Data: AnsiString;
      DataLength: Integer);
    procedure POSButton4Click(Sender: TObject);
    procedure POSButton5Click(Sender: TObject);
    procedure POSButton6Click(Sender: TObject);
    procedure KeyHook1HookKeyUpEvent(Sender: TObject; ScanCode: Cardinal;
      Key: AnsiChar; KeyState: TShiftState);
    procedure btnPrintClick(Sender: TObject);
    procedure btnExcelPathClick(Sender: TObject);
  private
    { Private declarations }
    FAdoOpened, FSuspend: boolean;
    FMinMem, FMaxMem: integer;
    procedure CheckStatus(xConnect, xTransmit: integer);
    function GetEDCMsg(xType, xMsgID: integer): string;
    function getImageSize (p_pstrSourceFile:Ansistring;var p_lngHeight, p_lngWidth :LongInt):LongInt;
    function getNVBitImage(const config; p_lngHeight, p_lngWidth: Integer; p_pstrSourceFile: AnsiString): LongInt;
    function UTF8Bytes(const s: UTF8String): TBytes;
  public

    FPtrBufferHead,FPtrBuffer:TStringList;
    procedure GOPrint(xTxNO:string);
  end;

var
  frmDeviceTest: TfrmDeviceTest;

implementation

{$R *.DFM}
uses winsock, LibPOS;

procedure TfrmDeviceTest.CheckStatus(xConnect, xTransmit: integer);
begin
    with StatusBar.Panels do
    begin
        case xConnect of
            0:  Items[0].Text := '斷線!';
            1:  Items[0].Text := '已連接!';
            2:  Items[0].Text := '';
        end;
        {case xTransmit of
            0:  Items[1].Text := '傳送失敗!';
            1:  Items[1].Text := '已傳送成功!';
            2:  Items[1].Text := '';
        end;   }
    end;
end;

procedure TfrmDeviceTest.Button10Click(Sender: TObject);
begin
 { try
    if not cdInvCombineDsp.Checked then
    begin
      Display.Port := TDevicePort(ComboBox6.ItemIndex);
      Display.Display := TDisplayerType(ComboBox5.ItemIndex);
      Display.WelcomeUpperRow := Edit2.Text;
      Display.WelcomeLowRow := Edit3.Text;
      Display.RowLength := StrToIntDef(Edit5.Text, 20);
      Display.UniName := Edit6.Text;
      if Display.Connect then
          CheckStatus(1, 2)
      else
          CheckStatus(0, 2);
    end;
  except
    CheckStatus(0, 0);
  end; }
end;

procedure TfrmDeviceTest.Button9Click(Sender: TObject);
begin
  {  if not cdInvCombineDsp.Checked then
    begin
      Display.ClearAll;
      Display.DisplayString2('Display Closed', '');
      Display.DisConnect;
      CheckStatus(0, 2);
    end;  }
end;

procedure TfrmDeviceTest.Button1Click(Sender: TObject);
begin
  try
    //InvPrinter.DefaultReset := cdInvPrinterDefaultReset.Checked;
    InvPrinter.DefaultReset := True;
    if (ComboBox1.ItemIndex >= 6) and (ComboBox1.ItemIndex <= 12) then
      InvPrinter.ConnectType := cm_ParallelPort
    else
      InvPrinter.ConnectType := cm_SerialPort;

    InvPrinter.Port := TDevicePort(ComboBox1.ItemIndex);
    InvPrinter.PrinterType := TPrinterType(ComboBox3.ItemIndex);
    InvPrinter.UniName := edUniName.Text;

    if InvPrinter.Connect then
    begin
      //SetInvCombineDsp(cdInvCombineDsp.Checked);
      CheckStatus(1, 2)
    end
    else
        CheckStatus(0, 2);
  except
    CheckStatus(0, 0);
  end;
end;

procedure TfrmDeviceTest.Button2Click(Sender: TObject);
begin
    if InvPrinter.PortHandle > 0 then
      SetInvCombineDsp(false);
    InvPrinter.DisConnect;
    CheckStatus(0, 2);
end;

procedure TfrmDeviceTest.btFFClick(Sender: TObject);
var
  xName: string;
  xResult: boolean;
  i,j:integer;
  //Logo專用變數
  s_lngReturn,s_lngTargetHeight,s_lngTargetWidth:LongInt;
  s_bufNV: Array of byte;
  s_strFileName :String;
  aa:string;
  num:DWORD;
  mutf8String:utf8String;

  //Logo專用變數
  procedure SetXYOption(x, y: integer);
  var
    x1,y1:integer;
  begin
    x1 := x div 256 ;
    InvPrinter.SendCOMString(AnsiChar(27)+AnsiChar(36)+AnsiChar(x)+AnsiChar(x1));

    y1 := y div 256 ;
    InvPrinter.SendCOMString(AnsiChar(29)+AnsiChar(36)+AnsiChar(y)+AnsiChar(y1) );

  end;
begin
    xName := (TPOSButton(Sender)).Name;

    with InvPrinter do
    begin
        if xName = 'btFF' then
            xResult := FF
        else
        if xName = 'btLF' then
            xResult := LF(1)
        else
        if xName = 'btDrawer' then
            xResult := OpenCashDrawer
        else
        if xName = 'btPrint' then
            SendString(Edit1.Text)
        else
        if xName = 'btStamp' then
            xResult := Stamp
        else
        if xName = 'btCutPaper' then
            xResult := CutPaper
        else
        if xName = 'btValid' then
        begin
          //PRINT #1, CHR$(&H1B);"f";CHR$(15);CHR$(20);
          //PRINT #1, CHR$(&H1B);"c0";CHR$(4); ← Select paper type
          xResult := SendComString(#27 + 'c0' + #8 + '這是認證時所列印的認證資料ABCD' + #10);
            //xResult := Valid(Edit1.Text)
        end
        else
        if xName = 'btBarcode' then
        begin
            xResult := PrintBarcode(Edit1.Text);
            //GS h n #29 #104, n //條碼高度
            //GS w n #29 #119, n //條碼寬度 def: 3   Max words 17
            //GS k m d1...dk #29 #107 #69(39code)    //列印條碼
            //xResult := SendCOMString(#29#104#70#13#29#119#2#13#29#107#69 + char(Length(Edit1.Text)) + pchar(Edit1.Text)+char(13));
            //xResult := SendString(Edit1.Text);
        end
        else
        if xName = 'btLogo' then
        begin
          //xResult := Logo
          for I := 1 to 10 do
            SendComString(#28#112+AnsiChar(i)+#0);
        end else
        if xName = 'UpLoadImage' then
        begin
          //因為這個比較麻煩需要CALL外部DLL 故此不加入元件段
          InvPrinter.DisConnect;
          sleep(1000);
          InvPrinter.Connect;
          if OpenDialog.Execute then begin
            if OpenDialog.Files.Count > 0 then
            begin
              SendComString(#28#113+AnsiChar(OpenDialog.Files.Count));
              for j := 1 to OpenDialog.Files.Count do
              begin
                If Length(OpenDialog.Files[j-1]) > 4 then
                begin
                  s_lngTargetHeight := 0;   s_lngTargetWidth:=0;
                  StatusBar.Panels.Items[1].Text := '上傳中，請勿關閉';
                  APPLICATION.ProcessMessages;
                  s_strFileName := OpenDialog.Files[j-1];
                  s_lngReturn := getImageSize(s_strFileName, s_lngTargetHeight, s_lngTargetWidth);
                  If s_lngReturn > 0 Then
                  begin
                    SetLength(s_bufNV, s_lngReturn);
                    getNVBitImage(s_bufNV[0], s_lngTargetHeight, s_lngTargetWidth, s_strFileName);

                    s_lngTargetWidth := s_lngTargetWidth DIV 8;
                    s_lngTargetHeight:= s_lngTargetHeight DIV 8; {+AnsiChar(cb9.ItemIndex+1)}
                    SendComString(Ansichar(s_lngTargetWidth MOD 256)+Ansichar(s_lngTargetWidth DIV 256)
                                  +Ansichar(s_lngTargetHeight MOD 256)+Ansichar(s_lngTargetHeight DIV 256));

                    for i:= low(s_bufNV) to high(s_bufNV) do
                      SendComString(Ansichar(s_bufNV[i]));
                  end else
                  begin
                    xResult := False;
                    Showmessage('找不到WPOCmd.dll');
                  end;
                end;
              end;

              if s_lngReturn > 0 then
                xResult := SendComString(#29#7#2#1#1);  //BB聲
            end;
          end;
        end
        else
        if xName = 'ClearImage' then
        begin
          SendComString(#28#113#0);
        end
        else
        if xName = 'btQR' then
        begin
          if not (PrinterType in [RP_600, PP8000, EPSON_TM88IV]) then //20130529 modi by 01753 for RP01-20130520001
          begin
            SendCOMString(#27#64);
            SendCOMString(#27#2);
            //設定邊界
            SendCOMString(#29#76#10#0);    //位移  左邊保留0.6
            SendCOMString(#29#87#114#1);   //位移  右邊保留0.6

            //公司名
            SendCOMString(AnsiChar(27)+AnsiChar(97)+AnsiChar(1)+AnsiChar(13));
            SendCOMString(AnsiChar(29)+AnsiChar(33)+AnsiChar(1)+AnsiChar(13));
            SendString('1+2+3測試公司');
            //SendCOMString(#27#74#5#13);
            //發票Title
            SendCOMString(#27#69#1);     //粗體
            SendCOMString(#29#33#17);    //放大兩倍
            SendString('電子發票證明聯');
            SendCOMString(#27#100#1);
            SendString('102年05-06月');
            SendCOMString(#27#100#1);
            SendString('ET-00008888');
            SendCOMString(#27#69#0);     //解除粗體
            SendCOMString(#29#33#0);     //字體恢復
            SendCOMString(AnsiChar(27)+AnsiChar(97)+AnsiChar(0)+AnsiChar(13));
            SendCOMString(AnsiChar(29)+AnsiChar(33)+AnsiChar(0)+AnsiChar(13));

            SendString('');
            //日期
            if (PrinterType = WP_T810) then
              SendString(AnsiFormat('%s', [FormatDateTime('yyyy/mm/dd hh:nn:ss', NOW)]))  ;

            SendString('隨機碼:9999' + '         ' + '總計:' + FloattoStr(99990));
            SendString('賣方:' + '28682266'+ '    ' +'買方:' + '28682266');


            if (PrinterType = WP_T810) then
            begin
              PrintBarcode3('12345678901234657');
              SendCOMString(#27#74#5#13);
              PrintQRcode2014('0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000', 0,0);
              PrintQRcode2014('000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000', 132,2);

              SendCOMString(#27#100#3);
            end else begin
              SendString( '                     ■     ■');
              SendString('');
              PrintBarcode2('1234567890123465789');
            end;

            xResult := SendCOMString(#11#13);
            LF(1);
            cutpaper;
          end else
          begin
            SendCOMString(#27#64);                    //初始化
            if (PrinterType in [PP8000, EPSON_TM88IV]) then
            begin
              //SendCOMString(#27#87#0#0#0#0#10#2#250#4);  //紙張長度因無法預估我將它設於 90 +  10 * 256
              SendCOMString(AnsiChar(29)+AnsiChar(33)+AnsiChar(1)+AnsiChar(13));
              SendString(CenterStr(Ansicopy('1+2+3測試公司', 1, 32), 32));
              SendCOMString(#27#69#1);     //粗體
              SendCOMString(#29#33#17);    //放大兩倍

              SendString(CenterStr('電子發票證明聯',16));
              SendString(CenterStr('102年05-06月',16));
              SendString(CenterStr('ET-00008888',16));
              SendCOMString(#27#69#0);     //解除粗體
              SendCOMString(#29#33#0);     //字體恢復

              SendCOMString(AnsiChar(29)+AnsiChar(33)+AnsiChar(0)+AnsiChar(13));
              //日期
              SendString(AnsiFormat('%s', [FormatDateTime('yyyy-mm-dd hh:nn:ss', NOW)]));
              SendString('隨機碼:' + ZeroAtFirst(9999, 4) + '           ' + '總計:' + FloattoStr(99990));
              SendString('賣方:' + '28682266');
              PrintBarcode3('12345678901234567');
              SendCOMString(#27#76);                    //PageMode
              SendCOMString(#27#87#0#0#0#0#174#1#200#1);
              SetXYOption(10,30);
              PrintQRcode2014('AT000001181030124494100005208000056220000000053918022tz1wJDL5mPwiUP5FZZeW6g==:*********:5:7:1:', 0, 0);
              SetXYOption(210,30);
              mutf8String:= UTF8Encode('**烏迪爾:1:3,150:烏迪爾:1:3,150:             ');
              PrintQRcode2014(mutf8String, 132, 2);
              EndPageMode;
            end else
            if (PrinterType = RP_600) then
            begin
              {
              SendCOMString(#27#87#0#0#0#0#10#2#200#4);  //紙張長度因無法預估我將它設於 90 +  10 * 256
              SendCOMString(AnsiChar(29)+AnsiChar(33)+AnsiChar(1)+AnsiChar(13));
              SetXYOption(0,100);
              SendString(CenterStr(Ansicopy('1+2+3測試公司', 1, 32), 32));
              //SendCOMString(#27#69#1);     //粗體
              SendCOMString(#29#33#17);    //放大兩倍

              //SendCOMString(AnsiChar(29)+AnsiChar(33)+AnsiChar(1)+AnsiChar(13));

              SetXYOption(0,220);
              SendString(CenterStr('電子發票證明聯',16));
              SetXYOption(0,370);
              SendString(CenterStr('102年05-06月',16));
              SetXYOption(10,520);
              SendString(CenterStr('ET-00008888',15));
              //SendCOMString(#27#69#0);     //解除粗體
              SendCOMString(#29#33#0);     //字體恢復

              SendCOMString(AnsiChar(29)+AnsiChar(33)+AnsiChar(0)+AnsiChar(13));
              //日期
              SetXYOption(10,590);
              SendString(AnsiFormat('%s', [FormatDateTime('yyyy-mm-dd hh:nn:ss', NOW)]));
              SetXYOption(10,650);
              SendString('隨機碼:' + ZeroAtFirst(9999, 4) + '           ' + '總計:' + FloattoStr(99990));
              SetXYOption(10,710);
              SendString('賣方:' + '28682266');

              SetXYOption(10,830);
              PrintBarcode3('12345678901234567');                                                                             //拉姆斯:2:6300
              SetXYOption(10,850);
              PrintQRcode2014('AT000000221020812167000002ee0000031380000000022554466K6T1ER8Jz4MuKduIE4Ygpw==:**********:1:5:1:拉姆斯:2:6300:', 0,0);
              SetXYOption(220,850);
              PrintQRcode2014('**:拉姆斯:2:6300', 132,2);
              EndPageMode;
              }

              SendCOMString(AnsiChar(29)+AnsiChar(33)+AnsiChar(1)+AnsiChar(13));
              SendString(CenterStr(Ansicopy('1+2+3測試公司', 1, 32), 32));
              SendCOMString(#27#100#1);
              SendCOMString(#29#33#17);    //放大兩倍
              SendString(CenterStr('電子發票證明聯',16));
              SendCOMString(#27#100#1);
              //發票Title
              SendString(CenterStr('102年05-06月',16));
              SendCOMString(#27#100#1);
              SendString(CenterStr('ET-00008888',15));
              SendCOMString(#27#100#1);
              SendCOMString(#29#33#0);     //字體恢復
              //日期
              SendString(AnsiFormat('%s', [FormatDateTime('yyyy-mm-dd hh:nn:ss', NOW)]));
              SendString('隨機碼:' + ZeroAtFirst(9999, 4) + '           ' + '總計:' + FloattoStr(99990));
              SendString('賣方:' + '28682266');


              SendCOMString(#27#100#1);
              PrintBarcode3('12345678901234567');

              SendCOMString(#27#76);                     //PageMode
              SendCOMString(#27#87#0#0#0#0#174#1#24#1);
              SetXYOption(0,30);
              PrintQRcode2014('AT000000221020812167000002ee0000031380000000022554466K6T1ER8Jz4MuKduIE4Ygpw==:**********:1:5:1:拉姆斯:2:6300:', 0,0);
              SetXYOption(210,30);
              PrintQRcode2014('**:拉姆斯:2:6300', 132,2);

              SendCOMString(AnsiChar(27)+AnsiChar(97)+AnsiChar(0)+AnsiChar(13)) ;
              SendCOMString(#27#74#10#13);
              SendString('店號:' + 'H01001 機號:001');
              SendString('退換貨請攜帶電子發票辦理');

              SendComString(#13#29#86#66#16);

            end;
            SendCOMString(#29#76#8#0);     //位移  左邊保留0.5
            SendCOMString(#29#87#114#1);   //位移  右邊保留0.5
            cutpaper;
          end;
        end;
    end;

    if xResult then
        CheckStatus(3, 1)
    else
        CheckStatus(3, 0);
end;

procedure TfrmDeviceTest.Button16Click(Sender: TObject);
begin
 { try
    with HandyScan do
    begin
        Port         := TDevicePort(ComboBox7.ItemIndex);
        UniName      := Edit7.Text;
        HandyScanner := TBarCodeScannerType(ComboBox4.ItemIndex);
        if Connect then
            CheckStatus(1, 2)
        else
            CheckStatus(0, 2);
    end;
    Label26.Caption := '';
  except
    CheckStatus(0, 0);
  };
end;

procedure TfrmDeviceTest.Button15Click(Sender: TObject);
begin
    HandyScan.DisConnect;
    CheckStatus(0, 2);
end;

procedure TfrmDeviceTest.FormCreate(Sender: TObject);
const
  mEND = #13#10;
var
  i: integer;

begin
  FAdoOpened := false;
  for i := 0 to pcTest.PageCount - 1 do
  begin
      pcTest.Pages[i].TabVisible := false;
      pcTest.Pages[i].Visible    := false;
  end;
  TabSheet1.Visible := true;
  pcTest.ActivePageIndex := 0;
  //lbEDCMsg.Caption := '';
 { MessageBox(Self.Handle, '使用本測試程式須注意下列事項: '+ mEND + mEND +
                          '1. 請關閉所有使用到POS週邊程式 ' + mEND +
                          '2. 開啟POS週邊設備電源 ' + mEND +
                          '3. 測試完畢請關閉本測試程式 ' + mEND, '注意!', MB_OK); }

  //信用卡Port設定
  {cbEDCType.Items.Clear;
  for i := Low(StrEdcType) to High(StrEdcType) do
      cbEDCType.Items.Add(StrEdcType[i]);
  cbEDCBaudRate.ItemIndex     := 6;
  cbEDCParityCheck.ItemIndex  := 2;
  cbEDCDataBit.ItemIndex      := 2;
  cbEDCStopBit.ItemIndex      := 0;
  cbEDCType.ItemIndex         := 0;  }


  //初始發票機資料
  ComboBox3.Items.Clear;
  for i := Low(StrPrinterType) to High(StrPrinterType) do
    ComboBox3.Items.Add(StrPrinterType[i]);

  ComboBox3.ItemIndex := 0;

  //初始Display 機型資料
  {ComboBox5.Items.Clear;
  for i := Low(StrDisplayerType) to High(StrDisplayerType) do
    ComboBox5.Items.Add(StrDisplayerType[i]);

  //初始掃描器
  ComboBox4.Items.Clear;
  for i := Low(StrBarCodeScannerType) to High(StrBarCodeScannerType) do
    ComboBox4.Items.Add(StrBarCodeScannerType[i]);

  //初始信用卡機型
  cbEDCType.Items.Clear;
  for i := Low(StrEdcType) to High(StrEdcType) do
    cbEDCType.Items.Add(StrEdcType[i]);    }
  FPtrBufferHead := TStringList.Create;
  FPtrBuffer := TStringList.Create;
  Memo1.Clear;

  if DebugHook = 1 then
  begin
    edComp.Text := 'OOOO有限公司';
    edUniNo.Text := '12345678';
    edExcelPath.Text := 'C:\123.xlsx';
  end
  else
  begin
    edComp.Text := '';
    edUniNo.Text := '';
    edExcelPath.Text := '';
  end;
end;

procedure TfrmDeviceTest.BitBtn1Click(Sender: TObject);
begin
    pcTest.ActivePageIndex := 0;
end;

procedure TfrmDeviceTest.ckInvPrinterStatusClick(Sender: TObject);
begin
  InvPrinter.CheckLPTStatus := ckInvPrinterStatus.Checked;
end;

procedure TfrmDeviceTest.POSSpeedButton1Click(Sender: TObject);
begin
    pcTest.ActivePageIndex := 0;
end;

procedure TfrmDeviceTest.POSSpeedButton2Click(Sender: TObject);
begin
    pcTest.ActivePageIndex := 1;
end;

procedure TfrmDeviceTest.POSSpeedButton3Click(Sender: TObject);
begin
    pcTest.ActivePageIndex := 2;
end;

procedure TfrmDeviceTest.POSSpeedButton4Click(Sender: TObject);
begin
    Close;
end;

procedure TfrmDeviceTest.InvPrinterPtrError(Sender: TObject; Msg: String;
  ErrorCode: Integer; var Retry: Boolean);
begin
  Retry := MessageBox(Application.Handle, PChar(Msg), PChar('Error! :' + IntToStr(ErrorCode)),
                      MB_YESNO + MB_DEFBUTTON1) <> IDNo;
end;

procedure TfrmDeviceTest.KeyHook1HookKeyUpEvent(Sender: TObject;
  ScanCode: Cardinal; Key: AnsiChar; KeyState: TShiftState);
var
  mKeyState: string;
  mKeyStr: string;
begin
  mKeyState := '';
  if ssShift in KeyState then
    mKeyState := mKeyState + 'S';

  if ssAlt in KeyState then
    mKeyState := mKeyState + 'A';

  if ssCtrl in KeyState then
    mKeyState := mKeyState + 'C';

  case Key of
    #13: mKeyStr := 'Enter';
    #27: mKeyStr := 'ESC';
    #9: mKeyStr := 'TAB';
    else
      mKeyStr := '';
  end;

  //Memo1.Lines.Add(Format('ScanCode: [%d], Key: [%s], Char:[%s], KeyState: [%s]',[ScanCode, IntToStr(integer(Key)), iif(IsEmpty(mKeyStr), iif(integer(key) <> 0, key, ''), mKeyStr), mKeyState]));
  //Edit9.Text := Edit9.Text + iif(IsEmpty(mKeyStr), Key, '[' + mKeyStr + ']');
end;

procedure TfrmDeviceTest.cdInvPrinterDefaultResetClick(Sender: TObject);
begin
  InvPrinter.DefaultReset := cdInvPrinterDefaultReset.Checked;
end;

procedure TfrmDeviceTest.POSButton1Click(Sender: TObject);
var
  i_addr: longint;
  mName: string;
  SockAddrIn: TSockAddrIn;
  HostEnt: PHostEnt;
  WSAData: TWSAData;
begin
 { if edIPAddr.Text = '' then exit;
  try
    StatusBar.Panels.Items[0].Text := '測試中....';
    StatusBar.Panels.Items[1].Text := '';
    Application.ProcessMessages;
    WSAStartup($0101, WSAData);
    i_addr:= inet_addr(PAnsiChar(AnsiString(edIPAddr.Text)));
    HostEnt := gethostbyaddr(@i_addr, sizeOf(i_addr), AF_INET);
    if HostEnt <> nil then
    begin
        mName := HostEnt.h_name;
        StatusBar.Panels.Items[1].Text := mName;
    end
    else
        StatusBar.Panels.Items[1].Text := '無法取得主機名稱!';
    StatusBar.Panels.Items[0].Text := '完成';
  finally
    WSACleanup;
  end; }
end;

procedure TfrmDeviceTest.POSSpeedButton5Click(Sender: TObject);
begin
    pcTest.ActivePageIndex := 3;
end;

procedure TfrmDeviceTest.POSButton2Click(Sender: TObject);
var
  mSQLConnection: string;
begin
 { mSQLConnection := format('Provider=SQLOLEDB.1;' +
                            'Persist Security Info=False;' +
                            'Use Procedure for Prepare=1;' +
                            'Use Encryption for Data=False;' +
                            'Data Source=%s;' +                   //Server IP /Host Name;
                            'Initial Catalog=%s;' +               //DB Name
                            'User ID=%s;' +                       //User ID
                            'Password=%s;' +                      //User Pas
                            'Packet Size=%d;' +                   //Size=4096;
                            'Workstation ID=%s;' +                //Local Host Name
                            'Application Name=%s;' +              //Application Name;
                            'Connect Timeout=%s; ' +              //DB Connect Timeout
                            'Tag with column collation when possible=False',
                            [edSQLIP.Text, edSQLDBName.Text, edSQLID.Text, edSQLPass.Text, 4096, 'TestDevice',
                             Application.Title, '20']);
  adoQuery.ConnectionString := mSQLConnection;
  adoQuery.SQL.Text := 'select a.value_in_use ''min_mem'', b.value_in_use ''max_mem'' from ' +
                       '(select value_in_use from sys.configurations where configuration_id = 1543) a, ' +
                       '(select value_in_use from sys.configurations where configuration_id = 1544) b';
  try
    StatusBar.Panels.Items[0].Text := '連結中....';
    StatusBar.Panels.Items[1].Text := '';
    Application.ProcessMessages;
    adoQuery.Open;
    if adoQuery.RecordCount > 0 then
    begin
      FMinMem := adoQuery.FieldByName('min_mem').AsInteger;
      FMaxMem := adoQuery.FieldByName('max_mem').AsInteger;
      FAdoOpened := true;
      StatusBar.Panels.Items[1].Text := '連結成功!';
      edSQLMinMem.Text := IntToStr(FMinMem);
      edSQLMaxMem.Text := IntToStr(FMaxMem);
    end
    else
    begin
      FAdoOpened := false;
      StatusBar.Panels.Items[1].Text := '連結失敗!';
      edSQLMinMem.Text := '';
      edSQLMaxMem.Text := '';
    end;
    StatusBar.Panels.Items[0].Text := '完成';
    adoQuery.Close;
  except
    StatusBar.Panels.Items[0].Text := '完成';
    StatusBar.Panels.Items[1].Text := '連結失敗!';
  end;    }
end;

procedure TfrmDeviceTest.sbUniNameClick(Sender: TObject);
var
    mTmp: string;
begin
  if SelectDirectory('印表機', mTmp, true) then
    edUniName.Text := mTmp;
end;

function TfrmDeviceTest.GetEDCMsg(xType, xMsgID: integer): string;
begin
    if xType = 0 then //一般Msg
        case xMsgID of
            1:  Result := '請由刷卡機刷信用卡!';
            2:  Result := 'POS資料傳送中,請稍候';
            3:  Result := '等待EDC回應中!';
            4:  Result := 'EDC回應接收成功!';
            5:  Result := '接收EDC資料中!';
            6:  Result := 'EDC資料接收成功!';
        end
    else
    if xType = 1 then //錯誤訊息
        case xMsgID of
            1:  Result := '刷卡機連線失敗!';
            2:  Result := '刷卡機資料傳送失敗!';
            3:  Result := 'EDC回應接收有誤!';
            4:  Result := 'EDC資料接收失敗';
        end
    else
    if xType = 2 then //授權訊息
        case xMsgID of
            0:  Result := '[0000]授權成功! 卡號: %s';
            1:  Result := '[0001]EDC授權失敗!';
            2:  Result := '[0002]EDC失敗請電銀行!';
            3:  Result := '[0003]其他訊息:';
        end;

end;

function TfrmDeviceTest.getImageSize(p_pstrSourceFile: Ansistring; var p_lngHeight,
  p_lngWidth: Integer): LongInt;
type
  TGetImageSize = function(var p_lngHeight, p_lngWidth:LongInt; p_pstrSourceFile:Ansistring):LongInt; stdcall;
var
  Lib : THandle;
  GetImageSize:TGetImageSize;
begin
  Lib := LoadLibrary('WPOCmd.dll');
  if Lib <> 0 then
  begin
    GetImageSize := GetProcAddress(Lib, 'getImageSize');
    if Assigned(@GetImageSize) then
    begin
      Result:= GetImageSize(p_lngHeight , p_lngWidth, p_pstrSourceFile);
    end;
  end;
end;

function TfrmDeviceTest.getNVBitImage(const config; p_lngHeight,
                            p_lngWidth: Integer; p_pstrSourceFile: AnsiString): LongInt;
type
  TGetNVBitImage = function(const config; p_lngHeight, p_lngWidth: Integer;
                            p_pstrSourceFile: AnsiString): LongInt; stdcall;
var
  Lib : THandle;
  GetNVBitImage:TGetNVBitImage;
begin
  Lib := LoadLibrary('WPOCmd.dll');
  if Lib <> 0 then
  begin
    GetNVBitImage := GetProcAddress(Lib, 'getNVBitImage');
    if Assigned(@GetNVBitImage) then
    begin
      Result:= GetNVBitImage(config, p_lngHeight , p_lngWidth, p_pstrSourceFile);
    end;
  end;
end;

procedure TfrmDeviceTest.HandyScanGetData(Sender: TObject; Data: AnsiString;
  DataLength: Integer);
begin
    //Label26.Caption := Data;
end;

procedure TfrmDeviceTest.POSSpeedButton6Click(Sender: TObject);
begin
  pcTest.ActivePageIndex := 4;
  FSuspend := true;
end;

procedure TfrmDeviceTest.POSButton3Click(Sender: TObject);
var
  mResult: boolean;
begin
 { FSuspend := POSButton3.Caption = '取消';
  POSButton3.Caption := '取消';
  EDCCom.EDCType  := TEdcType(cbEDCType.ItemIndex);
  EDCCom.Port     := TDevicePort(cbEDCPort.ItemIndex);
  EDCCom.BaudRate := TBaudRateType(cbEDCBaudRate.ItemIndex);
  EDCCom.ParityCheck := TParityCheckType(cbEDCParityCheck.ItemIndex);
  EDCCom.DataBits := TDataBitsType(cbEDCDataBit.ItemIndex);
  EDCCom.StopBits := TStopBitsType(cbEDCStopBit.ItemIndex);
  lbEDCMsg.Caption := '';
  try
    EDCCom.SendToEDC('01',                                 //交易代號
                     ZeroAtFirst(edEDCAmt.Text, 10) + '00',//交易金額
                     '000000',                             //店號
                     '000000',                             //機號
                     '000000');                            //交易序號
  except
    CheckStatus(0, 0);
  end;  }
end;

procedure TfrmDeviceTest.POSButton4Click(Sender: TObject);
begin
  { TestSND.Port := TDevicePort(ComboBox8.ItemIndex);
   TestSND.Display := TDisplayerType(5);
   if TestSND.Connect then
     CheckStatus(1, 2)
   else
     CheckStatus(0, 2);  }
end;

procedure TfrmDeviceTest.POSButton5Click(Sender: TObject);
begin
{  TestSnd.DisConnect;
  CheckStatus(0, 2); }
end;

procedure TfrmDeviceTest.POSButton6Click(Sender: TObject);
var
  mStr: AnsiString;
begin
 { mStr := AnsiString(Edit10.Text) + IIF(ckLF.Checked, #13#10, #13);
  TestSnd.NoCommand(mStr);   }
end;

procedure TfrmDeviceTest.EDCComEDCError(Sender: TObject;
  ErrorCode: Integer; var Suspend: Boolean);
begin
  {lbEDCMsg.Caption := GetEDCMsg(1, ErrorCode);
  lbEDCMsg.Update;
  POSButton3.Caption := '測試傳送';
  FSuspend := true;}
end;

procedure TfrmDeviceTest.EDCComEDCMsg(Sender: TObject; MsgCode,
  Second: Integer; var Suspend: Boolean);
begin
 { lbEDCMsg.Caption := Format('%s : %d', [GetEDCMsg(0, MsgCode), EDCCom.EDCTimeOut - Second]);
  lbEDCMsg.Update;
  Application.ProcessMessages;
  Suspend := FSuspend;  }
end;

procedure TfrmDeviceTest.EDCComGetEDC(Sender: TObject;
  CardValue: CREDITCARD);
begin
 { FSuspend := true;
  if CardValue.Response <> '0000' then //授權不成功
  begin
      lbEDCMsg.Caption := iif(CardValue.Response = '0001', GetEDCMsg(2, 1), //'EDC授權失敗!';
                          iif(CardValue.Response = '0002', GetEDCMsg(2, 2), //'EDC失敗請電銀行!';
                          iif(CardValue.Response = '0003', GetEDCMsg(2, 3), CardValue.Response)));//'其他代號!';
  end
  else
  if CardValue.Response = '0000' then //接收並授權成功
  begin
    lbEDCMsg.Caption := format(GetEDCMsg(2, 0), [CardValue.Card_no]);
    ShowMessage('銀行別:' + CardValue.Host_id + #$a#$d +
                '卡  別:' + CardValue.Card_Name + #$a#$d +
                '授權碼:' + CardValue.Auth_no + #$a#$d +
                '卡  號:' + CardValue.Card_no + #$a#$d +
                '序  號:' + CardValue.Ref_no + #$a#$d +
                '回應碼:' + CardValue.Response);
  end;
  POSButton3.Caption := '測試傳送'; }
end;

procedure TfrmDeviceTest.btnExcelPathClick(Sender: TObject);
var
  openDialog : topendialog;    // Open dialog variable
begin
  // Create the open dialog object - assign to our open dialog variable
  openDialog := TOpenDialog.Create(self);

  // Set up the starting directory to be the current one
  openDialog.InitialDir := GetCurrentDir;

  // Only allow existing files to be selected
  openDialog.Options := [ofFileMustExist];

  // Allow only .dpr and .pas files to be selected
  openDialog.Filter :=
    'Excel 檔案|*.xlsx;*.xls';

  // Select pascal files as the starting filter type
  openDialog.FilterIndex := 2;

  // Display the open file dialog
  if openDialog.Execute then
    edExcelPath.Text := openDialog.FileName;


  // Free up the dialog
  openDialog.Free;
end;

procedure TfrmDeviceTest.btnPrintClick(Sender: TObject);
var
  i: Integer;
  BoxNo: variant;
  MsExcel, MsExcelWorkBook, MsExcelWorkSheet: Variant;
  emptyCount:Integer;
  mDataCount:integer;
  ma,mb,mc,md,me,mf,mg,mh,mi,mj:string;
  mOldTaxNo,mNewTaxNo:string;
  mPrice:Double;
  mTotPrice:double;
  mTxNo:string;
  j: Integer;
begin
  if not FileExists(edExcelPath.Text) then
  begin
    ShowMessage('EXCEL 檔案不存在！');
    Exit;
  end;

  FPtrBufferHead.Clear;
  FPtrBuffer.Clear;
  Memo1.Clear;
  MsExcel := CreateOleObject('Excel.Application');
  //MsExcelWorkBook := msExcel.Workbooks.Open('f:\03.xls');
  MsExcelWorkBook := msExcel.Workbooks.Open(edExcelPath.Text);
  MsExcelWorkSheet := msExcel.Worksheets.Item[1];
  emptyCount := 0;
  try
    for i := 2 to MsExcelWorkSheet.UsedRange.Rows.Count do
    begin
      //for j := 1 to MsExcelWorkSheet.usedrange.columns.count do
      begin
        //ma := MsExcelWorkSheet.UsedRange.Range['a' + IntToStr(i)].Value;
        ma := MsExcelWorkSheet.Cells[i,1].Value;
        if Trim(ma) <> '' then
        begin
          {mb := MsExcelWorkSheet.Cells[i,1]].Value;
          mc := MsExcelWorkSheet.UsedRange.Range['c' + IntToStr(i)].Value;
          md := MsExcelWorkSheet.UsedRange.Range['d' + IntToStr(i)].Value;
          me := MsExcelWorkSheet.UsedRange.Range['e' + IntToStr(i)].Value;
          mf := MsExcelWorkSheet.UsedRange.Range['f' + IntToStr(i)].Value;
          mg := MsExcelWorkSheet.UsedRange.Range['g' + IntToStr(i)].Value;
          mh := MsExcelWorkSheet.UsedRange.Range['h' + IntToStr(i)].Value;
          mi := MsExcelWorkSheet.UsedRange.Range['i' + IntToStr(i)].Value;
          mj := MsExcelWorkSheet.UsedRange.Range['j' + IntToStr(i)].Value;}
          mb := MsExcelWorkSheet.Cells[i,2].Value;
          mc := MsExcelWorkSheet.Cells[i,3].Value;
          md := MsExcelWorkSheet.Cells[i,4].Value;
          me := MsExcelWorkSheet.Cells[i,5].Value;
          mf := MsExcelWorkSheet.Cells[i,6].Value;
          mg := MsExcelWorkSheet.Cells[i,7].Value;
          mh := MsExcelWorkSheet.Cells[i,8].Value;
          mi := MsExcelWorkSheet.Cells[i,9].Value;
          mj := MsExcelWorkSheet.Cells[i,10].Value;
          {if Trim(mOldTaxNo) <> Trim(mj) then //發票號碼不同要印下一筆
          begin

          end;}
          mTxNo := md;
          mPrice := StrToFloatDef(mh,1)*strtofloatdef(mi,0);
          mTotPrice := mTotPrice + mPrice;
          Inc(mDataCount);
          FPtrBuffer.Add(mg);
          FPtrBuffer.Add(AnsiFormat('%11s%10s %2s',['X '+mh,FloatToStr(mPrice),'TX']));

        end
        else
        begin
          Inc(emptyCount);
          if emptyCount >= 3 then
          begin
            Break;
          end;
        end;
      end;
    end;

    if mDataCount > 0 then
    begin
      FPtrBuffer.Add('總計: $'+AnsiFormat('%8s',[floattostr(mTotPrice)]));
      FPtrBuffer.Add('現金: $'+AnsiFormat('%8s',[floattostr(mTotPrice)]));
      FPtrBuffer.Add('');
      FPtrBuffer.Add('');
      GOPrint(mTxNo);
    end;
  except
    showmessage('資料讀取發生錯誤!!');
  end;
  MsExcel.Quit;
end;

procedure TfrmDeviceTest.GOPrint(xTxNO:string);
var
  mStr:string;
  i: Integer;
begin
  mStr := AnsiFormat('%16s %2s%5s', [
  FormatDateTime( 'yyyy/mm/dd hh:nn',  Now),'', xTxNO]);

  FPtrBufferHead.Add(CenterStr(edComp.Text,24));
  FPtrBufferHead.Add(CenterStr('統編:'+edUniNo.Text,24));
  FPtrBufferHead.Add('');
  FPtrBufferHead.Add(mStr);

  for i := 0 to FPtrBufferHead.Count-1 do
  begin
    Memo1.Lines.Add(FPtrBufferHead[i]);
  end;

  for i := 0 to FPtrBuffer.Count-1 do
  begin
    Memo1.Lines.Add(FPtrBuffer[i]);
  end;

  with InvPrinter do
  begin
    if not CheckConnected then
    begin
      ShowMessage('發票機未連線!');
      exit;
    end;

    for i := 0 to FPtrBufferHead.Count-1 do
    begin
      //Memo1.Lines.Add(FPtrBufferHead[i]);
      SendString(FPtrBufferHead[i]);
    end;

    for i := 0 to FPtrBuffer.Count-1 do
    begin
      //Memo1.Lines.Add(FPtrBuffer[i]);
      SendString(FPtrBuffer[i]);
    end;

    FF;
  end;
end;

procedure TfrmDeviceTest.btnSQLChangeMemClick(Sender: TObject);
begin
 { if FAdoOpened then
  begin
    if MessageBox(Self.Handle, '注意!! 即將變更SQL Server限制使用記憶體空間! '+ #13#10 +
                               '設定完成必須重新啟動SQL Server!!' + #13#10 +
                               '確定執行嗎?', '警告', MB_YESNO + MB_DEFBUTTON2) = ID_YES then
    begin
      try
        adoQuery.Close;
        adoQuery.SQL.Text := 'EXEC sys.sp_configure N''show advanced options'', N''1''  RECONFIGURE WITH OVERRIDE';
        adoQuery.ExecSQL;

        adoQuery.Close;
        adoQuery.SQL.Text := format('EXEC sys.sp_configure N''min server memory (MB)'', N''%d'' ', [StrToIntDef(edSQLMinMem.Text, FMinMem)]);
        adoQuery.ExecSQL;

        adoQuery.Close;
        adoQuery.SQL.Text := format('EXEC sys.sp_configure N''max server memory (MB)'', N''%d'' ', [StrToIntDef(edSQLMaxMem.Text, FMaxMem)]);;
        adoQuery.ExecSQL;

        adoQuery.Close;
        adoQuery.SQL.Text := 'RECONFIGURE WITH OVERRIDE';
        adoQuery.ExecSQL;

        adoQuery.Close;
        adoQuery.SQL.Text := 'EXEC sys.sp_configure N''show advanced options'', N''0''  RECONFIGURE WITH OVERRIDE';
        adoQuery.ExecSQL;

        adoQuery.Close;
        adoQuery.SQL.Text := 'select a.value_in_use ''min_mem'', b.value_in_use ''max_mem'' from ' +
                             '(select value_in_use from sys.configurations where configuration_id = 1543) a, ' +
                             '(select value_in_use from sys.configurations where configuration_id = 1544) b';
        Application.ProcessMessages;
        adoQuery.Open;
        if adoQuery.RecordCount > 0 then
        begin
          FMinMem := adoQuery.FieldByName('min_mem').AsInteger;
          FMaxMem := adoQuery.FieldByName('max_mem').AsInteger;
          FAdoOpened := true;
          edSQLMinMem.Text := IntToStr(FMinMem);
          edSQLMaxMem.Text := IntToStr(FMaxMem);
          StatusBar.Panels.Items[0].Text := '設定成功';
          StatusBar.Panels.Items[1].Text := '';
        end
      except
        on E: Exception do
        begin
          StatusBar.Panels.Items[0].Text := '執行失敗';
          StatusBar.Panels.Items[1].Text := E.Message;
        end;
      end;
    end;
  end
  else
  begin
    StatusBar.Panels.Items[0].Text := '未連結資料庫..';
    StatusBar.Panels.Items[1].Text := '';
  end;
       }
end;

procedure TfrmDeviceTest.cbEDCTypeChange(Sender: TObject);
begin
  //設定因機型不同而有不同設定
  {case cbEDCType.ItemIndex of
    0..1, 4, 5, 6: //H5000, S9000, SAGEM_CATHAY, NETPOS3000
      begin //9600, 7, E, 1
        cbEDCBaudRate.ItemIndex     := 6;
        cbEDCParityCheck.ItemIndex  := 2;
        cbEDCDataBit.ItemIndex      := 2;
        cbEDCStopBit.ItemIndex      := 0;
      end;
    2:    //SAGEM
      begin //19200, 7, E, 1
        cbEDCBaudRate.ItemIndex     := 8;
        cbEDCParityCheck.ItemIndex  := 2;
        cbEDCDataBit.ItemIndex      := 2;
        cbEDCStopBit.ItemIndex      := 0;
      end;
    3, 7:    //VX570_400
      begin //9600, 8, N, 1
        cbEDCBaudRate.ItemIndex     := 6;
        cbEDCParityCheck.ItemIndex  := 0;
        cbEDCDataBit.ItemIndex      := 3;
        cbEDCStopBit.ItemIndex      := 0;
      end;
  end;}
end;

procedure TfrmDeviceTest.POSSpeedButton7Click(Sender: TObject);
begin
  pcTest.ActivePageIndex := 5;
end;

procedure TfrmDeviceTest.Button3Click(Sender: TObject);
begin
  {Button3.Enabled := false;
  Button5.Click;
  KeyHook1.PreSysKeyUp := CheckBox1.Checked;
  KeyHook1.Enabled := true;
  Edit9.SetFocus;  }
end;

procedure TfrmDeviceTest.Button4Click(Sender: TObject);
begin
  {Button3.Enabled := true;
  KeyHook1.Enabled := false;
  Edit9.SetFocus; }
end;

procedure TfrmDeviceTest.Button5Click(Sender: TObject);
begin
 { Memo1.Lines.Clear;
  Edit9.Text := '';
  Edit9.SetFocus;}
end;

procedure TfrmDeviceTest.CheckBox1Click(Sender: TObject);
begin
  {Edit9.SetFocus; }
end;

procedure TfrmDeviceTest.cdInvCombineDspClick(Sender: TObject);
begin
  //SetInvCombineDsp(cdInvCombineDsp.Checked);
end;

procedure TfrmDeviceTest.SetInvCombineDsp(xValue: boolean);
begin
  if (InvPrinter.PortHandle > 0) or (not xValue) then
  begin
    {if (not xValue) and (Invprinter.PortHandle = Display.PortHandle) then
      Display.PortHandle := 0
    else
    if (xValue) and (Display.PortHandle = 0) then
    begin
      Display.Display := TDisplayerType(ComboBox5.ItemIndex);
      Display.PortHandle := InvPrinter.PortHandle;
      Display.SetDisplayerCommand;
      Display.Initial;
      Display.NoCommand(#27 + '=1' + #13); //enable printer, disable display
    end;}
  end;
end;

function TfrmDeviceTest.UTF8Bytes(const s: UTF8String): TBytes;
begin
  Assert(StringElementSize(s)=1);
  SetLength(Result, Length(s));
  if Length(Result)>0 then
    Move(s[1], Result[0], Length(s));
end;


end.

program DSCPOSDevice;

uses
  Forms,
  TestDeviceMain in 'TestDeviceMain.pas' {frmDeviceTest};

{$R *.res}


begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmDeviceTest, frmDeviceTest);
  Application.Run;
end.

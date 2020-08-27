program demo;

uses
  Vcl.Forms,
  frmMain in 'frmMain.pas' {MainForm},
  BinPacking.MaxRectsBinPack in '..\Source\BinPacking.MaxRectsBinPack.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.

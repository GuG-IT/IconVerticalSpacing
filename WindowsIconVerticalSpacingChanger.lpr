program WindowsIconVerticalSpacingChanger;

{$mode objfpc}{$H+}

uses
    {$IFDEF UNIX}{$IFDEF UseCThreads}
    cthreads,
    {$ENDIF}{$ENDIF}
    Interfaces, // this includes the LCL widgetset
    Forms, frmwindowsiconverticalspacingchangerunit
    { you can add units after this };

{$R *.res}

begin
    RequireDerivedFormResource := True;
    Application.Initialize;
	Application.CreateForm(TfrmIconVerticalSpacingChanger, 
		frmIconVerticalSpacingChanger);
    Application.Run;
end.


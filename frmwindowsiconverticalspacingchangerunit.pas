unit frmwindowsiconverticalspacingchangerunit;

{$mode objfpc}{$H+}

interface

uses
    Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

	{ TfrmIconVerticalSpacingChanger }

    TfrmIconVerticalSpacingChanger = class(TForm)
		btnSave: TButton;
		edtOwn: TEdit;
		rbtnWindows10: TRadioButton;
		rbtnWindows7: TRadioButton;
		rbtnOwn: TRadioButton;
		procedure btnSaveClick(Sender: TObject);
  procedure FormActivate(Sender: TObject);
		procedure rbtnOnChange(Sender: TObject);
    private
        function ReadIconVerticalSpacing: String;
        function WriteIconVerticalSpacing(IconVerticalSpacing: String): Boolean;
    public
        { public declarations }
    end;

var
    frmIconVerticalSpacingChanger: TfrmIconVerticalSpacingChanger;

implementation

{$R *.lfm}

uses
    Registry;

procedure TfrmIconVerticalSpacingChanger.FormActivate(Sender: TObject);
var
    IconVerticalSpacing: String;
begin
    IconVerticalSpacing := ReadIconVerticalSpacing;

    if IconVerticalSpacing = '-1710' then
    begin
        rbtnWindows10.Checked := true;
	end
    else if IconVerticalSpacing = '-1125' then
    begin
        rbtnWindows7.Checked := true;
	end
    else
    begin
        rbtnOwn.Checked := true;
        edtOwn.Text := IconVerticalSpacing;
	end;
end;

procedure TfrmIconVerticalSpacingChanger.btnSaveClick(Sender: TObject);
var
    IconVerticalSpacingInteger: Integer;
    IconVerticalSpacing: String;
begin
    if rbtnWindows10.Checked then
        IconVerticalSpacing := '-1710'
    else if rbtnWindows7.Checked then
        IconVerticalSpacing := '-1125'
    else
        IconVerticalSpacing := edtOwn.Text;

    IconVerticalSpacingInteger := StrToInt(IconVerticalSpacing);

    if (IconVerticalSpacingInteger > -480) or (IconVerticalSpacingInteger < -2730) then
    begin
        ShowMessage('Der angegebene Wert ist fehlerhaft. Er darf nur zwischen -480 und -2730 liegen.');
	end
	else
    begin
        if WriteIconVerticalSpacing(IconVerticalSpacing) then
            ShowMessage('Gespeichert. Melden Sie sich ab und wieder an, um die Änderungen zu sehen.')
        else
            ShowMessage('Die Änderungen konnten nicht gespeichert werden. Es ist ein Fehler aufgetreten.');
	end;
end;

procedure TfrmIconVerticalSpacingChanger.rbtnOnChange(Sender: TObject);
begin
    edtOwn.Enabled := rbtnOwn.Checked;
end;

function TfrmIconVerticalSpacingChanger.ReadIconVerticalSpacing: String;
var
    Registry: TRegistry;
begin
    ReadIconVerticalSpacing := '';

    Registry := TRegistry.Create;
    try
        Registry.RootKey := HKEY_CURRENT_USER;
        if Registry.OpenKeyReadOnly('\Control Panel\Desktop\WindowMetrics') then
            ReadIconVerticalSpacing := Registry.ReadString('IconVerticalSpacing');
	finally
        Registry.Free;
	end;
end;

function TfrmIconVerticalSpacingChanger.WriteIconVerticalSpacing(IconVerticalSpacing: String): Boolean;
var
    Registry: TRegistry;
begin
    WriteIconVerticalSpacing := false;

    Registry := TRegistry.Create;
    try
        Registry.RootKey := HKEY_CURRENT_USER;
        if Registry.OpenKey('\Control Panel\Desktop\WindowMetrics', true) then
            Registry.WriteString('IconVerticalSpacing', IconVerticalSpacing);
        WriteIconVerticalSpacing := true;
	finally
        Registry.Free;
	end;
end;

end.


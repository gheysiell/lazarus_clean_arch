unit TasksDetailsView;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,
  StdCtrls, EditBtn, TypeSaveEnum, TasksEntity, TasksStatusEnumUIMapper,
  TasksUseCase, LCLType;

type

  { TfrTasksDetails }

  TfrTasksDetails = class(TForm)
    cbStatus: TComboBox;
    deDate: TDateEdit;
    edID: TEdit;
    edDescription: TEdit;
    lbTitle: TLabel;
    lbID: TLabel;
    lbDescription: TLabel;
    lbDate: TLabel;
    lbStatus: TLabel;
    pnHeader: TPanel;
    pnBody: TPanel;
    pnFooter: TPanel;
    sbSave: TSpeedButton;
    sbCancel: TSpeedButton;
    procedure deDateKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edDescriptionKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edIDKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure sbCancelClick(Sender: TObject);
    procedure sbSaveClick(Sender: TObject);
  private
    TasksUseCase: TTasksUseCase;
    TypeSave: TTypeSave;
    TaskSelected: TTask;

    procedure Cancel;
    procedure Save;
    function CreateEntity: TTask;
    procedure FillFields;
  public
    procedure Open(
      ATypeSave: TTypeSave;
      ATask: TTask
    );
    procedure InitializeTasksUseCase(ATasksUseCase: TTasksUseCase);
  end;

var
  frTasksDetails: TfrTasksDetails;

implementation

{$R *.lfm}

{ TfrTasksDetails }

procedure TfrTasksDetails.InitializeTasksUseCase(ATasksUseCase: TTasksUseCase);
begin
  TasksUseCase := ATasksUseCase;
end;

procedure TfrTasksDetails.Open(
  ATypeSave: TTypeSave;
  ATask: TTask
);
begin
  TypeSave := ATypeSave;
  TaskSelected := ATask;

  FillFields;

  Self.ShowModal;
end;

procedure TfrTasksDetails.FillFields;
begin
  if (TypeSave = TTypeSave.tsCreate) then
  begin
    edID.Text := '0';
    edDescription.Text := '';
    deDate.Date := Date;
    cbStatus.ItemIndex := 0;
  end
  else
  begin
    edID.Text := TaskSelected.ID.ToString;
    edDescription.Text := TaskSelected.Description;
    deDate.Date := TaskSelected.Date;
    cbStatus.ItemIndex := cbStatus.Items.IndexOf(TaskStatusToLabel(TaskSelected.Status));
  end;
end;

procedure TfrTasksDetails.sbCancelClick(Sender: TObject);
begin
  Cancel;
end;

procedure TfrTasksDetails.FormShow(Sender: TObject);
begin
  edDescription.SetFocus;
end;

procedure TfrTasksDetails.edIDKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    edDescription.SetFocus;
end;

procedure TfrTasksDetails.edDescriptionKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    deDate.SetFocus;
end;

procedure TfrTasksDetails.deDateKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    cbStatus.SetFocus;
end;

procedure TfrTasksDetails.sbSaveClick(Sender: TObject);
begin
  Save;
end;

procedure TfrTasksDetails.Cancel;
begin
  Self.Close;
end;

procedure TfrTasksDetails.Save;
var
  Task: TTask;
  ActionSuccessFormatted: String;
  ActionErrorFormatted: String;
  ResultSave: Boolean = False;
begin
  try
    Task := CreateEntity;

    if (TypeSave = TTypeSave.tsCreate) then
    begin
      ResultSave := TasksUseCase.CreateTask(Task);
      ActionSuccessFormatted := 'criada';
      ActionErrorFormatted := 'criar';
    end
    else
    begin
      ResultSave := TasksUseCase.UpdateTask(Task);
      ActionSuccessFormatted := 'alterada';
      ActionErrorFormatted := 'alterar';
    end;

    if (ResultSave) then
    begin
      ShowMessage('Tarefa '+ ActionSuccessFormatted +' com sucesso.');
      Self.Close;
    end
    else
      ShowMessage('Erro ao '+ ActionErrorFormatted +' tarefa.');

  finally
    Task.Free;
  end;
end;

function TfrTasksDetails.CreateEntity: TTask;
var
  TaskCreated: TTask;
begin
  TaskCreated := TTask.Create;

  TaskCreated.ID := StrToInt(edID.Text);
  TaskCreated.Description := edDescription.Text;
  TaskCreated.Date := deDate.Date;
  TaskCreated.Status := LabelToTaskStatus(cbStatus.Items[cbStatus.ItemIndex]);

  Result := TaskCreated;
end;

end.


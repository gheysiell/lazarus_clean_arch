unit TasksListView;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons, fgl, Grids, TasksEntity, TasksUseCase, TasksDetailsView,TypeSaveEnum,
  TasksStatusEnumUIMapper, LCLType, LCLIntf;

type

  { TfrTasksList }

  TfrTasksList = class(TForm)
    lbTitle: TLabel;
    pnHeader: TPanel;
    pnBody: TPanel;
    pnFooter: TPanel;
    sbUpdateTask: TSpeedButton;
    sbCreateTask: TSpeedButton;
    sbDeleteTask: TSpeedButton;
    sgTasks: TStringGrid;
    procedure FormShow(Sender: TObject);
    procedure sbCreateTaskClick(Sender: TObject);
    procedure sbDeleteTaskClick(Sender: TObject);
    procedure sbUpdateTaskClick(Sender: TObject);
    procedure sgTasksDblClick(Sender: TObject);
    procedure sgTasksKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure sgTasksResize(Sender: TObject);
  private
    TasksUseCase: TTasksUseCase;

    function GetTaskOfGrid: TTask;
    procedure FillGrid(Tasks: specialize TFPGObjectList<TTask>);
    procedure GetTasksHandler;
    procedure CreateTaskHandler;
    procedure UpdateTaskHandler;
    procedure DeleteTaskHandler;
    function IsGridVerticalScrollBarVisible(
      Grid: TStringGrid
    ): Boolean;
  public
    procedure InitializeTasksUseCase(ATasksUseCase: TTasksUseCase);
  end;

var
  frTasksList: TfrTasksList;

implementation

{$R *.lfm}

{ TfrTasksList }

procedure TfrTasksList.InitializeTasksUseCase(ATasksUseCase: TTasksUseCase);
begin
  TasksUseCase := ATasksUseCase;
end;

procedure TfrTasksList.FormShow(Sender: TObject);
begin
  GetTasksHandler;
end;

procedure TfrTasksList.GetTasksHandler;
var
  Tasks: specialize TFPGObjectList<TTask>;
begin
  try
    Tasks := TasksUseCase.GetTasks;

    FillGrid(Tasks);
  finally
    Tasks.Free;
  end;
end;

procedure TfrTasksList.CreateTaskHandler;
begin
  frTasksDetails.Open(
    TTypeSave.tsCreate,
    Nil
  );

  GetTasksHandler;
end;

procedure TfrTasksList.UpdateTaskHandler;
var
  Task: TTask;
begin
  if (sgTasks.RowCount = 1) then
    Exit;

  try    
    Task := GetTaskOfGrid;

    frTasksDetails.Open(
      TTypeSave.tsUpdate,
      Task
    );

    GetTasksHandler;

  finally
    Task.Free;
  end;
end;

procedure TfrTasksList.DeleteTaskHandler;
var
  TaskID: Integer;
begin
  if (sgTasks.RowCount = 1) then
    Exit;

  TaskID := StrToInt(sgTasks.Cells[0, sgTasks.Row]);

  if QuestionDlg(
    'Atenção',
    'Deseja realmente excluir essa tarefa ?',
    mtCustom,
    [mrYes, 'Sim', mrNo, 'Cancelar'],
    ''
  ) = mrYes then
  begin
    if (TasksUseCase.DeleteTask(TaskID)) then
      ShowMessage('Tarefa excluída com sucesso.');

    GetTasksHandler;
  end;
end;

procedure TfrTasksList.FillGrid(Tasks: specialize TFPGObjectList<TTask>);
var
  I: Integer;
  Task: TTask;
begin
  sgTasks.RowCount := Tasks.Count + 1;

  for I := 0 to Tasks.Count - 1 do
  begin
    Task := Tasks[I];

    sgTasks.Cells[0, I + 1] := Task.ID.ToString();
    sgTasks.Cells[1, I + 1] := Task.Description;
    sgTasks.Cells[2, I + 1] := DateToStr(Task.Date);
    sgTasks.Cells[3, I + 1] := TaskStatusToLabel(Task.Status);
  end;

  sgTasks.Update;
end;

procedure TfrTasksList.sbCreateTaskClick(Sender: TObject);
begin
  CreateTaskHandler;
end;

procedure TfrTasksList.sbUpdateTaskClick(Sender: TObject);
begin
  UpdateTaskHandler;
end;

procedure TfrTasksList.sgTasksDblClick(Sender: TObject);
begin
  UpdateTaskHandler;
end;

procedure TfrTasksList.sgTasksKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_DELETE then
    DeleteTaskHandler;

  if Key = VK_RETURN then
    UpdateTaskHandler;
end;

procedure TfrTasksList.sgTasksResize(Sender: TObject);
var
  WidthOfColumns: Integer;
begin
  WidthOfColumns :=
    sgTasks.Columns[0].Width +
    sgTasks.Columns[2].Width +
    sgTasks.Columns[3].Width;

  if IsGridVerticalScrollBarVisible(sgTasks) then
    WidthOfColumns := WidthOfColumns + GetSystemMetrics(SM_CXVSCROLL);

  sgTasks.Columns[1].Width := Self.Width - WidthOfColumns;
end;

function TfrTasksList.IsGridVerticalScrollBarVisible(
  Grid: TStringGrid
): Boolean;
var
  I, TotalHeight: Integer;
begin
  TotalHeight := 0;

  for I := 0 to Grid.RowCount - 1 do
  begin
    TotalHeight := TotalHeight + Grid.RowHeights[I];
  end;

  Result := TotalHeight > Grid.ClientHeight;
end;

function TfrTasksList.GetTaskOfGrid: TTask;
var
  SelectedTask: TTask;
begin
  SelectedTask := TTask.Create;

  SelectedTask.ID := StrToInt(sgTasks.Cells[0, sgTasks.Row]);
  SelectedTask.Description := sgTasks.Cells[1, sgTasks.Row];
  SelectedTask.Date := StrToDateTime(sgTasks.Cells[2, sgTasks.Row]);
  SelectedTask.Status := LabelToTaskStatus(sgTasks.Cells[3, sgTasks.Row]);

  Result := SelectedTask;
end;

procedure TfrTasksList.sbDeleteTaskClick(Sender: TObject);
begin
  DeleteTaskHandler;
end;

end.


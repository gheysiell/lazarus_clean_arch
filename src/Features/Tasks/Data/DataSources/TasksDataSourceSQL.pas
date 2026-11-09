unit TasksDataSourceSQL;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, fgl, TasksEntity, DataModule, TasksStatusEnumDBMapper;

type
  TTasksDataSourceSQL = class
    public
      function GetTasks: specialize TFPGObjectList<TTask>;
      function CreateTask(Task: TTask): Boolean;
      function UpdateTask(Task: TTask): Boolean;
      function DeleteTask(TaskID: Integer): Boolean;
  end;

implementation

function TTasksDataSourceSQL.GetTasks: specialize TFPGObjectList<TTask>;
var
  Tasks: specialize TFPGObjectList<TTask>;
  Task: TTask;
begin
  Tasks := specialize TFPGObjectList<TTask>.Create(True);

  DM.ZQuery.SQL.Clear;
  DM.ZQuery.SQL.Add('SELECT t.id, t.description, t.date_time, t.status');
  DM.ZQuery.SQL.Add('FROM tasks t');
  DM.ZQuery.Open;

  DM.ZQuery.First;

  while not DM.ZQuery.EOF do
  begin
    Task := TTask.Create;

    Task.ID := DM.ZQuery.FieldByName('id').AsInteger;
    Task.Description := DM.ZQuery.FieldByName('description').AsString;
    Task.Date := DM.ZQuery.FieldByName('date_time').AsDateTime;
    Task.Status := StringToTaskStatus(DM.ZQuery.FieldByName('status').AsString);

    Tasks.Add(Task);

    DM.ZQuery.Next;
  end;

  Result := Tasks;
end;

function TTasksDataSourceSQL.CreateTask(Task: TTask): Boolean;
begin
  try
    DM.ZQuery.SQL.Clear;
    DM.ZQuery.SQL.Add('INSERT INTO tasks ');
    DM.ZQuery.SQL.Add('(description, date_time, status) VALUES');
    DM.ZQuery.SQL.Add('(:description, :date_time, :status);');
    DM.ZQuery.ParamByName('description').AsString := Task.Description;
    DM.ZQuery.ParamByName('date_time').AsDateTime := Task.Date;
    DM.ZQuery.ParamByName('status').AsString := TaskStatusToString(Task.Status);
    DM.ZQuery.ExecSQL;

    Result := True;
  except
    on E: Exception do
      Result := False;
  end;
end;

function TTasksDataSourceSQL.UpdateTask(Task: TTask): Boolean;
begin
  try
    DM.ZQuery.SQL.Clear;
    DM.ZQuery.SQL.Add('UPDATE tasks');
    DM.ZQuery.SQL.Add('SET description = :description,');
    DM.ZQuery.SQL.Add('date_time = :date_time,');
    DM.ZQuery.SQL.Add('status = :status');
    DM.ZQuery.SQL.Add('WHERE id = :id;');
    DM.ZQuery.ParamByName('id').AsInteger := Task.ID;
    DM.ZQuery.ParamByName('description').AsString := Task.Description;
    DM.ZQuery.ParamByName('date_time').AsDateTime := Task.Date;
    DM.ZQuery.ParamByName('status').AsString := TaskStatusToString(Task.Status);
    DM.ZQuery.ExecSQL;

    Result := True;
  except
    on E: Exception do
      Result := False;
  end;
end;

function TTasksDataSourceSQL.DeleteTask(TaskID: Integer): Boolean;
begin
  try
    DM.ZQuery.SQL.Clear;
    DM.ZQuery.SQL.Add('DELETE FROM tasks');
    DM.ZQuery.SQL.Add('WHERE id = :id;');
    DM.ZQuery.ParamByName('id').AsInteger := TaskID;
    DM.ZQuery.ExecSQL;

    Result := True;
  except
    on E: Exception do
      Result := False;
  end;
end;

end.


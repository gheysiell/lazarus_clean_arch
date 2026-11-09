unit TasksRepositoryImpl;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, fgl, TasksRepository, TasksDataSourceSQL, TasksEntity;

type
  TTasksRepositoryImpl = class(TInterfacedObject, ITasksRepository)
    private
      TasksDataSourceSQL: TTasksDataSourceSQL;
    public
      constructor Create(
        ATasksDataSourceSQL: TTasksDataSourceSQL
      );

      function GetTasks: specialize TFPGObjectList<TTask>;
      function CreateTask(Task: TTask): Boolean;
      function UpdateTask(Task: TTask): Boolean;
      function DeleteTask(TaskID: Integer): Boolean;
  end;

implementation

constructor TTasksRepositoryImpl.Create(
  ATasksDataSourceSQL: TTasksDataSourceSQL
);
begin
  TasksDataSourceSQL := ATasksDataSourceSQL;
end;

function TTasksRepositoryImpl.GetTasks: specialize TFPGObjectList<TTask>;
begin
  Result := TasksDataSourceSQL.GetTasks;
end;

function TTasksRepositoryImpl.CreateTask(Task: TTask): Boolean;
begin
  Result := TasksDataSourceSQL.CreateTask(Task);
end;

function TTasksRepositoryImpl.UpdateTask(Task: TTask): Boolean;
begin
  Result := TasksDataSourceSQL.UpdateTask(Task);
end;

function TTasksRepositoryImpl.DeleteTask(TaskID: Integer): Boolean;
begin
  Result := TasksDataSourceSQL.DeleteTask(TaskID);
end;

end.


unit TasksUseCase;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, fgl, TasksRepository, TasksEntity;

type
  TTasksUseCase = class
    public
      TasksRepository: ITasksRepository;

      constructor Create(
        ATasksRepository: ITasksRepository
      );

      function GetTasks: specialize TFPGObjectList<TTask>;
      function CreateTask(Task: TTask): Boolean;
      function UpdateTask(Task: TTask): Boolean;
      function DeleteTask(TaskID: Integer): Boolean;
  end;

implementation

constructor TTasksUseCase.Create(
  ATasksRepository: ITasksRepository
);
begin
  TasksRepository := ATasksRepository;
end;

function TTasksUseCase.GetTasks(): specialize TFPGObjectList<TTask>;
begin
  Result := TasksRepository.GetTasks();
end;

function TTasksUseCase.CreateTask(Task: TTask): Boolean;
begin
  Result := TasksRepository.CreateTask(Task);
end;

function TTasksUseCase.UpdateTask(Task: TTask): Boolean;
begin
  Result := TasksRepository.UpdateTask(Task);
end;

function TTasksUseCase.DeleteTask(TaskID: Integer): Boolean;
begin
  Result := TasksRepository.DeleteTask(TaskID);
end;

end.


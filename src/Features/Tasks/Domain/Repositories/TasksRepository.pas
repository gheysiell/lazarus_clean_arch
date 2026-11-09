unit TasksRepository;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, fgl, TasksEntity;

type
  ITasksRepository = interface
    function GetTasks: specialize TFPGObjectList<TTask>;
    function CreateTask(Task: TTask): Boolean;
    function UpdateTask(Task: TTask): Boolean;
    function DeleteTask(TaskID: Integer): Boolean;
  end;

implementation

end.


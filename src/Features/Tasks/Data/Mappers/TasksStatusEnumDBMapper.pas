unit TasksStatusEnumDBMapper;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, TasksStatusEnum;

function StringToTaskStatus(Value: String): TTaskStatus;
function TaskStatusToString(TaskStatus: TTaskStatus): String;

implementation

function StringToTaskStatus(Value: String): TTaskStatus;
begin
  case Value of
    'completed':
      Exit(TTaskStatus.tsCompleted);
    'pending':
      Exit(TTaskStatus.tsPending);
    else
      Exit(TTaskStatus.tsPending);
  end;
end;

function TaskStatusToString(TaskStatus: TTaskStatus): String;
begin
  case TaskStatus of
    TTaskStatus.tsCompleted:
      Exit('completed');
    TTaskStatus.tsPending:
      Exit('pending');
    else
      Exit('pending');
  end;
end;

end.


unit TasksStatusEnumUIMapper;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, TasksStatusEnum;

function LabelToTaskStatus(ALabel: String): TTaskStatus;
function TaskStatusToLabel(TaskStatus: TTaskStatus): String;

implementation

function LabelToTaskStatus(ALabel: String): TTaskStatus;
begin
  case ALabel.ToLower() of
    'concluída':
      Exit(TTaskStatus.tsCompleted);
    'pendente':
      Exit(TTaskStatus.tsPending);
    else
      Exit(TTaskStatus.tsPending);
  end;
end;

function TaskStatusToLabel(TaskStatus: TTaskStatus): String;
begin
  case TaskStatus of
    TTaskStatus.tsCompleted:
      Exit('Concluída');
    TTaskStatus.tsPending:
      Exit('Pendente');
    else
      Exit('Pendente');
  end;
end;

end.


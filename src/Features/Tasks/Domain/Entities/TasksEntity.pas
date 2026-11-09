unit TasksEntity;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, TasksStatusEnum;

type
  TTask = class
    public
      ID: Integer;
      Description: String;
      Date: TDateTime;
      Status: TTaskStatus;
  end;

implementation

end.


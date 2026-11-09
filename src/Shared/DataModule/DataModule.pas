unit DataModule;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ZConnection, ZDataset;

type

  { TDM }

  TDM = class(TDataModule)
    ZConnection: TZConnection;
    ZQuery: TZQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    procedure CreateDatabase;
    procedure CreateTable;
  public

  end;

var
  DM: TDM;

implementation

{$R *.lfm}

{ TDM }

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  ZConnection.HostName := 'localhost';
  ZConnection.User := 'root';
  ZConnection.Password := 'root';
  ZConnection.Port := 3306;
  ZConnection.Protocol := 'mariadb';
  ZConnection.LibraryLocation := ExtractFilePath(ParamStr(0)) + 'libmariadb.dll';
  ZConnection.Database := 'mysql';
  ZConnection.Connect;

  CreateDatabase;
  CreateTable;
end;

procedure TDM.CreateDatabase;
begin
  ZQuery.SQL.Clear;
  ZQuery.SQL.Add('CREATE DATABASE IF NOT EXISTS task;');
  ZQuery.ExecSQL;
end;

procedure TDM.CreateTable;
begin
  ZQuery.SQL.Clear;
  ZQuery.SQL.Add('USE task;');
  ZQuery.ExecSQL;

  ZQuery.SQL.Clear;
  ZQuery.SQL.Add('CREATE TABLE IF NOT EXISTS `tasks` (');
  ZQuery.SQL.Add('`id` INT(11) NOT NULL AUTO_INCREMENT,');
  ZQuery.SQL.Add('`description` VARCHAR(100) NOT NULL,');
  ZQuery.SQL.Add('`date_time` DATETIME NULL,');
  ZQuery.SQL.Add('`status` VARCHAR(20),');
  ZQuery.SQL.Add('PRIMARY KEY (`id`) USING BTREE');
  ZQuery.SQL.Add(');');
  ZQuery.ExecSQL;
end;

end.


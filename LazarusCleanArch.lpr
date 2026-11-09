program LazarusCleanArch;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, datetimectrls, zcomponent, TasksListView, TasksEntity, TasksUseCase,
  TasksRepository, TasksDetailsView, TasksStatusEnum, TypeSaveEnum,
  TasksRepositoryImpl, TasksDataSourceSQL, DataModule, ContainerDI,
  TasksStatusEnumUIMapper, TasksStatusEnumDBMapper
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  {$PUSH}{$WARN 5044 OFF}
  Application.MainFormOnTaskbar:=True;
  {$POP}
  Application.Initialize;
  Application.CreateForm(TfrTasksList, frTasksList);
  Application.CreateForm(TfrTasksDetails, frTasksDetails);
  Application.CreateForm(TDM, DM);
  TContainerDI.Initialize;
  Application.Run;
end.

